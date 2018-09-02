'use strict';

import React, { Component } from 'react';

import {
	Platform,
	View,
	Text,
	Easing,
	Animated,
	InteractionManager,
	TouchableOpacity
} from 'react-native';
import { connect } from 'react-redux';
// actions
import { GetIpLocate, LoginData, LoginSuccess, FetchHome, FetchCenter } from '../../actions/BaseAction'
import { UpdateAuth } from '../../actions/AuthAction'
// styles
import { General, AppSizes, RatiocalHeight, RatiocalWidth } from '../../style';
import LoginStyle from './style/LoginStyle'
// utils
import { HttpRequest, Types, Url, DataAlgorithm, toastShort, FunctionUtils, Jump } from '../../config';
// views
import ButtonHighlight from '../../components/ButtonHighlight'
import GetCodeButton from '../../components/GetCodeButton'
import NavBarCommon from '../../components/NavBarCommon'
import CellInput from '../../components/CellInput'
import Loading from '../../components/Loading'

class Login extends Component {
	constructor (props) {
		super(props);
		this.bottomX = new Animated.Value(0);
		this.topX = new Animated.Value(0);
		this.state = {
			// 登录模式
			loginMode: props.baseInfo.loginMode === null ? 'quick' : props.baseInfo.loginMode,
			// 密码登录按钮X值
			pswX: props.baseInfo.pswLoginX !== 0 ? props.baseInfo.pswLoginX : 0,
			// 手机号
			tel: props.baseInfo.oldAccount,
			// 验证码
			code: '',
			// 账号
			account: props.baseInfo.oldAccount,
			// 密码
			pwd: '',

			getCodeTxt: '发送验证码',
			getCodeStyle: LoginStyle.codeBtnStyle,
			getCodeTxtStyle: LoginStyle.codeTxtStyle,
			getCodeDisabled: !props.baseInfo.oldAccount,
			submitBtnDisable: true
		};
	}

	componentDidMount = () => {
		InteractionManager.runAfterInteractions(() => {
			this.runAfterTimer = setTimeout(() => {
				!!this.runAfterTimer && clearTimeout(this.runAfterTimer);
				this.runAfterTimer = null;
				this.props.dispatch(GetIpLocate());
			}, 500);
		});
	};

	componentWillUnmount = () => {
		this.interval && clearInterval(this.interval);
	};

	pswLoginOnLayout (e) {
		const { baseInfo } = this.props;
		if (baseInfo.pswLoginX === 0) {
			let x = e.nativeEvent.layout.x;
			this.props.dispatch(LoginData({ pswLoginX: x }))
			this.setState({
				pswX: x
			}, () => {
				if (this.state.loginMode === 'psw') {
					this.topX.setValue(this.state.pswX);
					this.bottomX.setValue(-AppSizes.width);
				} else {
					this.topX.setValue(0);
					this.bottomX.setValue(0);
				}
			});
		} else {
			if (this.state.loginMode === 'psw') {
				this.topX.setValue(this.state.pswX);
				this.bottomX.setValue(-AppSizes.width);
			} else {
				this.topX.setValue(0);
				this.bottomX.setValue(0);
			}
		}
	}

	// renderCodeBtn = () => {
	// 	return (
	// 		<TouchableHighlight
	// 			style={this.state.getCodeStyle}
	// 			disabled={this.state.getCodeDisabled}
	// 			onPress={this.getCode}
	// 			activeOpacity={this.state.getCodeDisabled ? 1 : 0.8}>
	// 			<Text style={this.state.getCodeTxtStyle}>{this.state.getCodeTxt}</Text>
	// 		</TouchableHighlight>
	// 	)
	// };

	getCode = enable => {
		if (FunctionUtils.isMobileNo(this.state.tel)) {
			this.loading.show();
			HttpRequest.request(Types.POST, Url.GET_LOGIN_CODE, { Account: this.state.tel })
				.then(responseData => {
					this.loading.hide();
					switch (responseData.Ret) {
						case 200:
							toastShort('获取验证码成功');
							this.GetCodeButtonRef.countDown()
							!!this.pwdInput && this.pwdInput.focus();
							// this.setState({
							// 	getCodeDisabled: true,
							// 	getCodeStyle: [LoginStyle.codeBtnStyle, { borderColor: AppColors.ironColor }],
							// 	getCodeTxtStyle: [LoginStyle.codeTxtStyle, { color: AppColors.ironColor }],
							// 	getCodeTxt: '60s'
							// }, () => {
							// 	let timerCount = 60;
							// 	this.interval = setInterval(() => {
							// 		timerCount = timerCount - 1;
							// 		if (timerCount === 0) {
							// 			this.interval && clearInterval(this.interval);
							// 			this.interval = null;
							// 			this.setState({
							// 				getCodeTxt: '重新获取',
							// 				getCodeDisabled: this.interval !== null,
							// 				getCodeStyle: (this.interval === null) ? LoginStyle.codeBtnStyle : [LoginStyle.codeBtnStyle, { borderColor: AppColors.ironColor }],
							// 				getCodeTxtStyle: (this.interval === null) ? LoginStyle.codeTxtStyle : [LoginStyle.codeTxtStyle, { color: AppColors.ironColor }]
							// 			})
							// 		} else {
							// 			this.setState({
							// 				getCodeTxt: timerCount + 's'
							// 			})
							// 		}
							// 	}, 1000)
							// });
							break;
						default:
							enable()
							responseData.Msg && toastShort(responseData.Msg);
							break;
					}
				})
				.catch(error => {
					this.loading.hide();
					enable()
					console.log('error', error);
				});
		} else {
			toastShort('请输入正确的手机号');
			enable()
		}
	};

	changeTel = tel => {
		let disable = !(tel.length === 11 && (this.state.code !== '' && this.state.code.length === 4));
		this.setState({
			tel: tel,
			getCodeDisabled: !(tel.length === 11),
			submitBtnDisable: disable
		})
	};

	changeCode = code => {
		let disable = !(this.state.tel.length === 11 && (code !== '' && code.length === 4));
		console.log('submitBtnDisable：' + disable);
		this.setState({
			code: code,
			submitBtnDisable: disable
		})
	};

	changeAccount = account => {
		let disable = !(account.length === 11 && (this.state.pwd !== '' && this.state.pwd.length >= 6));
		this.setState({
			account: account,
			submitBtnDisable: disable
		})
	};

	changePwd = pwd => {
		let disable = !(this.state.account.length === 11 && (pwd !== '' && pwd.length >= 6));
		this.setState({
			pwd: pwd,
			submitBtnDisable: disable
		})
	};

	changWay = type => {
		if (type === 'tel') {
			let disable = !(this.state.tel.length === 11 && (this.state.code !== '' && this.state.code.length === 4));
			if (this.state.loginMode !== 'quick') {
				this.setState({
					loginMode: 'quick',
					submitBtnDisable: disable
				}, () => {
					if (this.actInput2 && this.actInput2.isFocused()) {
						this.actInput2.blur();
					} else if (this.pwdInput2 && this.pwdInput2.isFocused()) {
						this.pwdInput2.blur();
					}
					Animated.timing(this.topX, {
						toValue: 0,
						duration: AppSizes.width * 2,
						easing: Easing.bounce
					}).start();
					Animated.spring(this.bottomX, {
						toValue: 0,
						duration: AppSizes.width / 100 * 1000,
						easing: Easing.linear
					}).start();
				});
			}
		} else {
			let disable = !(this.state.account.length === 11 && (this.state.pwd !== '' && this.state.pwd.length >= 6));
			if (this.state.loginMode !== 'psw') {
				this.setState({
					loginMode: 'psw',
					submitBtnDisable: disable
				}, () => {
					if (this.actInput && this.actInput.isFocused()) {
						this.actInput.blur();
					} else if (this.pwdInput && this.pwdInput.isFocused()) {
						this.pwdInput.blur();
					}
					Animated.timing(this.topX, {
						toValue: (AppSizes.width - RatiocalWidth(60)) / 2,
						duration: AppSizes.width * 2,
						easing: Easing.bounce
					}).start();
					Animated.spring(this.bottomX, {
						toValue: -AppSizes.width,
						duration: AppSizes.width / 100 * 1000,
						easing: Easing.linear
					}).start();
				});
			}
		}
	};

	go = path => {
		let params = {};
		switch (path) {
			case 'Register':
				params.type = 'Register';
				Jump.go('Register', params);
				break;
			case 'Forget':
				params.type = 'Forget';
				Jump.go('Register', params);
				break;
		}
	};

	quickLogin = (params, enable) => {
		this.loading.show();
		HttpRequest.request(Types.POST, Url.LOGIN, params)
			.then(responseData => {
				this.loading.hide();
				switch (responseData.Ret) {
					case 200: {
						let BaseParams = {
							token: responseData.Token,
							uid: responseData.User.Id,
							account: this.state.tel,
							oldAccount: this.state.tel,
							loginMode: 'quick',
							loginState: true
						};
						let AuthParams = {
							VerifyRealName: responseData.UsersMetada.Verifyrealname,
							IdCard: responseData.UsersMetada.IdCard,
							Sex: responseData.UsersMetada.Sex
						}
						if (responseData.User.LoginPassword) {
							toastShort('登录成功');
							!!this.pwdInput && this.pwdInput.blur()
							this.props.dispatch(LoginSuccess(BaseParams));
							this.props.dispatch(UpdateAuth(AuthParams));
							FetchHome(this.props.dispatch);
							this.props.dispatch(FetchCenter());
							if (this.props.reload) {
								this.props.reload && this.props.reload();
								Jump.back('JSWebView');
							} else {
								Jump.backToTop();
							}
						} else {
							enable && enable();
							Jump.go('SetLoginPwd', { BaseParams, AuthParams })
						}
						break;
					}
					default: {
						enable && enable();
						!!responseData.Msg && toastShort(responseData.Msg);
						break;
					}
				}
			})
			.catch(error => {
				this.loading.hide();
				enable && enable();
				console.log('error', error);
			});
	};

	pswLogin = (params, enable) => {
		this.loading.show();
		HttpRequest.request(Types.POST, Url.CHECK_REGISTE, { Account: this.state.account })
			.then(responseData => {
				this.loading.hide();
				switch (responseData.Ret) {
					case 200: {
						enable && enable();
						toastShort('账号未注册，请注册');
						break;
					}
					case 500: {
						HttpRequest.request(Types.POST, Url.LOGIN, params)
							.then(responseData => {
								switch (responseData.Ret) {
									case 200: {
										let BaseParams = {
											token: responseData.Token,
											uid: responseData.User.Id,
											account: this.state.account,
											oldAccount: this.state.account,
											loginMode: 'psw',
											loginState: true
										};
										let AuthParams = {
											VerifyRealName: responseData.UsersMetada.Verifyrealname,
											IdCard: responseData.UsersMetada.IdCard,
											Sex: responseData.UsersMetada.Sex
										}
										!!this.pwdInput && this.pwdInput.blur()
										this.props.dispatch(LoginSuccess(BaseParams));
										this.props.dispatch(UpdateAuth(AuthParams));
										FetchHome(this.props.dispatch);
										this.props.dispatch(FetchCenter());
										toastShort('登录成功');
										if (this.props.reload) {
											this.props.reload && this.props.reload();
											Jump.back('JSWebView');
										} else {
											Jump.backToTop();
										}
										break;
									}
									default: {
										enable && enable();
										responseData.Msg && toastShort(responseData.Msg);
										break;
									}
								}
							}).catch(error => { console.log('error', error); });
						break;
					}
					default: {
						enable && enable();
						responseData.Msg && toastShort(responseData.Msg);
						break;
					}
				}
			})
			.catch(error => {
				enable && enable();
				this.loading.hide();
				console.log('error', error);
			});
	};

	login = enable => {
		const { baseInfo } = this.props;
		if ((!FunctionUtils.isMobileNo(this.state.tel) && this.state.loginMode === 'quick') ||
			(!FunctionUtils.isMobileNo(this.state.account) && this.state.loginMode === 'psw')) {
			toastShort('手机号格式错误，请重新输入');
			enable && enable();
			return;
		} else if (!FunctionUtils.isNumberOrLetter(this.state.pwd) && this.state.loginMode === 'psw') {
			enable && enable();
			toastShort('密码格式不正确');
			return
		} else if (!FunctionUtils.isNumberNo(this.state.code) && this.state.loginMode === 'quick') {
			enable();
			toastShort('验证码格式不对，请重新输入');
			return;
		}
		this.loading.show();
		FunctionUtils.getLocation(true, (isOpenLocation, isGetLocation, locationObj) => {
			let isGetLocat = isOpenLocation && isGetLocation;
			let params = {
				Jpushid: this.props.baseInfo.jPushId,
				Account: this.state.loginMode === 'psw' ? this.state.account : this.state.tel,
				LoginPassword: DataAlgorithm.Md5Encrypt(this.state.pwd),
				VerifyCode: this.state.code,
				LoginType: this.state.loginMode === 'psw' ? 0 : 1
			}
			params.IPProvince = this.props.baseInfo.IPProvince;
			params.IPCity = this.props.baseInfo.IPCity;
			params.Location = isGetLocat ? baseInfo.location : '';
			params.Address = isGetLocat ? baseInfo.locationDetail : '';
			params.LongitudeLatitude = isGetLocat ? baseInfo.longitudeAndLatitude : '';
			if (this.state.loginMode === 'psw') {
				this.pswLogin(params, enable);
			} else {
				this.quickLogin(params, enable);
			}
		});
	};

	render () {
		console.log('render');
		return (
			<View style={General.wrapViewWhite}>
				<NavBarCommon
					title="登录"
					leftAction={() => Jump.back()}
					rightTitle="注册"
					rightAction={() => this.go('Register')}
				/>
				<View>
					<View style={LoginStyle.tabWrapper}>
						<View style={LoginStyle.tabInner}>
							<Text style={[LoginStyle.tab]} onPress={() => this.changWay('tel')}>手机号快捷登录</Text>
							<Text
								style={[LoginStyle.tab]}
								onLayout={e => this.pswLoginOnLayout(e)}
								onPress={() => this.changWay('account')}>账号密码登录</Text>
							<Animated.View style={[LoginStyle.tabLine, { transform: [{ translateX: this.topX }] }]}/>
						</View>
					</View>
					<Animated.View style={[LoginStyle.scrollStyle, { transform: [{ translateX: this.bottomX }] }]}>
						<View style={LoginStyle.inputParentStyle}>
							<CellInput
								inputRef={ref => { this.actInput = ref }}
								leftTitle="手机号"
								placeholder={'请输入手机号'}
								maxLength={11}
								InputStyle={LoginStyle.inputStyle}
								keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
								value={this.state.tel}
								textChange={this.changeTel}
							/>
							<CellInput
								inputRef={ref => { this.pwdInput = ref }}
								maxLength={4}
								leftTitle="验证码"
								placeholder={'请输入验证码'}
								InputStyle={LoginStyle.inputStyle}
								// rightComponent={this.renderCodeBtn}
								keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
								value={this.state.code}
								textChange={this.changeCode} >
								<GetCodeButton
									ref={ref => { this.GetCodeButtonRef = ref }}
									title={'发送验证码'}
									onPress={this.getCode}
									disabled={this.state.getCodeDisabled}
								/>
							</CellInput>
						</View>
						<View style={LoginStyle.inputParentStyle}>
							<CellInput
								inputRef={ref => { this.actInput2 = ref }}
								maxLength={11}
								leftTitle="账号"
								placeholder={'请输入手机号'}
								InputStyle={LoginStyle.inputStyle}
								keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
								value={this.state.account}
								textChange={this.changeAccount}
							/>
							<CellInput
								inputRef={ref => { this.pwdInput2 = ref }}
								leftTitle="密码"
								placeholder={'请输入登录密码'}
								secureTextEntry={true}
								maxLength={20}
								InputStyle={LoginStyle.inputStyle}
								value={this.state.pwd}
								textChange={this.changePwd}
							/>
						</View>
					</Animated.View>
					{this.state.loginMode === 'psw' &&
					<TouchableOpacity
						style={LoginStyle.forgetPwdParent}
						activeOpacity={1}
						onPress={() => this.go('Forget')}>
						<Text style={LoginStyle.forgetPwd}>忘记密码?</Text>
					</TouchableOpacity>
					}
					<View style={[General.container, General.center]}>
						<ButtonHighlight
							title={'登录'}
							onPress={this.login}
							buttonStyle={[LoginStyle.submitBtn, this.state.loginMode === 'psw' && { marginTop: RatiocalHeight(60) }]}
							disabled={this.state.submitBtnDisable}
						/>
					</View>
					<Loading ref={ref => { this.loading = ref }}/>
				</View>
			</View>
		);
	}
}

function mapStateToProps (state) {
	const {
		baseInfo
	} = state;
	return {
		baseInfo
	}
}

export default connect(mapStateToProps)(Login);