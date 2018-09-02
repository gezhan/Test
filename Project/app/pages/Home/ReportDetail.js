'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Image,
	ScrollView,
	Platform,
	DeviceEventEmitter,
	BackHandler
} from 'react-native'
import { connect } from 'react-redux';
import { FetchHome } from '../../actions/BaseAction'
// utils
import Jump from '../../utils/Jump';
// components
import NavBarCommon from '../../components/NavBarCommon'
import Cell from '../../components/Cell'
import ButtonHighlight from '../../components/ButtonHighlight'
// styles
import ReportDetaileStyle from './style/ReportDetailStyle';
import { General, AppColors } from '../../style/index';
import { FunctionUtils, HttpRequest, toastShort, Types, Url } from '../../config/index';
import Loading from '../../components/Loading'

@connect()
export default class ReportDetail extends Component {
	constructor (props) {
		super(props);
		this.CreditScore = props.CreditScore;
		this.UsersMetada = props.UsersMetada
		this.CreditRisk = props.CreditRisk;
		this.CreditLoan = props.CreditLoan;
		this.CreditAssess = props.CreditAssess;
		this.Skip = props.Skip;
		this.CreditDate = props.CreditDate;
		this.Loan = props.Loan;
		this.BtnText = (props.InitAudit === 5 || props.InitAudit === 7) ? '综合评估过低暂无法申请' : props.Loan ? props.Loan.State === 'BACKING' ? '立即还款' : '放款中' : '立即借款';
		this.InitAudit = props.InitAudit
	}

	componentWillMount () {
		if (Platform.OS === 'android' && this.props.From !== 'MyCredit') {
			DeviceEventEmitter.emit('removeHWBP')
			BackHandler.addEventListener('hardwareBackPress', this._onBackAndroid);
		}
		this.removeHWBP = DeviceEventEmitter.addListener('removeLoanHWBP', () => {
			BackHandler.removeEventListener('hardwareBackPress', this._onBackAndroid)
		})
	}

	componentWillUnmount = () => {
		if (Platform.OS === 'android' && this.props.From !== 'MyCredit') {
			BackHandler.removeEventListener('hardwareBackPress', this._onBackAndroid);
			DeviceEventEmitter.emit('addHWBP')
		}
		if (this.props.From === 'MyCredit') {
			this.props.FetchMy && this.props.FetchMy();
		}
		!!this.removeHWBP && this.removeHWBP.remove()
		this.removeHWBP = null
	}

	// 安卓物理返回键
	_onBackAndroid = () => {
		if (Jump.navigator === null) {
			return false;
		} else if (Jump.navigator.getCurrentRoutes().length === 1) {
			return false;
		} else {
			FetchHome(this.props.dispatch);
			Jump.backToTop();
			return true;
		}
	};

	renderCreditRisk = () => {
		return (
			this.CreditRisk.map((item, index) => {
				return (
					<Cell
						key={index}
						isFirst={index === 0} isLast
						title={item.split('#')[0]} value={item.split('#')[1]}
						titleTextStyle={ReportDetaileStyle.cellTitleStyle}/>
				)
			})
		)
	}

	renderCreditLoan = () => {
		return (
			this.CreditLoan.map((item, index) => {
				return (
					<Cell
						key={index}
						isFirst={index === 0} isLast
						title={item.split('#')[0]} value={item.split('#')[1]}
						titleTextStyle={ReportDetaileStyle.cellTitleStyle}/>
				)
			})
		)
	}

	renderCreditAssess = () => {
		return (
			this.CreditAssess.map((item, index) => {
				return (
					<Cell
						key={index}
						isFirst={index === 0} isLast
						title={item.split('#')[0]} value={item.split('#')[1]}
						titleTextStyle={ReportDetaileStyle.cellTitleStyle}/>
				)
			})
		)
	}

	getReport = enable => {
		if (this.Loan) {
			Jump.backToTop(2);
		} else {
			this.loading && this.loading.show()
			HttpRequest.request(Types.POST, Url.PRODUCT)
				.then(responseData => {
					this.loading && this.loading.hide()
					if (responseData.Ret) {
						switch (responseData.Ret) {
							case 200: {
								let param = {
									Balance: responseData.Balance,
									CardInfo: responseData.CardInfo,
									Agreements: responseData.Agreements,
									Product: responseData.Product,
									CouponUse: responseData.CouponUse,
									CurrDate: responseData.CurrDate,
									UsableCoupon: responseData.UsableCoupon,
									Purposelist: responseData.Purposelist
								}
								Jump.go('LoanApplication', param)
								enable()
								break
							}
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
					this.loading && this.loading.hide()
					console.log('error', error)
				})
		}
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'信用报告详情'} leftAction={() => {
					FetchHome(this.props.dispatch);
					Jump.backToTop();
				}}/>
				<View style={this.Skip && this.InitAudit === 4 ? ReportDetaileStyle.scrollParent : ReportDetaileStyle.scrollParent2}>
					<ScrollView style={ReportDetaileStyle.scrollView}>
						<View style={ReportDetaileStyle.creditHead}>
							<View style={ReportDetaileStyle.creditPanelView}>
								<Image
									source={require('../../images/Credit_Panel.png')}
									style={ReportDetaileStyle.creditPanelImg}>
									<Text
										style={[ReportDetaileStyle.creditScore, { color: this.CreditScore < 400 ? AppColors.highRiskColor : this.CreditScore < 600 ? AppColors.mediumRiskColor : AppColors.lowRiskColor }]}>
										{this.CreditScore}
									</Text>
									<Text
										style={[ReportDetaileStyle.creditLevel, { color: this.CreditScore < 400 ? AppColors.highRiskColor : this.CreditScore < 600 ? AppColors.mediumRiskColor : AppColors.lowRiskColor }]}>
										{this.CreditScore < 400 ? '高风险' : this.CreditScore < 600 ? '中风险' : '低风险'}
									</Text>
								</Image>
							</View>
							<Text style={ReportDetaileStyle.testTime}>
								{`评估时间：${FunctionUtils.format('yyyy-MM-dd', new Date(this.CreditDate))}`}
							</Text>
						</View>
						<View style={ReportDetaileStyle.promptView}>
							<Image
								source={require('../../images/Home_Prompt.png')}
								style={ReportDetaileStyle.promptImg}
							/>
							<Text style={ReportDetaileStyle.promptText}>准确真实的身份信息才能得出准确的信用报告结果</Text>
						</View>
						<Cell
							isFirst isLast
							title={'姓名'} value={this.UsersMetada.Verifyrealname}
							titleTextStyle={ReportDetaileStyle.cellTitleStyle}/>
						<Cell
							isFirst isLast
							title={'手机号'} value={FunctionUtils.ensurePhone(this.UsersMetada.Account)}
							titleTextStyle={ReportDetaileStyle.cellTitleStyle}/>
						<Cell
							isFirst isLast
							title={'身份证'} value={FunctionUtils.ensureIDNumber(this.UsersMetada.IdCard)}
							titleTextStyle={ReportDetaileStyle.cellTitleStyle}/>
						<Cell
							isFirst isLast
							title={'日期'} value={`${FunctionUtils.format('yyyy-MM-dd', new Date(this.UsersMetada.Verify_time))}`}
							titleTextStyle={ReportDetaileStyle.cellTitleStyle}/>
						{this.CreditRisk && this.CreditRisk.length > 0 && <View style={ReportDetaileStyle.promptView}>
							<Image
								source={require('../../images/Home_Prompt.png')}
								style={ReportDetaileStyle.promptImg}
							/>
							<Text style={ReportDetaileStyle.promptText}>信用风险</Text>
						</View>}
						{this.CreditRisk && this.CreditRisk.length > 0 && this.renderCreditRisk()}
						{this.CreditLoan && this.CreditLoan.length > 0 && <View style={ReportDetaileStyle.promptView}>
							<Image
								source={require('../../images/Home_Prompt.png')}
								style={ReportDetaileStyle.promptImg}
							/>
							<Text style={ReportDetaileStyle.promptText}>多头借贷风险评估(近3个月)</Text>
						</View>}
						{this.CreditLoan && this.CreditLoan.length > 0 && this.renderCreditLoan()}
						{this.CreditAssess && this.CreditAssess.length > 0 && <View style={ReportDetaileStyle.promptView}>
							<Image
								source={require('../../images/Home_Prompt.png')}
								style={ReportDetaileStyle.promptImg}
							/>
							<Text style={ReportDetaileStyle.promptText}>失联风险评估</Text>
						</View>}
						{this.CreditAssess && this.CreditAssess.length > 0 && this.renderCreditAssess()}
					</ScrollView>
				</View>
				{this.Skip && (this.InitAudit === 4 || this.InitAudit === 5 || this.InitAudit === 7) &&
					<ButtonHighlight
						title={this.BtnText}
						buttonStyle={ReportDetaileStyle.Btn}
						disabled={this.BtnText === '放款中' || this.InitAudit === 5 || this.InitAudit === 7}
						onPress={this.getReport}/>
				}
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}