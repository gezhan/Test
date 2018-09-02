'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	ScrollView,
	Image,
	Platform
} from 'react-native';
import { connect } from 'react-redux';

// styles
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppSizes, General, AppFonts } from '../../style';
import LoanStyle from './style/LoanStyle';
// utils
import { HttpRequest, Types, Url, DataAlgorithm, toastShort, Jump } from '../../config';
import FunctionUtils from '../../utils/FunctionUtils';
// components
import NavBarCommon from '../../components/NavBarCommon'
import Cell from '../../components/Cell'
import ButtonHighlight from '../../components/ButtonHighlight'
import Loading from '../../components/Loading'
import PayBox from '../../components/PayBox'
import GeneralSelector from '../../components/GeneralSelector'

@connect(
	state => ({
		baseInfo: state.baseInfo
	})
)
export default class LoanDetail extends Component {
	constructor (props) {
		super(props);
		this.state = {
			Loan: null,
			Backcard: null,
			LoanDetail: null,
			Product: null,
			Repayment: null,
			ZhiFBState: '',
			Agreements: null
		};
	}

	componentDidMount = () => {
		this.fetch();
	};

	componentWillUnmount () {
		!!this.props.fetchList && this.props.fetchList();
	}

	fetch = () => {
		this.loading.show()
		HttpRequest.request(Types.POST, Url.LOAN_DETAIL, {
			LoanId: this.props.LoanId,
			RepaymentScheduleId: this.props.RepaymentScheduleId
		})
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.setState({
								Backcard: responseData.Backcard,
								Loan: responseData.Loan,
								LoanDetail: responseData.LoanDetail,
								Product: responseData.Product,
								Repayment: responseData.Repayment,
								ZhiFBState: responseData.ZhiFBState,
								Agreements: responseData.Agreements
							})
							break
						case 408: {
							FunctionUtils.loginOut(responseData.Msg)
							break
						}
						default: {
							responseData.Msg && toastShort(responseData.Msg)
							break
						}
					}
				}
			})
			.catch(error => {
				this.loading.hide()
				console.log('error', error)
			})
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				{this.state.Loan !== null &&
				<Image
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
								(this.state.LoanDetail.CapitalAmount + this.state.LoanDetail.TaxAmount + this.state.LoanDetail.OverdueMoneyAmount + this.state.LoanDetail.OverdueBreachOfAmount - this.state.LoanDetail.RemainMoneyChargeUpAmount).toFixed(2)
							}
						</Text>
					</View>
					<View style={LoanStyle.topTxt3View}>
						{this.state.LoanDetail.RemainMoneyChargeUpAmount > 0 &&
						<Text
							style={LoanStyle.topText3}>{`已还金额  ${(this.state.LoanDetail.RemainMoneyChargeUpAmount).toFixed(2)}`}</Text>
						}
					</View>
				</Image>
				}
				<NavBarCommon
					title={'账单详情'}
					backgroundColor={AppColors.tranLG}
					leftAction={() => Jump.back()}
				/>
				{this.state.Loan !== null &&
				<View style={[LoanStyle.detailScrollViewParent, LoanStyle.bottomTop]}>
					<ScrollView style={{ flex: 1 }} contentContainerStyle={{ alignItems: 'center' }}>
						<Cell
							isFirst isLast
							wrapperBtnStyle={General.loanCellWrapperStyle}
							title={'利息'} titleTextStyle={LoanStyle.cellTitleStyle}
							value={(this.state.Loan.LoanTax).toFixed(2)} isLink={false}/>
						<Cell
							isLast isLink={false}
							wrapperBtnStyle={General.loanCellWrapperStyle}
							title={'期数'} titleTextStyle={LoanStyle.cellTitleStyle}
							value={`${this.state.Loan.LoanTermCount}天`} />
						<Cell
							isLast isLink={false}
							wrapperBtnStyle={General.loanCellWrapperStyle}
							title={'还款日'} titleTextStyle={LoanStyle.cellTitleStyle}
							value={`${FunctionUtils.format('yyyy-MM-dd', new Date(this.state.Loan.EndDate))}`} />
						<Cell
							isLast isLink={false}
							wrapperBtnStyle={General.loanCellWrapperStyle}
							title={'借款日'} titleTextStyle={LoanStyle.cellTitleStyle}
							value={`${FunctionUtils.format('yyyy-MM-dd', new Date(this.state.Loan.ReplyTime))}`}/>
						{(this.state.LoanDetail.OverdueMoneyAmount + this.state.LoanDetail.OverdueBreachOfAmount) > 0 &&
						<Cell
							isLast isLink={false}
							wrapperBtnStyle={General.loanCellWrapperStyle}
							title={'逾期费'} titleTextStyle={LoanStyle.cellTitleStyle}
							value={(this.state.LoanDetail.OverdueMoneyAmount + this.state.LoanDetail.OverdueBreachOfAmount).toFixed(2)} />
						}
						<Cell
							wrapperBtnStyle={[General.loanCellWrapperStyle, General.mt20]}
							isFirst isLast title={'借款合同'} titleTextStyle={LoanStyle.cellTitleStyle}
							value={'请查看'}
							clickCell={() => {
								if (this.licenseSelector && this.state.Agreements !== null) {
									this.licenseSelector.show()
								} else {
									toastShort('协议数据异常')
								}
							}}/>
					</ScrollView>
				</View>
				}
				{this.state.Agreements !== null &&
				<GeneralSelector
					ref={ref => { this.licenseSelector = ref }}
					clickCell={rowData => {
						this.licenseSelector && this.licenseSelector.hidden();
						Jump.go('JSWebView', { url: (rowData.AgreementUrl + '?loanId=' + this.state.Loan.Id) });
					}}
					cancelBtnVisible
					Key={'AgeementName'}
					listData={this.state.Agreements}/>
				}
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}