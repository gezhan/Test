'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Image,
	Platform,
	TouchableWithoutFeedback
} from 'react-native'
// views
import { KeyboardAwareScrollView } from '../../components/KeyboardAwareScrollView'
import ButtonHighlight from '../../components/ButtonHighlight'
import GetCodeButton from '../../components/GetCodeButton'
import NavBarCommon from '../../components/NavBarCommon'
import CellInput from '../../components/CellInput'
import Loading from '../../components/Loading'
import Cell from '../../components/Cell'
// utils
import { Types, HttpRequest, Url, FunctionUtils, Jump, toastShort } from '../../config'
// styles
import BindBankCardStyle from './style/BindBankCardStyles'
import { General } from '../../style'
// actions
// action
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { GetAuth } from '../../actions/AuthAction'
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

export default class BindBankCard extends Component {
	constructor (props) {
		super(props)
		this.state = {
			// 提交按钮是否不可按
			nextStepBtnDisabled: true,
			// 验证码按钮是否不可按
			getCodeBtnDisabled: true,
			// 验证码按钮文字
			getCodeText: '获取验证码',
			// 银行名字
			bankName: '请选择',
			bankId: 0,
			// 选择的是哪个银行
			selectedBankInfo: {},
			// 输入的银行卡号
			bankNumber: '',
			// 预留手机号
			tel: '',
			// 验证码
			code: '',
			// 同意协议
			checkAgreementArrow: true,
			// 签约过后的参数
			signingParams: {},
			// 获取验证码后银行卡号和预留手机号不可更改状态值
			codeStatus: true,
			// 银行卡号输入框样式
			bankNumInputStyle: BindBankCardStyle.cellInputStyle,
			// 预留手机号输入框样式
			telInputStyle: BindBankCardStyle.cellInputStyle,
			// 验证码输入框样式
			codeInputStyle: BindBankCardStyle.cellInputStyleCenter
		}
	}

	// 获取所属银行列表
	goBankList = () => {
		Jump.go('BankList', {
			setBank: this.setBank
		})
	}

	setBank = data => {
		this.state.bankName = data.Bkname
		this.state.bankId = data.Id
		this.calculateSubmitBtn()
		this.calculateCodeBtn()
		this.forceUpdate()
	}

	// 输入的银行卡号
	changeInput = (text, type) => {
		if (type === 'bankCard') {
			let Text1 = text.replace(/\s/g, '')
			let regExp = new RegExp('^[0-9]*$')
			if (!regExp.test(Text1)) {
				toastShort('请输入数字')
				return
			}
			let value = text.length > 4 ? (text.replace(/\s/g, '').replace(/([0-9]{4})/g, '$1 ')).trim() : text.trim()
			this.state.bankNumber = value
		} else if (type === 'tel') {
			let regExp = new RegExp('^[0-9]*$')
			if (!regExp.test(text)) {
				toastShort('请输入数字')
				return
			}
			this.state.tel = text
		} else if (type === 'code') {
			this.state.code = text
		}
		this.calculateCodeBtn()
		this.calculateSubmitBtn()
		this.forceUpdate()
	}

	// 获取验证码
	getCode = enable => {
		// toastShort('获取验证码')
		this.setState({ getCodeBtnDisabled: false })
		this.loading.show()
		let params = {
			BankId: this.state.bankId,
			BankName: this.state.bankName,
			BankCardNumber: this.state.bankNumber.replace(/\s/g, ''),
			BankMobile: this.state.tel
		}
		HttpRequest.request(Types.POST, Url.CHECKBANK, params)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							!!this.codeInput && this.codeInput.focus()
							this.GetCodeButtonRef.countDown()
							break
						case 408:
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
				this.loading.hide()
				console.log('error', error)
			})
		// this.setState({ codeStatus: false })
	}

	// 计算获取验证码按钮 是否 可点击
	calculateCodeBtn = () => {
		let bool =
			this.state.bankName && this.state.bankName !== '请选择' &&
			this.state.bankNumber.length >= 19 &&
			this.state.tel.length === 11
		this.state.getCodeBtnDisabled = !bool
	}

	// 计算保存按钮 是否 可点击
	calculateSubmitBtn = () => {
		let bool =
			this.state.bankName && this.state.bankName !== '请选择' &&
			this.state.bankNumber.length >= 19 &&
			this.state.tel.length === 11 &&
			this.state.code.length >= 4 &&
			this.state.checkAgreementArrow
		this.state.nextStepBtnDisabled = !bool
	}

	// 协议的勾选
	clickAgreementArrow = () => {
		this.state.checkAgreementArrow = !this.state.checkAgreementArrow
		this.calculateSubmitBtn()
		this.forceUpdate()
	}

	// 查看协议
	watchProtocol = () => {
		Jump.go('JSWebView', {
			url: this.props.baseInfo.BindCardProtocol || ''
		})
	}

	nextStep = enable => {
		this.loading.show()
		let params = {
			BankId: this.state.bankId,
			BankName: this.state.bankName,
			BankCardNumber: this.state.bankNumber.replace(/\s/g, ''),
			BankMobile: this.state.tel,
			VerifyCode: this.state.code
		}
		HttpRequest.request(Types.POST, Url.BINDCARD, params)
			.then(responseData => {
				// this.setState({ getCodeBtnDisabled: false })
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.props.updateAuth()
							Jump.back()
							break
						case 408:
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
				this.loading.hide()
				console.log('error', error)
			})
	}

	render () {
		const { authInfo } = this.props
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'添加银行卡'} leftAction={() => Jump.back()} />
				<KeyboardAwareScrollView>
					<View style={BindBankCardStyle.content}>
						<Cell isFirst title={'持卡人'} value={authInfo.Sm.VerifyRealName}/>
						<Cell title={'证件号码'} value={FunctionUtils.ensureIDNumber(authInfo.Sm.IdCard)}/>
						<Cell
							title={'所属银行'}
							value={this.state.bankName}
							clickCell={this.goBankList}/>
						<CellInput
							leftTitle={'银行卡号'}
							placeholder={'请输入银行卡账号'}
							maxLength={26}
							value={this.state.bankNumber}
							textChange={text => this.changeInput(text, 'bankCard')}
							keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
							editable={this.state.codeStatus}
							InputStyle={this.state.bankNumInputStyle}
							onFocus={() => {
								this.setState({
									bankNumInputStyle: BindBankCardStyle.cellInputFocusStyle
								})
							}}
							onBlur={() => {
								this.setState({
									bankNumInputStyle: BindBankCardStyle.cellInputStyle
								})
							}}
						/>
						<CellInput
							leftTitle={'预留手机号'}
							placeholder={'请输入银行预留手机号'}
							maxLength={11}
							value={this.state.tel}
							textChange={text => this.changeInput(text, 'tel')}
							keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
							editable={this.state.codeStatus}
							InputStyle={this.state.telInputStyle}
							onFocus={() => {
								this.setState({
									telInputStyle: BindBankCardStyle.cellInputFocusStyle
								})
							}}
							onBlur={() => {
								this.setState({
									telInputStyle: BindBankCardStyle.cellInputStyle
								})
							}}
						/>
						<CellInput
							isLast
							leftTitle={'验证码'}
							placeholder={'请输入验证码'}
							inputRef={ref => { this.codeInput = ref }}
							maxLength={6}
							value={this.state.code}
							textChange={text => this.changeInput(text, 'code')}
							keyboardType={Platform.OS === 'ios' ? 'number-pad' : 'numeric'}
							editable={this.state.codeStatus}
							InputStyle={this.state.codeInputStyle}
							onFocus={() => {
								this.setState({
									codeInputStyle: BindBankCardStyle.cellInputFocusStyleCenter
								})
							}}
							onBlur={() => {
								this.setState({
									codeInputStyle: BindBankCardStyle.cellInputStyleCenter
								})
							}}
						>
							<GetCodeButton
								ref={ref => { this.GetCodeButtonRef = ref }}
								title={'发送验证码'}
								onPress={this.getCode}
								disabled={this.state.getCodeBtnDisabled}
							/>
						</CellInput>

						<View style={BindBankCardStyle.footerSubView1}>
							<TouchableWithoutFeedback style={BindBankCardStyle.footerSubView1Image1} onPress={this.clickAgreementArrow}>
								<View style={[BindBankCardStyle.footerSubView1Image1, BindBankCardStyle.gouWrap, General.center]}>
									{this.state.checkAgreementArrow &&
										<Image style={BindBankCardStyle.footerSubView1Image2} source={require('../../images/Common_Protocol.png')}/>
									}
								</View>
							</TouchableWithoutFeedback>
							<Text style={BindBankCardStyle.footerSubView1Text1} onPress={this.clickAgreementArrow}>已阅读并同意
								<Text style={BindBankCardStyle.footerSubView1Text2} onPress={this.watchProtocol} suppressHighlighting={true}>《支付服务协议》</Text>
							</Text>
						</View>
					</View>
					<ButtonHighlight
						title={'保存'}
						onPress={this.nextStep}
						buttonStyle={BindBankCardStyle.btnSubmit}
						disabled={this.state.nextStepBtnDisabled}
					/>
					<View style={BindBankCardStyle.buttonBottom}>
						<Image source={require('../../images/Common_Safe.png')}/>
						<Text style={BindBankCardStyle.textContact}>银行级数据加密防护</Text>
					</View>
				</KeyboardAwareScrollView>
				<Loading ref={ref => { this.loading = ref }} />
			</View>
		)
	}
}
