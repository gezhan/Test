'use strict'

import React, { Component } from 'react'

import {
	View,
	Text,
	Image,
	Platform,
	StatusBar,
	ScrollView,
	DeviceEventEmitter,
	NativeModules,
	RefreshControl,
	NativeAppEventEmitter
} from 'react-native'
// redux
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
// action
import {
	GetIpLocate,
	SaveConfig,
	InitHome,
	InitJpush,
	FetchHome,
	LoginSuccess
} from '../../actions/BaseAction';
import { UpdateAuth } from '../../actions/AuthAction'
// util
import {
	Types,
	HttpRequest,
	Url,
	Jump,
	Storage,
	DeviceInfo,
	FunctionUtils,
	toastShort
} from '../../config'
// view
import ButtonHighlight from '../../components/ButtonHighlight'
import Loading from '../../components/Loading'
// style
import HomeStyle from './style/HomeStyle'
import { General, AppSizes, AppColors, RatiocalHeight } from '../../style'
import Alert from '../../components/Alert'
// components
import Cell from '../../components/Cell'
import NavBarCommon from '../../components/NavBarCommon'

const BqsDeviceModule = NativeModules.BqsDeviceModule;// 白骑士设备指纹

@connect(
	state => ({
		baseInfo: state.baseInfo,
		authInfo: state.authInfo,
		homeData: state.homeData
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({
			GetIpLocate,
			SaveConfig,
			InitHome,
			InitJpush,
			LoginSuccess,
			UpdateAuth
		}, dispatch)
	})
)
export default class Home extends Component {
	constructor (props) {
		super(props)
		this.state = {
			isRefreshing: false
		}
	}

	componentDidMount () {
		this.mCompleteRedux = DeviceEventEmitter.addListener('completeRedux', () => {
			Storage.getInit(callback => {
				if (FunctionUtils.isLogin(this.props.baseInfo)) {
					this.loading && this.loading.show();
					FunctionUtils.getLocation(this.props.baseInfo.isNeedLocation, (isOpenLocation, isGetLocation, locationObj) => {
						FunctionUtils.silentLogin(this.props.baseInfo, responseData => {
							if (responseData.Ret) {
								this.loading && this.loading.hide();
								switch (responseData.Ret) {
									case 200: {
										let BaseParams = {
											token: responseData.Token,
											uid: responseData.User.Id,
											account: this.props.baseInfo.account,
											oldAccount: this.props.baseInfo.account,
											loginMode: 'psw',
											loginState: true
										};
										let AuthParams = {
											VerifyRealName: responseData.UsersMetada.Verifyrealname,
											IdCard: responseData.UsersMetada.IdCard
										}
										this.props.LoginSuccess(BaseParams);
										this.props.UpdateAuth(AuthParams);
										this.props.GetIpLocate();
										this.showWelcomepage();
										break;
									}
									default:
										FunctionUtils.loginOut(responseData.Msg);
										this.props.GetIpLocate();
										this.showWelcomepage();
										break;
								}
							}
						});
					});
				} else {
					this.props.GetIpLocate();
					this.showWelcomepage();
				}
			});
			this.mCompleteRedux.remove();
			this.mCompleteRedux = null;
		});
		this.closeWelListen = DeviceEventEmitter.addListener('closeWel', () => {
			this.props.InitJpush();
			this.props.InitHome({ pointer: this });
			FunctionUtils.ShuMeiInit();
			this.getBqsDevice();
			this.closeWelListen.remove();
			this.closeWelListen = null;
		});
		DeviceEventEmitter.emit('HomeDidMount');
	}

	/* -------------------------------------- 初始化相关 -------------------------------------- */

	showWelcomepage = () => {
		let version = String(DeviceInfo.getVersion()).split('.').join('');
		let versionInt = parseInt(version);
		// let cashVersionInt = this.props.baseInfo.appVersion;
		// if (versionInt > cashVersionInt) {
		// 	DeviceEventEmitter.emit('showWel');
		this.props.SaveConfig({
			AppVersion: versionInt
		})
		// } else {
		this.props.InitJpush();
		this.props.InitHome({ pointer: this });
		FunctionUtils.ShuMeiInit();
		this.getBqsDevice();
		// }
	};

	// 获取白骑士反欺诈设备指纹
	getBqsDevice = () => {
		const { baseInfo } = this.props;
		// 初始化白骑士指纹SDK
		let params = {
			partnerId: 'zcmlc',
			isGatherContacts: false,
			isGatherCallRecord: false,
			isGatherGps: true,
			isGatherBaseStation: true,
			isGatherSensorInfo: true,
			isGatherInstalledApp: true,
			isTestingEnv: false
		};
		if (Platform.OS === 'ios') {
			BqsDeviceModule.init(params);
			this.subscription2 = NativeAppEventEmitter.addListener('BqsInit', results => {
				this.subscription2.remove();
				if (results.msg) {
					console.log('首页初始化白骑士反欺诈指纹tokenkey：' + results.msg);
					if (baseInfo.fingerKey !== '') {
						if (results.msg.indexOf('RDFS') < 0) {
							this.props.LoginSuccess({
								fingerKey: results.msg
							});
						}
					} else {
						this.props.LoginSuccess({
							fingerKey: results.msg
						});
					}
				}
			});
		} else {
			BqsDeviceModule.init(params, status => {
				if (status === true) {
					BqsDeviceModule.getBqsDevices(results => {
						if (results) {
							console.log('首页初始化白骑士反欺诈指纹tokenkey：' + results);
							if (baseInfo.fingerKey !== '') {
								if (results.indexOf('RDFS') < 0) {
									this.props.LoginSuccess({
										fingerKey: results
									});
								}
							} else {
								this.props.LoginSuccess({
									fingerKey: results
								});
							}
						}
					});
				}
			});
		}
	}

	renderBaseInfo = () => {
		let info = [
			{
				key: '姓名',
				value: (this.props.homeData.CreditScore > 0) ? this.props.homeData.UserInfo.Verifyrealname : '王大锤'
			},
			{
				key: '手机号',
				value: (this.props.homeData.CreditScore > 0) ? FunctionUtils.ensurePhone(this.props.homeData.UserInfo.Account) : '188****2313'
			},
			{
				key: '身份证',
				value: (this.props.homeData.CreditScore > 0) ? FunctionUtils.ensureIDNumber(this.props.homeData.UserInfo.IdCard) : '331082****123'
			}
		];
		return (
			info.map((item, index) => {
				return (
					<Cell
						key={index}
						isFirst={index === 0} isLast
						title={item.key} value={item.value}/>
				)
			})
		)
	}

	getReport = enable => {
		if (FunctionUtils.isLogin(this.props.baseInfo)) {
			this.loading && this.loading.show()
			HttpRequest.request(Types.POST, Url.AUTH)
				.then(responseData => {
					this.loading && this.loading.hide()
					if (responseData.Ret) {
						switch (responseData.Ret) {
							case 200: {
								let RemainDays = 0
								if (responseData.InitAudit === 7) {
									let closeTime = Date.parse(responseData.CloseTime) + responseData.CreditCloseDay * 24 * 60 * 60 * 1000
									closeTime = (closeTime - new Date(responseData.Currtime)) / 1000 / 60 / 60 / 24
									RemainDays = Math.ceil(closeTime)
								}
								this.props.UpdateAuth({
									VerifyRealName: responseData.VerifyRealName,
									IdCard: responseData.IdCard,
									IsOcr: responseData.IsOcr,
									IsRealName: responseData.IsRealName,
									IsLiving: responseData.IsLiving,
									FailTime: responseData.FailTime,

									BaseInfo: responseData.BaseInfo,
									IsBaseInfo: responseData.IsBaseInfo,
									IsMobileAuth: responseData.IsMobileAuth,
									IsBindCard: responseData.IsBindCard,
									BankInfo: responseData.BankInfo,

									InitAudit: responseData.InitAudit,
									IsLinkMan: responseData.IsLinkMan,
									MobileTag: responseData.MobileTag,
									IsZmAuth: responseData.IsZmAuth,
									ZmxyTag: responseData.ZmxyTag,

									RemainDays: RemainDays,
									CloseTime: responseData.CloseTime,
									CreditCloseDay: responseData.CreditCloseDay,
									Currtime: responseData.Currtime,

									OperateProtocol: responseData.OperateProtocol,

									IsPop: responseData.IsPop,
									PopUrl: responseData.PopUrl
								});
								let param = {
									IsZmAuth: responseData.IsZmAuth,
									ZmxyTag: responseData.ZmxyTag,
									IsBindCard: responseData.IsBindCard,
									IsMobileAuth: responseData.IsMobileAuth,
									IsLinkMan: responseData.IsLinkMan,
									IsBaseInfo: responseData.IsBaseInfo
								};
								if (FunctionUtils.isFinishAuth(param) && responseData.InitAudit > 0) {
									let params = {
										pointer: this,
										cbRefresh: data => {
											if (data.Ret && data.Ret === 200) {
												if (data.CreditValue === 5) {
													this.toDetail(enable);
												} else {
													Jump.go('ReportResult', {
														CreditValue: data.CreditValue,
														CreditAllow: data.CreditAllow,
														CreditUrl: data.CreditUrl,
														Skip: data.Skip,
														CreditButton: data.Home.CreditButton,
														CreditContent: data.Home.CreditContent,
														CreditTitle: data.Home.CreditTitle
													})
													enable();
												}
											} else {
												enable();
											}
										}
									}
									FetchHome(this.props.dispatch, params);
								} else {
									toastShort('请先完成信用认证!')
									DeviceEventEmitter.emit('changTab', 1);
									enable()
								}
								break
							}
							case 408:
								enable()
								FunctionUtils.loginOut(responseData.Msg)
								break
							default:
								enable();
								responseData.Msg && toastShort(responseData.Msg)
								break
						}
					}
				})
				.catch(error => {
					enable();
					this.loading && this.loading.hide()
					console.log('error', error)
				})
		} else {
			enable();
			Jump.go('Login')
		}
	}

	toDetail = enable => {
		this.loading && this.loading.show()
		HttpRequest.request(Types.POST, Url.REPORT_DETAIL)
			.then(responseData => {
				this.loading && this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200: {
							let param = {
								CreditAssess: responseData.CreditAssess,
								CreditLoan: responseData.CreditLoan,
								CreditRisk: responseData.CreditRisk,
								CreditScore: responseData.CreditScore,
								Loan: responseData.Loan,
								Skip: responseData.Skip,
								UsersMetada: responseData.UsersMetada,
								CreditDate: responseData.CreditDate,
								InitAudit: responseData.UsersMetada.InitAudit
							}
							Jump.go('ReportDetail', param)
							enable()
							break
						}
						case 408:
							enable()
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							enable()
							responseData.Msg && toastShort(responseData.Msg)
							break
					}
				}
			})
			.catch(error => {
				enable()
				this.loading && this.loading.hide()
				console.log('error', error)
			})
	}

	onRefresh = () => {
		this.setState({
			isRefreshing: true
		}, () => {
			FetchHome(this.props.dispatch, {
				cbRefresh: data => {
					this.setState({
						isRefreshing: false
					})
				}
			})
		})
	}

	render () {
		const { homeData, authInfo } = this.props;
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'首页'}/>
				<View style={HomeStyle.scrollParent}>
					<ScrollView
						style={HomeStyle.scrollView}
						refreshControl={
							<RefreshControl
								refreshing={this.state.isRefreshing}
								onRefresh={() => this.onRefresh()}
								tintColor={AppColors.mainColor}
								titleColor={AppColors.mainColor}
								colors={[AppColors.mainColor, AppColors.mainColor, AppColors.mainColor]}
							/>
						}
					>
						<View style={HomeStyle.creditHead}>
							<View style={HomeStyle.creditPanelView}>
								{homeData.HomeImg !== '' &&
								<Image
									source={{ uri: homeData.HomeImg }}
									style={ HomeStyle.creditPanelImg }>
									<Text
										style={[HomeStyle.creditScore, { color: homeData.CreditScore > 0 ? homeData.CreditScore < 400 ? AppColors.highRiskColor : homeData.CreditScore < 600 ? AppColors.mediumRiskColor : AppColors.lowRiskColor : AppColors.mediumRiskColor }]}>
										{(homeData.CreditScore > 0) ? homeData.CreditScore : 500}
									</Text>
									<Text
										style={[HomeStyle.creditLevel, { color: homeData.CreditScore > 0 ? homeData.CreditScore < 400 ? AppColors.highRiskColor : homeData.CreditScore < 600 ? AppColors.mediumRiskColor : AppColors.lowRiskColor : AppColors.mediumRiskColor }]}>
										{(homeData.CreditScore > 0) ? homeData.CreditScore < 400 ? '高风险' : homeData.CreditScore < 600 ? '中风险' : '低风险' : '中风险'}
									</Text>
								</Image>
								}
							</View>
							<Text style={HomeStyle.testTime}>
								{(homeData.CreditScore > 0) ? '评估时间：' + homeData.CreditDate : '评估时间：2018-06-29'}
							</Text>
						</View>
						<View style={HomeStyle.promptView}>
							<Image
								source={require('../../images/Home_Prompt.png')}
								style={HomeStyle.promptImg}
							/>
							<Text style={HomeStyle.promptText}>
								{(homeData.CreditScore > 0) ? homeData.CreditDesc : '准确真实的身份信息才能得出准确的信用报告结果'}
							</Text>
						</View>
						<View style={HomeStyle.exampleView}>
							{this.renderBaseInfo()}
							{
								(homeData.CreditScore === 0) &&
								<Image
									source={require('../../images/Home_Example_Report.png')}
									style={HomeStyle.exampleImg}
								/>
							}
						</View>
					</ScrollView>
				</View>
				<ButtonHighlight
					title={'获取我的信用报告'}
					buttonStyle={HomeStyle.Btn}
					onPress={this.getReport}/>
				<Alert
					ref={ref => {
						this.Alert = ref
					}}
					msg={'已为您推荐优质平台'}
					close={() => {
						Jump.go('JSWebView', { url: authInfo.PopUrl, notAdd: true })
					}}
				/>
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}