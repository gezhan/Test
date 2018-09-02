'use strict';
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	ListView,
	ScrollView,
	RefreshControl,
	Image
} from 'react-native'

// components
import NavBarCommon from '../../components/NavBarCommon'
import Loading from '../../components/Loading'
import Cell from '../../components/Cell'
import ButtonHighlight from '../../components/ButtonHighlight'
// utils
import { HttpRequest, toastShort, Types, Url, Jump } from '../../config';
// styles
import { RatiocalHeight, AppSizes, General, AppColors } from '../../style'
import LoanHistoryStyle from './../Loan/style/LoanHistoryStyle';
import FunctionUtils from '../../utils/FunctionUtils';
import AuthStyle from '../Auth/style/AuthStyle';

export default class MyCreditReport extends Component {
	constructor (props) {
		super(props);
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2,
			sectionHeaderHasChanged: (r1, r2) => r1 !== r2
		});
		this.state = {
			dataSource: ds,
			isRefreshing: false,
			ReportList: null
		}
	}

	componentDidMount () {
		this.onRefresh();
	}

	onRefresh = () => {
		this.loading && this.loading.show();
		HttpRequest.request(Types.POST, Url.CREDIT_INFO_LIST)
			.then(responseData => {
				this.loading && this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200: {
							let params = { isRefreshing: false };
							if (responseData.ReportList) {
								let list = [];
								for (let i = 0; i < responseData.ReportList.length; i++) {
									if (responseData.ReportList[i].State === 'SUCCESS') {
										list.push(responseData.ReportList[i])
									}
								}
								params.ReportList = list;
							}
							this.setState(params)
							break
						}
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							responseData.Msg && toastShort(responseData.Msg)
							this.setState({ isRefreshing: false })
							break
					}
				}
			})
			.catch(error => {
				this.setState({ isRefreshing: false })
				this.loading && this.loading.hide()
				console.log('error', error)
			})
	}

	_renderRow = (rowData, sectionID, rowID) => {
		let state = '';
		if (rowData.State === 'SUCCESS') {
			state = '已购买'
		} else if (rowData.State === 'FAIL') {
			state = '未支付'
		}
		return (
			<Cell
				isFirst={rowID === '0'} isLast
				title={`${FunctionUtils.format('yyyy-MM-dd', new Date(rowData.CreateTime))}` + rowData.TicketName} value={state}
				titleTextStyle={LoanHistoryStyle.cellTitleStyle}
				clickCell={() => this.JumpDetail(rowData.Id)}
			/>
		)
	};

	JumpDetail = ReportId => {
		let param = {
			ReportId: ReportId
		}
		this.loading && this.loading.show();
		HttpRequest.request(Types.POST, Url.REPORT_DETAIL, param)
			.then(responseData => {
				this.loading && this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200: {
							let param = {
								From: 'MyCredit',
								CreditAssess: responseData.CreditAssess,
								CreditLoan: responseData.CreditLoan,
								CreditRisk: responseData.CreditRisk,
								CreditScore: responseData.CreditScore,
								Loan: responseData.Loan,
								Skip: responseData.Skip,
								UsersMetada: responseData.UsersMetada,
								CreditDate: responseData.CreditDate,
								FetchMy: this.onRefresh
							}
							Jump.go('ReportDetail', param)
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
				this.loading && this.loading.hide()
				console.log('error', error)
			})
	}

	getReport = enable => {
		Jump.backToTop(0)
		enable()
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'我的信用报告'} leftAction={() => Jump.back()}/>
				{this.state.ReportList !== null &&
				<ListView
					style={LoanHistoryStyle.listView}
					dataSource={this.state.dataSource.cloneWithRows(this.state.ReportList)}
					renderRow={this._renderRow}
					enableEmptySections={true}
					refreshControl={
						<RefreshControl
							refreshing={this.state.isRefreshing}
							onRefresh={() => this.onRefresh()}
							tintColor={AppColors.mainColor}
							titleColor={AppColors.mainColor}
							colors={[AppColors.mainColor, AppColors.mainColor, AppColors.mainColor]}
						/>
					}/>
				}

				{this.state.ReportList === null &&
				<ScrollView
					contentContainerStyle={LoanHistoryStyle.noDataWrap}
					refreshControl={
						<RefreshControl
							refreshing={this.state.isRefreshing}
							onRefresh={() => this.onRefresh()}
							tintColor={AppColors.mainColor}
							titleColor={AppColors.mainColor}
							colors={[AppColors.mainColor, AppColors.mainColor, AppColors.mainColor]}
						/>
					}>
					<View style={General.center}>
						<Image
							source={require('../../images/No_Credit_Report.png') }
							style={AuthStyle.NoReportImg}/>
						<Text style={LoanHistoryStyle.noDataText}>暂无信用报告</Text>
						<ButtonHighlight
							title={'立即获取'}
							buttonStyle={AuthStyle.Btn}
							onPress={this.getReport}/>
					</View>
				</ScrollView>
				}
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}