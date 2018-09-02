'use strict'
import React, { Component } from 'react'
import {
	View,
	Text,
	Platform,
	Image,
	NativeModules
} from 'react-native'
// redux
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
// action
import { UpdateRecord } from '../../actions/AuthAction'
import { GetLoan } from '../../actions/LoanAction'
import { GetIpLocate } from '../../actions/BaseAction';
// style
import General from '../../style/General';
import LoanApplicationStyle from './style/LoanApplicationStyle';
import { AppSizes, AppColors, RatiocalFontSize, RatiocalWidth, RatiocalHeight } from '../../style/index';
// component
import NavBarCommon from '../../components/NavBarCommon'
import Cell from '../../components/Cell'
import GeneralSelector from '../../components/GeneralSelector'
// utils
import { FunctionUtils, HttpRequest, DataAlgorithm, toastShort, Types, Url, Jump } from '../../config/index';
// view
import Loading from '../../components/Loading'
import ButtonHighlight from '../../components/ButtonHighlight'
import MyKeyboard from '../../components/MyKeyboard/index'
import GpsAlert from '../../components/GpsAlert'

// ios权限检测
const PermissionsDetect = Platform.OS === 'ios' ? NativeModules.PermissionsDetect : NativeModules.BqsDeviceModule

@connect(
	state => ({
		baseInfo: state.baseInfo,
		authInfo: state.authInfo,
		homeData: state.homeData
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ GetIpLocate, UpdateRecord, GetLoan }, dispatch)
	})
)
export default class LoanApplication extends Component {
	constructor (props) {
		super(props)
		this.Product = props.Product;// 产品数组
		this.Balance = props.Balance;// 借款额度
		this.CardInfo = props.CardInfo; // 银行卡信息
		this.CouponUse = props.CouponUse;// 优惠券数组
		this.UsableCoupon = props.UsableCoupon;// 可用优惠券数组
		this.CurrDate = props.CurrDate;// 系统当前时间
		this.Agreements = props.Agreements;// 借款协议数组
		this.PurposeList = props.Purposelist.split(','); // 消费用途
		this.state = {
			BankName: '',
			selectRow: 0,
			time: this.Product[0].Name,
			way: '请选择',
			payBack: (this.Balance * this.Product[0].LoanTaxFee * 100 * this.Product[0].LoanTermCount / 100 / 100 + this.Balance).toFixed(2) // 到期应还
		}
	}

	componentWillMount () {
		this.props.GetIpLocate();
	}

	selectTime = (rowData, sectionID, rowID) => {
		this.timeSelector && this.timeSelector.hidden();
		this.caculate(parseInt(rowID), {
			time: rowData.Name
		})
	}

	selectWay = rowData => {
		this.waySelector && this.waySelector.hidden();
		this.setState({ way: rowData })
	}

	caculate = (rowID, params) => {
		params.payBack = (this.Balance + this.Balance * this.Product[rowID].LoanTaxFee * 100 * this.Product[rowID].LoanTermCount / 100 / 100).toFixed(2);
		params.selectRow = rowID;
		this.setState(params);
	}

	AlertBtnClick = () => {
		this.Alert.hide()
		if (Platform.OS === 'ios') {
			PermissionsDetect.JumpSetting()
		} else {
			PermissionsDetect.openLocationSetting()
		}
	}

	submit = enable => {
		if (this.state.way === '请选择') {
			toastShort('请选择消费用途');
			enable();
			return
		}
		this.loading.show();
		HttpRequest.request(Types.POST, Url.LOAN_CONTROL)
			.then(responseData => {
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							if (responseData.Control === true) {
								HttpRequest.request(Types.POST, Url.ISEXIST_PAYPWD)
									.then(responseData => {
										console.log('检测是否设置交易密码');
										if (responseData.Ret) {
											switch (responseData.Ret) {
												case 200:
													this.submitCallSms(enable);
													break;
												case 404:
													enable();
													this.loading.hide();
													Jump.go('SetTradePwd1');
													break;
												case 408:
													this.loading.hide();
													FunctionUtils.loginOut(responseData.Msg);
													break;
												default:
													this.loading.hide();
													enable();
													responseData.Msg && toastShort(responseData.Msg);
													break;
											}
										}
									})
									.catch(error => {
										enable();
										this.loading.hide();
										console.log('error', error);
									});
							} else {
								this.loading.hide();
								enable();
								responseData.Msg && toastShort(responseData.Msg);
							}
							break;
						case 408:
							this.loading.hide();
							FunctionUtils.loginOut(responseData.Msg);
							break;
						default:
							this.loading.hide();
							enable();
							responseData.Msg && toastShort(responseData.Msg);
							break;
					}
				} else {
					this.loading.hide();
					enable();
				}
			})
			.catch(error => {
				enable();
				this.loading.hide();
				console.log('error', error);
			});
	}

	submitCallSms = enable => {
		FunctionUtils.getLocation(true, (isOpenLocation, isGetLocation, locationObj) => {
			if (isOpenLocation && isGetLocation) {
				FunctionUtils.getPhoneInfo((state, phoneIdentify, callList, smsList) => {
					if (Platform.OS === 'android') {
						if (state === true) {
							let isUploadRecords = (parseInt(Date.now()) - parseInt(String(this.props.authInfo.UpdateRecordsTime))) > 24 * 60 * 60 * 1000; // 是否一天内提交过记录
							if (isUploadRecords) {
								HttpRequest.request(Types.POST, Url.SUBMIT_CALLSMS, {
									CallRecords: callList,
									SmsRecords: smsList
								}).then(responseData => {
									console.log('提交通话记录、短信记录' + responseData.param);
									if (responseData.Ret) {
										switch (responseData.Ret) {
											case 200:
												this.props.UpdateRecord({
													UpdateRecordsTime: String(Date.now())
												});
												this.submitContact(enable)
												break;
											case 408:
												this.loading.hide();
												FunctionUtils.loginOut(responseData.Msg);
												break;
											default:
												this.submitContact(enable)
												responseData.Msg && toastShort(responseData.Msg);
												break;
										}
									}
								}).catch(error => {
									this.submitContact(enable)
									this.loading.hide();
									console.log('error', error);
								});
							} else {
								this.submitContact(enable)
							}
						} else {
							this.submitContact(enable)
						}
					} else {
						this.submitContact(enable);
					}
				})
			} else {
				this.loading.hide();
				enable();
				if (!isOpenLocation) {
					this.Alert.show({ msg: locationObj.msg })
				} else {
					locationObj.msg && toastShort(locationObj.msg);
				}
			}
		});
	}

	// 提交通讯录
	submitContact = enable => {
		this.loading.show();
		let isUploadContacts = (parseInt(Date.now()) - parseInt(this.props.authInfo.UpdateContactsTime)) > 24 * 60 * 60 * 1000;
		if (isUploadContacts) {
			FunctionUtils.getContacts(result => {
				console.log('获取通讯录回调', result)
				if (result.Ret === 200) {
					if (result.Data) {
						if (isUploadContacts) {
							HttpRequest.request(Types.POST, Url.UPDATE_MAILLIST, {
								Contact: result.Data,
								ContactType: 1
							})
								.then(responseData => {
									this.loading.hide();
									if (responseData.Ret) {
										switch (responseData.Ret) {
											case 200:
												this.keyboardRef && this.keyboardRef.enterAnimate();
												this.loading.hide();
												enable();
												break;
											case 408:
												FunctionUtils.loginOut(responseData.Msg);
												break;
											default:
												this.loading.hide();
												enable();
												responseData.Msg && toastShort(responseData.Msg);
												break;
										}
									} else {
										this.loading.hide();
										enable();
									}
								})
								.catch(error => {
									this.loading.hide();
									enable();
									console.log('error', error);
								});
						} else {
							this.keyboardRef && this.keyboardRef.enterAnimate();
							this.loading.hide();
							enable();
						}
					} else {
						this.loading.hide();
						enable();
						toastShort(`"通讯录"访问权限已关闭，请前往设置开启权限`);
					}
				} else if (result.Ret === 304) {
					this.loading.hide();
					enable();
					result.Msg && toastShort(result.Msg);
				}
			}, null, null, false)
		} else {
			this.keyboardRef && this.keyboardRef.enterAnimate();
			this.loading.hide();
			enable();
		}
	};

	pay = pwd => {
		this.loading.show();
		FunctionUtils.ShuMeiGetDeviceId(deviceId => {
			if (deviceId !== '' && (this.props.baseInfo.fingerKey !== '' && this.props.baseInfo.fingerKey.indexOf('RDFS') < 0)) {
				HttpRequest.request(Types.POST, Url.SUBMIT_RENT, {
					ProductId: this.Product[this.state.selectRow].Id,
					Money: this.Balance,
					VerifyTradePassword: DataAlgorithm.Md5Encrypt(pwd),
					BankcardID: this.CardInfo.Id,
					Location: this.props.baseInfo.location,
					Address: this.props.baseInfo.locationDetail,
					Purpose: this.state.way,
					LongitudeLatitude: this.props.baseInfo.longitudeAndLatitude,
					SMDevFinger: deviceId
				})
					.then(responseData => {
						this.loading.hide();
						if (responseData.Ret) {
							switch (responseData.Ret) {
								case 200:
									Jump.go('LoanSuccess', { LoanDesc: responseData.LoanDesc });
									break
								case 408:
									FunctionUtils.loginOut(responseData.Msg)
									break
								default:
									responseData.Msg && toastShort(responseData.Msg)
									break
							}
						}
					})
					.catch(error => {
						this.loading.hide();
						console.log('error', error);
					});
			} else {
				this.loading.hide()
				toastShort('功能初始化失败，请在后台关闭APP后重新打开，如有疑问，请联系在线客服。');
			}
		})
	};

	getBank = bankName => {
		this.setState({ BankName: bankName })
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'订单申请'} leftAction={() => Jump.back()}/>
				<View style={[LoanApplicationStyle.applyView, General.borderTop]}>
					<Text style={LoanApplicationStyle.applyMoneyTxt}>申请金额</Text>
					<View style={LoanApplicationStyle.applyMoneyView}>
						<Text style={LoanApplicationStyle.moneyCode}>￥</Text>
						<Text style={LoanApplicationStyle.applyMoney}>{this.Balance}</Text>
					</View>
				</View>
				<Cell
					isFirst isLast
					title={'申请期限'}
					value={this.state.time}
					clickCell={this.props.Product.length > 1
						? () => { !!this.timeSelector && this.timeSelector.show() }
						: null}
					wrapperBtnStyle={LoanApplicationStyle.applyCellWrapperStyle}/>
				<Cell
					isFirst={ false } isLast
					title={'还款方式'}
					value={'到期还款'}
					wrapperBtnStyle={LoanApplicationStyle.applyCellWrapperStyle}/>
				<Cell
					isFirst={ false } isLast
					title={'到期应还'}
					value={this.state.payBack}
					wrapperBtnStyle={LoanApplicationStyle.applyCellWrapperStyle}/>
				<Cell
					isFirst={ false } isLast
					title={'消费用途'}
					value={this.state.way}
					clickCell={this.PurposeList.length > 1
						? () => { !!this.waySelector && this.waySelector.show() }
						: null}
					wrapperBtnStyle={[LoanApplicationStyle.applyCellWrapperStyle, General.mb20]}/>
				<Cell
					isFirst isLast
					title={'收款银行卡'}
					value={this.CardInfo.BankName + '  尾号' + this.CardInfo.CardNumber.slice(-4) + this.state.BankName}
					wrapperBtnStyle={LoanApplicationStyle.applyCellWrapperStyle}
					rightIcon1={{ uri: this.CardInfo.LogoImage }}
					// clickCell={() => Jump.go('SelectBank', { getBank: this.getBank })}
				/>
				<ButtonHighlight
					title={'确定借款'}
					onPress={this.submit}
					buttonStyle={{
						marginTop: RatiocalHeight(50),
						marginRight: RatiocalWidth(30),
						marginLeft: RatiocalWidth(30)
					}}/>
				<Text style={{
					color: AppColors.grayColor,
					fontSize: RatiocalFontSize(24),
					textAlign: 'center',
					marginTop: RatiocalHeight(30)
				}} onPress={() => { this.AgreementsSelector.show() }}>
					我已阅读并同意
					<Text
						style={LoanApplicationStyle.contractText}
						suppressHighlighting={true}
						onPress={() => { this.AgreementsSelector.show(); }}>
						{'《借款服务相关合同》'}
					</Text>
				</Text>
				<GeneralSelector
					ref={ref => { this.timeSelector = ref }}
					cancelBtnVisible
					Key={'Name'}
					listData={this.props.Product}
					clickCell={this.selectTime}/>
				<GeneralSelector
					ref={ref => { this.waySelector = ref }}
					cancelBtnVisible
					listData={this.PurposeList}
					clickCell={this.selectWay}/>
				<GeneralSelector
					ref={ref => { this.AgreementsSelector = ref }}
					cancelBtnVisible
					Key={'AgeementName'}
					clickCell={rowData => {
						this.AgreementsSelector && this.AgreementsSelector.hidden();
						Jump.go('JSWebView', { url: rowData.AgreementUrl });
					}}
					listData={this.Agreements}/>
				<MyKeyboard
					ref={ref => { this.keyboardRef = ref }}
					payment={value => this.pay(value)}/>
				<GpsAlert
					ref={ ref => { this.Alert = ref }}
					btnText={'立即开启'}
					btnClick={this.AlertBtnClick} />
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}