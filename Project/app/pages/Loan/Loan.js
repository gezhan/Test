'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	Platform,
	ScrollView,
	DeviceEventEmitter
} from 'react-native';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux'
// styles
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppSizes, General, AppFonts } from '../../style';
import LoanStyle from './style/LoanStyle';
// actions
import { UpdateAuth } from '../../actions/AuthAction'
import { FetchHome } from '../../actions/BaseAction'
// utils
import { HttpRequest, Types, Url, Jump, toastShort, FunctionUtils, DataAlgorithm } from '../../config'
// components
import NavBarCommon from '../../components/NavBarCommon'
import Cell from '../../components/Cell'
import ButtonHighlight from '../../components/ButtonHighlight'
import Loading from '../../components/Loading'
import PayBox from '../../components/PayBox'
import GeneralSelector from '../../components/GeneralSelector'
import Alert from '../../components/Alert'
@connect(
	state => ({
		loanData: state.loanData,
		baseInfo: state.baseInfo,
		authInfo: state.authInfo
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ UpdateAuth }, dispatch)
	})
)
export default class Loan extends Component {
	constructor (props) {
		super(props);
		this.state = {};
	}

	componentDidMount () {
		this.hidePayBoxListen = DeviceEventEmitter.addListener('hidePayBox', () => {
			this.payboxRef && this.payboxRef.hide();
		});
	}

	componentWillUnmount () {
		this.hidePayBoxListen && this.hidePayBoxListen.remove();
		this.hidePayBoxListen = null;
	}

	jumpToLoan = enable => {
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
											}
											enable();
										}
									}
								}
								FetchHome(this.props.dispatch, params);
							} else {
								toastShort('请先完成信用认证!')
								Jump.backToTop(1);
								enable();
							}
							break
						}
						case 408:
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

	pay = pwd => {
		const { loanData } = this.props;
		this.loading.show()
		HttpRequest.request(Types.POST, Url.REPAYMENT_CREATE, {
			RepaymentScheduleId: loanData.Loan.Loan.RepaymentScheduleId,
			Verifytradepassword: DataAlgorithm.Md5Encrypt(pwd),
			LoanId: loanData.Loan.Loan.Id
		})
			.then(responseData => {
				this.loading.hide();
				switch (responseData.Ret) {
					case 200:
						Jump.go('PaymentVerification', {
							phoneNumber: responseData.Mobile ? responseData.Mobile : '',
							scheduleId: loanData.Loan.Loan.RepaymentScheduleId,
							loanId: loanData.Loan.Loan.Id
						})
						this.payboxRef && this.payboxRef.hide();
						break;
					case 408:
						FunctionUtils.loginOut(responseData.Msg);
						break;
					default:
						responseData.Msg && toastShort(responseData.Msg);
						break;
				}
			})
			.catch(error => {
				this.loading.hide();
				error && console.log('error', error);
			});
	}

	render () {
		const { loanData, baseInfo, authInfo } = this.props;
		return (
			<View style={General.wrapViewGray}>
				{loanData.Loan && <Image
					style={LoanStyle.topView}
					source={Platform.OS === 'ios' ? AppSizes.height === 812 ? require('../../images/Loan_BgImgX.png')
						: require('../../images/Loan_BgImgIOS.png')
						: require('../../images/Loan_BgImgAndroid.png')}>
					<View style={LoanStyle.topTxt1View}>
						<Text style={LoanStyle.topText1}>应还金额(元）</Text>
					</View>
					<View style={LoanStyle.topTxt2View}>
						<Text
							style={LoanStyle.topText2}>
							{
								(loanData.Loan.LoanDetail.CapitalAmount + loanData.Loan.LoanDetail.TaxAmount + loanData.Loan.LoanDetail.OverdueMoneyAmount + loanData.Loan.LoanDetail.OverdueBreachOfAmount - loanData.Loan.LoanDetail.RemainMoneyChargeUpAmount).toFixed(2)
							}
						</Text>
					</View>
					<View style={LoanStyle.topTxt3View}>
						{loanData.Loan.LoanDetail.RemainMoneyChargeUpAmount > 0 &&
						<Text
							style={LoanStyle.topText3}>{`已还金额  ${(loanData.Loan.LoanDetail.RemainMoneyChargeUpAmount).toFixed(2)}`}</Text>
						}
					</View>
				</Image>}
				<NavBarCommon
					title={'账单'}
					backgroundColor={loanData.Loan ? AppColors.tranLG : null}
					rightTitle={loanData.IsBill ? '历史账单' : null}
					rightTitleStyle={LoanStyle.navRightTxt}
					rightAction={() => { Jump.go('LoanHistory') }}
				/>
				{!loanData.Loan
					? <View style={LoanStyle.noOrderView}>
						<Image
							source={loanData.IsBill ? require('../../images/Loan_OverOrder.png') : require('../../images/Loan_NoOrder.png')}
							style={LoanStyle.noOrder}/>
						<Text style={LoanStyle.noOrderText}>{ loanData.IsBill ? '已还清' : '暂无账单信息' }</Text>
						<ButtonHighlight
							title={'立即评估'}
							onPress={this.jumpToLoan}
						/>
					</View>
					: <View style={[LoanStyle.scrollViewParent, LoanStyle.bottomTop]}>
						<ScrollView style={{ flex: 1 }} contentContainerStyle={{ alignItems: 'center' }}>
							<Cell
								isFirst isLast isLink={false}
								wrapperBtnStyle={General.loanCellWrapperStyle}
								title={'利息'} titleTextStyle={LoanStyle.cellTitleStyle}
								value={(loanData.Loan.Loan.LoanTax).toFixed(2)}/>
							<Cell
								isLast isLink={false}
								wrapperBtnStyle={General.loanCellWrapperStyle}
								title={'期数'} titleTextStyle={LoanStyle.cellTitleStyle}
								value={`${loanData.Loan.Loan.LoanTermCount}天`}/>
							<Cell
								isLast isLink={false}
								wrapperBtnStyle={General.loanCellWrapperStyle}
								title={'还款日'} titleTextStyle={LoanStyle.cellTitleStyle}
								value={`${FunctionUtils.format('yyyy-MM-dd', new Date(loanData.Loan.Loan.EndDate))}`}/>
							<Cell
								isLast isLink={false}
								wrapperBtnStyle={General.loanCellWrapperStyle}
								title={'借款日'} titleTextStyle={LoanStyle.cellTitleStyle}
								value={`${FunctionUtils.format('yyyy-MM-dd', new Date(loanData.Loan.Loan.ReplyTime))}`}/>
							{(loanData.Loan.LoanDetail.OverdueMoneyAmount + loanData.Loan.LoanDetail.OverdueBreachOfAmount) > 0 &&
							<Cell
								wrapperBtnStyle={General.loanCellWrapperStyle}
								isLast isLink={false}
								title={'逾期费'} titleTextStyle={LoanStyle.cellTitleStyle}
								value={(loanData.Loan.LoanDetail.OverdueMoneyAmount + loanData.Loan.LoanDetail.OverdueBreachOfAmount).toFixed(2)}/>
							}
							<Cell
								wrapperBtnStyle={[General.loanCellWrapperStyle, General.mt20]}
								isFirst isLast
								title={'借款合同'} titleTextStyle={LoanStyle.cellTitleStyle}
								value={'请查看'}
								clickCell={() => {
									if (this.licenseSelector && loanData.Loan.Agreements !== null) {
										this.licenseSelector.show()
									} else {
										toastShort('协议数据异常')
									}
								}}/>
							{loanData.Loan.Loan.State === 'BACKING' &&
							<ButtonHighlight
								title={'立即还款'}
								buttonStyle={{ marginTop: RatiocalHeight(30), marginBottom: RatiocalHeight(12) }}
								onPress={enable => {
									enable()
									this.payboxRef && this.payboxRef.show(loanData.Loan.ZhiFBState)
								}}
							/>
							}
						</ScrollView>
					</View>
				}
				{loanData.Loan &&
				<GeneralSelector
					ref={ref => { this.licenseSelector = ref }}
					clickCell={rowData => {
						this.licenseSelector && this.licenseSelector.hidden();
						Jump.go('JSWebView', { url: (rowData.AgreementUrl + '?loanId=' + loanData.Loan.Loan.Id) });
					}}
					cancelBtnVisible
					Key={'AgeementName'}
					listData={loanData.Loan.Agreements}/>
				}
				{loanData.Loan &&
				<PayBox
					ref={ref => { this.payboxRef = ref }} isTopPay
					bankLogo={loanData.Loan.Backcard.LogoImage}
					BankName={loanData.Loan.Backcard.BankName}
					CardNumber={loanData.Loan.Backcard.CardNumber.slice(-4)}
					toPayBank={() => { this.payboxRef && this.payboxRef.MyKeyboard.enterAnimate() }}
					toAliTransfer={() => {
						Jump.go('JSWebView', { url: baseInfo.alipayUrl, tag: 'AliTransfer' })
						this.payboxRef && this.payboxRef.hide();
					}}
					showAliTransfer={loanData.Loan.ZhiFBState}
					toPay={this.pay}/>
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