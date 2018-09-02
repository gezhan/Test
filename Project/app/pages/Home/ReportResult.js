'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Image
} from 'react-native'
// utils
import { FunctionUtils, HttpRequest, toastShort, Types, Url, Jump } from '../../config/index';
// components
import NavBarCommon from '../../components/NavBarCommon'
import ButtonHighlight from '../../components/ButtonHighlight'
import Loading from '../../components/Loading'
// styles
import { General } from '../../style/index';
import ReportResultStyle from './style/ReportResultStyle';

export default class ReportResult extends Component {
	constructor (props) {
		super(props)
		this.status = props.CreditValue; // 认证状态  1.授信审核中，2.用户授信通过，3.用户授信未通过，4.用户第一笔取现还清之后，5.跳信用详情页面
		this.mCreditAllow = props.CreditAllow; // 是否允许借款  true允许，false不允许
		this.mCrerditUrl = props.CreditUrl;// 购买报告的H5地址
		this.skip = props.Skip;// 全局开关，true打开，false关闭
		this.CreditTitle = props.CreditTitle; // 结果标题文字
		this.CreditContent = props.CreditContent; // 结果内容文字
		this.CreditButton = props.CreditButton; // 结果按钮文字
		switch (this.status) {
			case 1 :
				this.reminder = this.CreditContent ? this.CreditContent : '正在玩命生成，请耐心等待'
				break;
			case 2:
				this.reminder = this.CreditTitle ? this.CreditTitle : '恭喜你，信用报告已生成'
				if (!this.skip) {
					this.buttonText = this.CreditButton ? this.CreditButton : '立即查看'
				} else {
					this.buttonText = this.CreditButton ? this.CreditButton : '立即购买借款'
				}
				break;
			case 3:
				this.reminder = this.CreditTitle ? this.CreditTitle : '恭喜你，信用报告已生成'
				if (!this.skip) {
					this.buttonText = this.CreditButton ? this.CreditButton : '立即查看'
				} else {
					this.buttonText = this.CreditButton ? this.CreditButton : '立即购买查看'
				}
				break;
			case 4:
				this.reminder = this.CreditTitle ? this.CreditTitle : '恭喜你，信用报告已更新'
				if (!this.skip) {
					this.buttonText = this.CreditButton ? this.CreditButton : '立即查看'
				} else {
					this.buttonText = this.CreditButton ? this.CreditButton : '立即购买借款'
				}
				break;
		}
		this.reminder2 = this.CreditContent ? this.CreditContent : '根据您提交的相关资料，并结合多平台网贷以及银行等相关信息，综合生成了您的信用报告';
	}

	buyReport = enable => {
		if (this.skip) {
			switch (this.status) {
				case 2:
				case 3:
				case 4:
					Jump.go('JSWebView', { url: this.mCrerditUrl, tag: 'Activity', toDetail: this.toDetail, isPopTop: true })
					enable();
					break;
			}
		} else {
			this.toDetail(enable);
		}
	}

	toDetail = enable => {
		this.loading && this.loading.show();
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
							enable && enable()
							break
						}
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							enable && enable()
							responseData.Msg && toastShort(responseData.Msg)
							break
					}
				}
			})
			.catch(error => {
				enable && enable()
				this.loading && this.loading.hide()
				console.log('error', error)
			})
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={ '信用报告'} leftAction={() => Jump.back()}/>
				<View style={ReportResultStyle.topbackground}>
					<Image
						source={this.status === 1 ? require('../../images/Credit_Report_Generating.png') : require('../../images/Credit_Report_Done.png')}
						style={ReportResultStyle.headimage}/>
					<Text style={ReportResultStyle.topTextStyle}>{this.reminder}</Text>
					{this.status !== 1 &&
						<View style={ReportResultStyle.hintTextView}>
							<Text style={ReportResultStyle.hintTextStyle}>{this.reminder2}</Text>
						</View>}
				</View>
				{this.status !== 1 &&
				<ButtonHighlight
					title={this.buttonText} disabled={!this.mCreditAllow }
					buttonStyle={ReportResultStyle.exitBtn}
					onPress={this.buyReport}/>
				}
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}