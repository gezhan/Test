'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	ListView
} from 'react-native'
import {
	Types,
	HttpRequest,
	Url,
	toastShort,
	FunctionUtils,
	Jump
} from '../../config'
import NavBarCommon from '../../components/NavBarCommon'
import Loading from '../../components/Loading'
import Cell from '../../components/Cell'
import { General, RatiocalWidth } from '../../style'
export default class BankList extends Component {
	constructor (props) {
		super(props)
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2
		})
		this.state = {
			dataSource: ds,
			data: ['']
		}
	}

	componentDidMount () {
		this.getBankList()
	}

	getBankList = () => {
		this.loading.show()
		HttpRequest.request(Types.POST, Url.BANKCARD_CONFIG)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							console.log('获取成功！')
							this.setState({ data: responseData.list })
							break
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
				this.loading.hide()
				console.log('error', error)
			})
	}

	chooseBank = rowData => {
		this.props.setBank && this.props.setBank(rowData)
		Jump.back()
	}

	renderRow = (rowData, sectionID, rowID) => {
		let uri = { uri: rowData.IconUrl }
		return (
			<Cell
				isFirst={ parseInt(rowID) === 0 }
				isLast={ parseInt(rowID) === this.state.data.length - 1 }
				title={rowData.Bkname}
				clickCell={() => this.chooseBank(rowData)}
				leftIcon1={uri}
				leftIcon1Style={{ width: RatiocalWidth(60), height: RatiocalWidth(60) }}/>
		)
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'绑定银行卡'} leftAction={() => { Jump.back() }} />
				<ListView
					enableEmptySections={true}
					dataSource={this.state.dataSource.cloneWithRows(this.state.data)}
					renderRow={this.renderRow}
				/>
				<Loading ref={ref => { this.loading = ref }} />
			</View>
		)
	}
}