'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	ListView,
	TouchableOpacity,
	Text,
	Image
} from 'react-native';
import { connect } from 'react-redux';
// actions
import { GetLoan } from '../../actions/LoanAction'
// styles
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppSizes, General, AppFonts } from '../../style';
import LoanHistoryStyle from './style/LoanHistoryStyle';
// utils
import Jump from '../../utils/Jump';
import { toastShort } from '../../utils/ToastUtil'
import { HttpRequest, Types, Url } from '../../config';
import FunctionUtils from '../../utils/FunctionUtils';
// components
import NavBarCommon from '../../components/NavBarCommon'
import Loading from '../../components/Loading'
@connect()
export default class LoanHistory extends Component {
	constructor (props) {
		super(props);
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2,
			sectionHeaderHasChanged: (r1, r2) => r1 !== r2
		});
		this.state = {
			dataSource: ds,
			data: null
		};
	}

	componentDidMount = () => {
		this.fetch();
	};

	componentWillUnmount () {
		this.props.dispatch(GetLoan())
	}

	fetch = () => {
		this.loading.show()
		HttpRequest.request(Types.POST, Url.LOAN_RECORD, { IsHistory: 1 })
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.setState({
								data: responseData.Loanlist
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

	renderRow = (rowData, sectionID, rowID) => {
		let state = ''
		if (rowData.State === 'BACKING') {
			state = '待还款'
		} else if (rowData.State === 'FINISH') {
			state = '已还清'
		} else if (rowData.State === 'CONFIRM' || rowData.State === 'PAYING') {
			state = '放款中'
		} else if (rowData.State === 'REFUSE' || rowData.State === 'FAIL') {
			state = '失败'
		}
		return (
			<TouchableOpacity
				style={[General.borderTop, General.borderBottom]} activeOpacity={0.8}
				onPress={() => Jump.go('LoanDetail', {
					LoanId: rowData.Id,
					RepaymentScheduleId: rowData.RepaymentScheduleId,
					fetchList: this.fetch
				})}>
				<View style={LoanHistoryStyle.historyView}>
					<View style={LoanHistoryStyle.historyLeftSub}>
						<Text style={LoanHistoryStyle.historyNameTxt}>{rowData.Money.toFixed(2)}</Text>
						<Text
							style={LoanHistoryStyle.historyTimeTxt}>{FunctionUtils.format('yyyy-MM-dd', new Date(rowData.CreateTime))}</Text>
					</View>
					<View style={LoanHistoryStyle.historyRightSub}>
						<Text style={LoanHistoryStyle.cellTitleStyle}>{state}</Text>
						<Image style={LoanHistoryStyle.historyArrowImg} source={require('../../images/Common_Arrow.png')}/>
					</View>
				</View>
			</TouchableOpacity>
		)
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon
					title={ '历史账单'}
					leftAction={() => Jump.back()}
				/>
				{this.state.data !== null &&
				<ListView
					style={LoanHistoryStyle.listView}
					dataSource={this.state.dataSource.cloneWithRows(this.state.data)}
					renderRow={this.renderRow}
					enableEmptySections={true}/>
				}
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}