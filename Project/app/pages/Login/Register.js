'use strict';

import React, { Component } from 'react';

import {
	Platform,
	View,
	Text,
	Animated,
	InteractionManager
} from 'react-native';
import { connect } from 'react-redux';
// actions
import { GetIpLocate, LoginSuccess } from '../../actions/BaseAction';
// import { initHome } from '../../actions/HomeAction';
// styles
import { General, AppSizes, AppColors, RatiocalHeight, RatiocalWidth, RatiocalFontSize } from '../../style';
import RegisterStyle from './style/RegisterStyle';
import LoginStyle from './style/LoginStyle';
// utils
import FunctionUtils from '../../utils/FunctionUtils';
import Jump from '../../utils/Jump'
// view
import ButtonHighlight from '../../components/ButtonHighlight';
import GetCodeButton from '../../components/GetCodeButton';
import NavBarCommon from '../../components/NavBarCommon';
import { toastShort } from '../../utils/ToastUtil';
import CellInput from '../../components/CellInput';
import { HttpRequest, Types, Url, DataAlgorithm } from '../../config';
import Loading from '../../components/Loading';

class Register extends Component {
	constructor (props) {
		super(props);
		this.bottomX = new Animated.Value(0);
		this.topX = new Animated.Value(0);
		this.state = {
			tel: '',
			code: '',
			pwd: '',
			invitCode: '',
			// 是否填写了验证码
			setInvitCode: false,
			isExist: false,
			btnText: this.props.type === 'Register' ? '注册' : '确定',
			notShowPwd: true,
			disabled: true,
			isShowReal: true
		};
	}

	componentDidMount = () => {
		InteractionManager.runAfterInteractions(() => {
			this.props.dispatch(GetIpLocate());
		});
	};

	calculate = () => {
		let bool = this.state.tel !== '' && this.state.code !== '' && this.state.pwd !== '' && this.state.pwd.length >= 6
		this.state.disabled = !bool
	};

	changeTel = tel => {
		if (!FunctionUtils.isNumberNo(tel)) {
			toastShort('手机号格式不正确')
			return
		}
		this.state.tel = tel;
		this.calculate();
		this.forceUpdate()
	};

	changeCode = code => {
		if (!FunctionUtils.isNumberNo(code)) {
			toastShort('验证码格式不正确')
			return
		}
		this.state.code = code;
		this.calculate();
		this.forceUpdate();
	};

	changePwd = pwd => {
		if (!FunctionUtils.isNumberOrLetter(pwd)) {
			toastShort('密码格式不正确')
			return
		}
		this.state.pwd = pwd;
		this.calculate();
		this.forceUpdate();
	};

	check (enable) {
		if (!FunctionUtils.isMobileNo(this.state.tel)) {
			toastShort('手机号不存在，请重新输入');
			enable && enable()
			return false;
		}
		if (this.props.type === 'Register') {
			HttpRequest.request(Types.POST, Url.REGIST_VCODE, { Account: this.state.tel })
				.then(responseData => {
					if (responseData.Ret) {
						switch (responseData.Ret) {
							case 200:
								toastShort('获取验证码成功');
								!!this.codeInput && this.codeInput.focus();
								this.GetCodeButtonRef.countDown();
								break;
							default:
								enable && enable();
								responseData.Msg && toastShort(responseData.Msg);
								break;
						}
					} else {
						enable && enable();
					}
				})
				.catch(error => {
					error && console.log('error', error);
				});
		} else {
			HttpRequest.request(Types.POST, Url.GET_FIND_VCODE, { Account: this.state.tel })
				.then(responseData => {
					if (responseData.Ret) {
						switch (responseData.Ret) {
							case 200:
								toastShort('获取验证码成功');
								!!this.codeInput && this.codeInput.focus();
								this.GetCodeButtonRef.countDown();
								break;
							default:
								enable && enable();
								responseData.Msg && toastShort(responseData.Msg);
								break;
						}
					}
				})
				.catch(error => {
					error && console.log('error', error);
				});
		}
	}

	codeSlot = () => {
		return (
			<GetCodeButton
				ref={ref => { this.GetCodeButtonRef = ref }}
				title={'发送验证码'}
				disabled={!(this.state.tel !== '' && this.state.tel.length === 11)}
				onPress={enable => this.check(enable)}
			/>
		)
	};

	submit = enable => {
		const { baseInfo } = this.props;
		if (!FunctionUtils.isMobileNo(this.state.tel)) {
			enable && enable();
			toastShort('手机号不存在，请重新输入');
			return false
		}
		if (!FunctionUtils.isNumberOrLetter(this.state.pwd)) {
			enable && enable();
			toastShort('密码格式不正确');
			return
		}
		switch (this.state.btnText) {
			case '注册':
				FunctionUtils.getLocation(true, (isOpenLocation, isGetLocation, locationObj) => {
					let isGetLocat = isOpenLocation && isGetLocation;
					let params = {
						Jpushid: this.props.baseInfo.jPushId,
						Account: this.state.tel,
						Vcode: this.state.code,
						LoginPassword: DataAlgorithm.Md5Encrypt(this.state.pwd)
					};
					params.IPProvince = this.props.baseInfo.IPProvince;
					params.IPCity = this.props.baseInfo.IPCity;
					params.Location = isGetLocat ? baseInfo.location : '';
					params.Address = isGetLocat ? baseInfo.locationDetail : '';
					params.LongitudeLatitude = isGetLocat ? baseInfo.longitudeAndLatitude : '';
					this.loading.show();
					HttpRequest.request(Types.POST, Url.REGISTERED, params)
						.then(responseData => {
							enable && enable();
							this.loading.hide();
							switch (responseData.Ret) {
								case 200: {
									let params = {
										token: responseData.Token,
										uid: responseData.Id,
										account: this.state.tel,
										oldAccount: this.state.tel,
										loginMode: 'psw',
										loginState: true
									};
									this.props.dispatch(LoginSuccess(params));
									// this.props.dispatch(initHome());
									Jump.backToTop(0);
									toastShort('注册成功');
									break;
								}
								default: {
									!!responseData.Msg && toastShort(responseData.Msg);
									break;
								}
							}
						})
						.catch(error => {
							enable && enable();
							this.loading.hide();
							console.log('error', error);
						});
				});
				break;
			case '确定': {
				this.loading.show();
				HttpRequest.request(Types.POST, Url.UPDAGE_LOGINPWD, {
					Account: this.state.tel,
					Type: 0,
					Vcode: this.state.code,
					Password: DataAlgorithm.Md5Encrypt(this.state.pwd)
				})
					.then(responseData => {
						enable();
						this.loading.hide();
						switch (responseData.Ret) {
							case 200: {
								Jump.back();
								toastShort('密码重置成功');
								break;
							}
							default: {
								responseData.Msg && toastShort(responseData.Msg);
								break;
							}
						}
					})
					.catch(error => {
						this.loading.hide();
						console.log('error', error);
					});
			}
		}
	};

	watchProtocol = () => {
		Jump.go('JSWebView', {
			url: (this.props.baseInfo.Agreement && this.props.baseInfo.Agreement.AgreementUrl) || '',
		})
	};

	render () {
		return (
			<View style={General.wrapViewWhite}>
				<NavBarCommon
					title={this.props.type === 'Register' ? '注册' : '忘记密码'}
					leftAction={() => Jump.back()}
				/>
				<CellInput
					leftTitle="手机号"
					placeholder={'请输入手机号'}
					maxLength={11}
					cellwrapper={RegisterStyle.cellwrapper}
					InputStyle={LoginStyle.inputStyle}
					leftTextStyle={RegisterStyle.leftTextStyle}
					keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
					value={this.state.tel}
					textChange={this.changeTel}
				/>
				<CellInput
					leftTitle="验证码"
					placeholder={'请输入验证码'}
					maxLength={4}
					inputRef={ref => { this.codeInput = ref }}
					cellwrapper={RegisterStyle.cellwrapper}
					InputStyle={LoginStyle.inputStyle}
					leftTextStyle={RegisterStyle.leftTextStyle}
					keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
					value={this.state.code}
					textChange={this.changeCode}
					rightComponent={this.codeSlot}
				/>
				<CellInput
					leftTitle={this.props.type === 'Register' ? '密码' : '新密码'}
					placeholder={'请输入6-20位数字或字母'}
					maxLength={20}
					cellwrapper={RegisterStyle.cellwrapper}
					InputStyle={LoginStyle.inputStyle}
					leftTextStyle={RegisterStyle.leftTextStyle}
					value={this.state.pwd}
					textChange={this.changePwd}
					btnStyle={RegisterStyle.btnStyle}
					showEyes={this.state.notShowPwd}
					rightIconStyle={this.state.notShowPwd ? RegisterStyle.EyesClose : RegisterStyle.EyesOpen}
					rightClick={() => this.setState({ notShowPwd: !this.state.notShowPwd })}
				/>
				<View style={[General.container, General.center]}>
					<ButtonHighlight
						title={this.state.btnText}
						onPress={enable => this.submit(enable)}
						disabled={this.state.disabled}
						buttonStyle={RegisterStyle.submitBtn}
					/>
					{this.props.type === 'Register' &&
					<Text style={LoginStyle.Tip1}>注册即代表同意
						<Text style={LoginStyle.Tip2} onPress={() => this.watchProtocol()}>{(this.props.baseInfo.Agreement && this.props.baseInfo.Agreement.AgeementName) || ''}</Text>
					</Text>
					}
				</View>
				<Loading ref={ref => { this.loading = ref }}/>
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
export default connect(mapStateToProps)(Register);