'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Image
} from 'react-native'
import {
	Url,
	Jump,
	Types,
	toastShort,
	HttpRequest,
	FunctionUtils
} from '../../config'
import { connect } from 'react-redux'
import Loading from '../../components/Loading'
import NavBarCommon from '../../components/NavBarCommon'
// 样式
import MyBankCardStyle from './style/MyBankCardStyle'
import { General } from '../../style'

@connect(
	state => ({
		baseInfo: state.baseInfo
	})
)
export default class MyBankCard extends Component {
	constructor (props) {
		super(props)
		this.state = {
			BankName: '',
			CardNumber: '',
			BgImage: ''
		}
	}

	fetch = () => {
		this.loading && this.loading.show()
		HttpRequest.request(Types.POST, Url.BANKCARD)
			.then(responseData => {
				this.loading && this.loading.hide()
				let Ret = responseData.Ret
				if (Ret) {
					switch (Ret) {
						case 200:
							this.setState({
								BankName: responseData.List[0].BankName,
								CardNumber: responseData.List[0].CardNumber.slice(-4),
								BgImage: responseData.List[0].BgImage
							})
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
				this.loading && this.loading.hide()
				console.log('error', error)
			})
	}

	componentDidMount () {
		this.fetch()
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'银行卡管理'} leftAction={() => Jump.back()} />

				<View style={MyBankCardStyle.BankBGWrap}>
					<Image style={MyBankCardStyle.BankBG} source={{ uri: this.state.BgImage }}>
						<View style={MyBankCardStyle.BankTextWrap}>
							<Text style={MyBankCardStyle.BankText1}>****</Text>
							<Text style={MyBankCardStyle.BankText1}>****</Text>
							<Text style={MyBankCardStyle.BankText1}>****</Text>
							<Text style={MyBankCardStyle.BankText2}>{this.state.CardNumber}</Text>
						</View>
					</Image>
				</View>
				<Loading ref={ref => { this.loading = ref }} />
			</View>
		)
	}
}
