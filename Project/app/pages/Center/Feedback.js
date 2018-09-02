'use strict'

import React, { Component } from 'react'

import {
	View,
	TextInput,
	Text,
	findNodeHandle
} from 'react-native'
// redux
import { connect } from 'react-redux'
// util
import { HttpRequest, Types, Url, toastShort, FunctionUtils, Udesk, Jump } from '../../config'
// views
import NavBarCommon from '../../components/NavBarCommon'
import Loading from '../../components/Loading'
import ButtonHighlight from '../../components/ButtonHighlight'
import CustomerService from '../../components/CustomerService'
import AlertConfirm from '../../components/AlertConfirm'
// style 
import FeedbackStyle from './style/FeedbackStyle'
import { General, AppColors, RatiocalWidth, RatiocalHeight, AppSizes } from '../../style'

@connect(
	state => ({
		baseInfo: state.baseInfo,
		authInfo: state.authInfo
	})
)
export default class Feedback extends Component {
	constructor (props) {
		super(props)

		this.state = {
			textLength: '0',
			feedbackValue: ''
		}
	}

	componentDidMount () {
		const { baseInfo, authInfo } = this.props;
		Udesk.Initialize(baseInfo, authInfo);
	}

	// 反馈内容更新
	_feedbackUpdate (text) {
		this.setState({
			feedbackValue: text,
			textLength: text.length
		})
	}

	_clickCustomerService = index => {
		this.shareTimer = setTimeout(() => {
			if (index === 1) {
				Udesk.OpenChatView();
			} else if (index === 2) {
				if (this.props.baseInfo.serviceMobile) {
					this.AlertConfirmTel && this.AlertConfirmTel.show();
				} else {
					toastShort('请先使用在线客服')
				}
			}
			this.shareTimer && clearTimeout(this.shareTimer);
			this.shareTimer = null;
		}, 500);
	};

	// 提交
	_submit = enable => {
		if (this.state.textLength < 10) {
			toastShort('您填写的内容少于10字，请重新输入')
			enable()
			return
		}
		this.loading.show()
		HttpRequest.request(Types.POST, Url.FEED_BACK, {
			content: this.state.feedbackValue,
			screenshot: ''
		})
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							toastShort('提交成功')
							Jump.back()
							break
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
				this.loading.hide()
				enable()
				console.log('error', error)
			})
	};

	render () {
		const { baseInfo } = this.props;
		return (
			<View style={General.wrapViewGray} onStartShouldSetResponderCapture={e => {
				const target = e.nativeEvent.target
				if (target !== findNodeHandle(this.input)) {
					this.input.blur()
				}
			}}>
				<NavBarCommon
					title={'意见反馈'}
					leftAction={() => Jump.back()}
					rightTitle={'在线客服'}
					rightAction={() => this.cuserRef && this.cuserRef.show()}
				/>
				<View style={FeedbackStyle.textareaWrap}>
					<Text style={FeedbackStyle.showTextareaLength}>
						<Text style={{ color: AppColors.mainColor }}>{this.state.textLength}</Text>/140
					</Text>
					<TextInput
						ref={ref => { this.input = ref }}
						maxLength={140}
						multiline={true}
						placeholder="请输入您的宝贵意见"
						style={FeedbackStyle.textInputView}
						placeholderTextColor={AppColors.ironColor}
						value={this.state.feedbackValue}
						onChangeText={text => this._feedbackUpdate(text)}
						underlineColorAndroid={'transparent'}
					/>
				</View>
				<View style={{
					marginLeft: (AppSizes.width - RatiocalWidth(690)) / 2,
					height: RatiocalHeight(90),
					width: RatiocalWidth(690)
				}}>
					<ButtonHighlight title={'提交'} onPress={this._submit}/>
				</View>
				<CustomerService
					ref={ref => { this.cuserRef = ref }}
					click={this._clickCustomerService}/>
				<AlertConfirm
					ref={ ref => { this.AlertConfirmTel = ref }}
					isShowTranBg={false}
					msg={'拨打' + baseInfo.serviceMobile}
					leftClick={() => this.AlertConfirmTel.hide()}
					rightBtnTextStyle={{ color: AppColors.lightBlackColor }}
					rightClick={() => {
						this.cuserRef.hide();
						this.AlertConfirmTel.hide();
						FunctionUtils.callPhone(baseInfo.serviceMobile);
					}}/>
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}