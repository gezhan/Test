'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Platform,
	NativeModules,
	Image
} from 'react-native'
// styles
import { General } from '../../style'
import AuthStyle from './style/AuthStyle'
// utils
import Jump from '../../utils/Jump'
import { toastShort } from '../../utils/ToastUtil'
import { HttpRequest, Types, Url } from '../../config'
import FunctionUtils from '../../utils/FunctionUtils'
// components
import ButtonHighlight from '../../components/ButtonHighlight'
import NavBarCommon from '../../components/NavBarCommon'
import Loading from '../../components/Loading'
import Cell from '../../components/Cell'
import Alert from '../../components/Alert'
// action
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { GetAuth } from '../../actions/AuthAction'

const Moxie = Platform.OS === 'ios' ? NativeModules.MoxiesdkModules : NativeModules.MoXieModule
@connect(
	state => ({
		baseInfo: state.baseInfo,
		authInfo: state.authInfo
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ GetAuth }, dispatch)
	})
)
export default class Auth extends Component {
	constructor (props) {
		super(props)
		this.state = {}
	}

	// 引流方法，isJudge为true就返回是否引流，false则显示引流弹窗
	isGoOther = (isJudge = true) => {
		const { authInfo } = this.props;
		if (isJudge) {
			return authInfo.IsPop
		} else {
			this.Alert.show();
		}
	}

	go = path => {
		if (!this.isGoOther()) {
			if (path !== 'PersonalInfo') {
				if (this.props.authInfo.IsBaseInfo !== 1) {
					toastShort('请先完成个人信息')
				} else {
					if (path === 'MobileAuth') {
						this.authMobile();
					} else if (path === 'ZMAuth') {
						this.getZM();
					} else {
						Jump.go(path, { updateAuth: this.CommonCallback })
					}
				}
			} else {
				Jump.go(path, { updateAuth: this.CommonCallback })
			}
		} else {
			this.isGoOther(false);
		}
	}

	CommonCallback = () => {
		this.loading.show()
		this.props.GetAuth(this);
	}

	// 判断运营商 用啥认证
	authMobile = () => {
		if (this.props.authInfo.MobileTag === '1') {
			// moxie
			this.getYDKey()
		} else if (this.props.authInfo.MobileTag === '2') {
			// tj
			this.getTJUrl()
		}
	}

	// 第一步 => 获取 TJ 的 Url
	getTJUrl = () => {
		this.loading.show()
		HttpRequest.request(Types.POST, Url.GET_TJURL)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200: {
							let param = {
								url: responseData.RedirectUrl,
								title: '运营商认证',
								updateAuth: this.CommonCallback,
								from: 'auth'
							}
							Jump.go('JSWebView', param)
							break
						}
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							responseData.Msg && toastShort(responseData.Msg);
							break
					}
				}
			})
			.catch(error => {
				this.loading.hide()
				console.log('error', error)
			})
	}

	// 第一步 => 获取 moxie 的key
	getYDKey = () => {
		this.loading.show()
		HttpRequest.request(Types.POST, Url.GET_MXKEY)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.runYDSDK(responseData.key)
							break
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							responseData.Msg && toastShort(responseData.Msg);
							break
					}
				}
			})
			.catch(error => {
				this.loading.hide()
				console.log('error', error)
			})
	}

	// 第二步 => 调用SDK
	runYDSDK = key => {
		const { baseInfo, authInfo } = this.props
		let sign = HttpRequest.isFormalServer() ? 'rrr' : 'rrd'
		let dic = {
			key: key,
			uid: sign + baseInfo.uid,
			type: 'carrier',
			name: authInfo.Sm.VerifyRealName,
			idcard: authInfo.Sm.IdCard,
			phone: baseInfo.account,
			agreementUrl: authInfo.OperateProtocol
		}
		if (Platform.OS === 'ios') {
			Moxie.moxie(dic, data => {
				console.log(data)
				this.UploadYDResult(data)
			})
		} else {
			Moxie.MoxieAuth(dic, (code, data) => {
				let obj = code !== 1000000 ? data : {
					code: data,
					taskType: 'carrier',
					taskId: '',
					message: '用户系统不支持',
					account: baseInfo.account,
					loginDone: false,
					businessUserId: ''
				}
				this.UploadYDResult(obj)
			})
		}
	}

	// 第三步 => 上传SDK回调数据
	UploadYDResult = data => {
		let params = {
			OperateTaskId: data.taskId || '',
			Code: parseInt(data.code),
			Message: data.message || ''
		}
		HttpRequest.request(Types.POST, Url.UPLOAD_MXYYS, params)
			.then(responseData => {
				this.loading && this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							// -1 安卓是取消
							if (data.code !== -1) {
								toastShort('运营商认证结果提交成功')
							}
							setTimeout(() => {
								this.props.GetAuth(this);
							}, 1000);
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
				this.loading && this.loading.hide()
				setTimeout(() => {
					this.props.GetAuth(this);
				}, 1000);
				console.log('error', error)
			})
	}

	getZM = () => {
		this.loading.show()
		HttpRequest.request(Types.POST, Url.ZM)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200: {
							if (responseData.AlipayUrl) {
								Jump.go('ZmAuth', {
									url: responseData.AlipayUrl,
									updateAuth: this.CommonCallback
								});
							} else {
								let param = {
									url: responseData.Param,
									title: '芝麻信用授权',
									updateAuth: this.CommonCallback,
									from: 'auth'
								}
								if (responseData.DirectSuccess) {
									param.isZmSuccess = true;
								}
								Jump.go('JSWebView', param)
							}
							break
						}
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
				this.loading.hide()
				console.log('error', error)
			})
	}

	submit = enable => {
		if (!this.isGoOther()) {
			this.loading.show();
			FunctionUtils.ShuMeiGetDeviceId(deviceId => {
				if (deviceId !== '' && (this.props.baseInfo.fingerKey !== '' && this.props.baseInfo.fingerKey.indexOf('RDFS') < 0)) {
					HttpRequest.request(Types.POST, Url.AUTH_SUBMIT, { SMDevFinger: deviceId })
						.then(responseData => {
							this.loading.hide()
							if (responseData.Ret) {
								switch (responseData.Ret) {
									case 200: {
										this.props.GetAuth(this)
										enable()
										toastShort('提交成功')
										break
									}
									case 408: {
										FunctionUtils.loginOut(responseData.Msg)
										enable();
										break
									}
									default: {
										enable();
										responseData.Msg && toastShort(responseData.Msg);
										break
									}
								}
							}
						})
						.catch(error => {
							this.loading.hide()
							enable();
							console.log('error', error)
						})
				} else {
					this.loading.hide()
					toastShort('功能初始化失败，请在后台关闭APP后重新打开，如有疑问，请联系在线客服。');
					enable();
				}
			});
		} else {
			this.isGoOther(false);
			enable();
		}
	}

	render () {
		const { authInfo, baseInfo } = this.props
		console.log(this.props.authInfo.InitAudit)
		let submitText = (authInfo.InitAudit === 1 || authInfo.InitAudit === 3 || authInfo.InitAudit === 9)
			? '授信审批中' : (authInfo.InitAudit === 7)
				? `${authInfo.RemainDays}天后可重新提交` : (authInfo.InitAudit === 4)
					? '已授信' : '提交';
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'信用认证'}/>
				<View style={AuthStyle.Title}>
					<Image style={AuthStyle.TitleImg} source={require('../../images/Home_Prompt.png')}/>
					<Text style={AuthStyle.TitleText}>为了获取更准确的报告，请确保以下信息真实</Text>
				</View>

				<Cell
					isFirst isLast
					title={'个人信息'}
					wrapperBtnStyle={General.mb20}
					value={authInfo.IsBaseInfo === 1 ? '已认证' : '未认证'}
					clickCell={() => this.go('PersonalInfo')}
					leftIcon1={require('../../images/Auth_Person.png')}/>
				<Cell
					isFirst isLast
					title={'紧急联系人'}
					wrapperBtnStyle={General.mb20}
					value={authInfo.IsLinkMan === 1 ? '已填写' : '未填写'}
					clickCell={() => this.go('EmergencyContact')}
					leftIcon1={require('../../images/Auth_Contacts.png')}/>
				<Cell
					isFirst isLast
					title={'手机运营商'}
					wrapperBtnStyle={General.mb20}
					value={authInfo.IsMobileAuth === 0 ? '未认证' : authInfo.IsMobileAuth === 1 ? '已认证' : authInfo.IsMobileAuth === 3 ? '认证中' : authInfo.IsMobileAuth === 4 ? '认证失败' : '未知'}
					clickCell={(authInfo.InitAudit === 0 && (authInfo.IsMobileAuth === 4 || authInfo.IsMobileAuth === 0)) ? () => this.go('MobileAuth') : null}
					leftIcon1={require('../../images/Auth_Mobile.png')}/>
				<Cell
					isFirst isLast
					title={'添加银行卡'}
					wrapperBtnStyle={General.mb20}
					value={authInfo.IsBindCard === 1 ? `${authInfo.BankInfo.BankName}(${authInfo.BankInfo.BankCard})` : '未绑定'}
					clickCell={authInfo.IsBindCard === 0 ? () => this.go('BindBankCard') : null}
					leftIcon1={require('../../images/Auth_BankCard.png')}/>
				{
					authInfo.ZmxyTag === '1' &&
					<Cell
						isFirst isLast
						title={'芝麻分授权'}
						value={authInfo.IsZmAuth === 1 ? '已认证' : authInfo.IsZmAuth === 9 ? '认证中' : '未认证'}
						clickCell={(authInfo.InitAudit === 0 && authInfo.IsZmAuth === 0) ? () => this.go('ZMAuth') : null}
						leftIcon1={require('../../images/Auth_ZM.png')}/>
				}
				{
					authInfo.InitAudit !== 5 &&
					<ButtonHighlight
						title={submitText}
						disabled={ !(FunctionUtils.isFinishAuth(authInfo) && FunctionUtils.isLogin(baseInfo) && authInfo.InitAudit === 0) }
						onPress={this.submit}
						buttonStyle={AuthStyle.Btn}/>
				}
				<Alert
					ref={ ref => { this.Alert = ref }}
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