'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	TextInput,
	Platform
} from 'react-native';
// redux
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux'
// actions
import { GetLoan } from '../../actions/LoanAction';
// styles
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppSizes, General } from '../../style';
import PaymentVerificationStyle from './style/PaymentVerificationStyle';
// views
import Loading from '../../components/Loading';
import NavigationBar from '../../components/NavBarCommon';
import ButtonHighlight from '../../components/ButtonHighlight';
import GetCodeButton from '../../components/GetCodeButton';
// utils
import {
	Types,
	HttpRequest,
	Url,
	Jump,
	FunctionUtils,
	toastShort
} from '../../config';
@connect(
	state => ({
		loanData: state.loanData
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ GetLoan }, dispatch)
	})
)
export default class PaymentVerification extends Component {
	constructor (props) {
		super(props);
		this.state = {
			// 预留手机号
			phoneNumber: '',
			// 验证码
			codeNumber: '',
			// 验证按钮是否可点击
			yzBtnDisabled: false,
			// 第一次获取连连的验证码返回的token
			llToken: '',
			// 应还款的金额
			repaymentMoney: 0,
			// 返回的订单号no_order
			noOrder: '',
			// 还款记录的rid
			rid: 0,
			// 返回的协议号noAgree
			noAgree: '',
			// 传过来的还款计划表id
			scheduleId: 0
		};
	}

	componentWillMount () {
		this.setState({
			phoneNumber: this.props.phoneNumber,
			scheduleId: this.props.scheduleId
		});
	}

	componentDidMount () {
		if (this.state.phoneNumber) {
			this.refCode && this.refCode.canClick();
		}
	}

	componentWillUnmount () {
		if (!Jump.findRoute('MyOrder')) {
			this.props.GetLoan();
		}
	}

	_back = () => {
		Jump.back();
	};

	// 验证
	_submit = enable => {
		enable();
		this.loading.show();
		HttpRequest.request(Types.POST, Url.POST_LL_REPAYMENT, {
			RepaymentScheduleId: this.state.scheduleId,
			LLToken: this.state.llToken,
			VerifyCode: this.state.codeNumber,
			ReturnMoney: this.state.repaymentMoney,
			NoOrder: this.state.noOrder,
			Rid: this.state.rid
		})
			.then(responseData => {
				this.loading.hide();
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							toastShort('提交成功');
							Jump.backToTop();
							break;
						default:
							responseData.Msg && toastShort(responseData.Msg);
							if (responseData.Skip && responseData.Skip !== 1) {
								this.props.fetchDetail && this.props.fetchDetail();
								this._back();
							}
							break;
					}
				}
			})
			.catch(error => {
				this.loading.hide();
				console.log('_getVerifyCode_Error:', error);
			});
	};

	// 获取验证码按钮
	_getCode = enable => {
		if (!FunctionUtils.isMobileNo(this.state.phoneNumber)) {
			toastShort('手机号格式不对，请重新输入');
			return;
		}
		this.loading.show();
		if (this.state.llToken) {
			let params = {
				LLToken: this.state.llToken,
				ReturnMoney: this.state.repaymentMoney,
				NoOrder: this.state.noOrder,
				NoAgree: this.state.noAgree
			};
			HttpRequest.request(Types.POST, Url.POST_RESEND_LLCODE, params).then(responseData => {
				this.loading.hide();
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							toastShort('验证码获取成功');
							this.refCode.countDown();
							break;
						default:
							enable();
							responseData.Msg && toastShort(responseData.Msg);
							if (responseData.Skip && responseData.Skip !== 1) {
								this._back();
							}
							break;
					}
				}
			}).catch(error => {
				this.loading.hide();
				console.log('_getVerifyCode_Error:', error);
			});
		} else {
			let params = {
				RepaymentScheduleId: this.state.scheduleId,
				Mobile: this.state.phoneNumber,
				LoanId: this.props.loanId
			};
			HttpRequest.request(Types.POST, Url.POST_SEND_LLCODE, params).then(responseData => {
				this.loading.hide();
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							toastShort('验证码获取成功');
							this.setState({
								llToken: responseData.LlToken,
								repaymentMoney: responseData.ReturnMoney,
								noOrder: responseData.NoOrder,
								rid: responseData.Rid,
								noAgree: responseData.NoAgree
							}, () => {
								this.refCode.countDown();
							});
							break;
						default:
							responseData.Msg && toastShort(responseData.Msg);
							if (responseData.Skip && responseData.Skip !== 1) {
								this._back();
							}
							break;
					}
				}
			}).catch(error => {
				this.loading.hide();
				console.log('_getVerifyCode_Error:', error);
			});
		}
	};

	// 获取手机号码的值
	_phoneNumber = text => {
		console.log(text.length, '++', text);
		let isTrues = text.length === 11;
		this.setState({ phoneNumber: text }, () => {
			isTrues ? this.refCode && this.refCode.canClick() : this.refCode && this.refCode.unCanClick();
		});
	};

	// 获取输入的验证码的值
	_codeNumUpdate = text => {
		console.log(text.length, '++', text);
		let isTrues = text.length > 3;
		this.setState({ codeNumber: text }, () => {
			this.setState({
				// 验证按钮是否可点击
				yzBtnDisabled: isTrues
			});
		});
	};

	render () {
		return (
			<View style={[General.wrapViewGray]}>
				<NavigationBar
					title={'支付验证'}
					leftAction={this._back}
					style={[General.borderBottom]}
				/>
				<View style={PaymentVerificationStyle.baseViews}>
					<View style={PaymentVerificationStyle.textBg2}>
						<View style={[PaymentVerificationStyle.baseContent]}>
							<Text style={PaymentVerificationStyle.codeInputView}>预留手机号</Text>
							<TextInput
								style={PaymentVerificationStyle.inputs1}
								defaultValue={this.state.phoneNumber !== '' ? this.state.phoneNumber : null}
								maxLength={11}
								placeholder="请输入银行预留手机号"
								underlineColorAndroid={AppColors.tranBg}
								editable={!(this.state.phoneNumber && this.state.phoneNumber.length === 11)}
								onChangeText={text => this._phoneNumber(text)}
							/>
						</View>
					</View>

					<View style={PaymentVerificationStyle.textBg}>
						<View style={[PaymentVerificationStyle.baseContent]}>
							<Text style={PaymentVerificationStyle.codeInputView}>验证码</Text>
							<TextInput
								style={PaymentVerificationStyle.inputs}
								placeholder="请输入验证码"
								underlineColorAndroid={AppColors.tranBg}
								keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
								maxLength={6}
								onChangeText={text => this._codeNumUpdate(text)}
							/>
							<GetCodeButton
								ref={ref => { this.refCode = ref; }}
								buttonStyle={{ marginRight: RatiocalWidth(30) }}
								title="获取验证码"
								onPress={enable => this._getCode(enable)}
							/>
						</View>
					</View>

					<ButtonHighlight
						title={'提交'}
						onPress={this._submit}
						buttonStyle={{ marginTop: RatiocalHeight(80) }}
						disabled={!this.state.yzBtnDisabled}/>
					<Loading ref={ref => { this.loading = ref; }}/>
				</View>
			</View>
		);
	}
}