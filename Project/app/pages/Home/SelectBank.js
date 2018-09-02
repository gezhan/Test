'use strict'
import React, { Component } from 'react'
import {
	View,
	Text,
	Image
} from 'react-native'
// component
import NavBarCommon from '../../components/NavBarCommon'
import Cell from '../../components/Cell'
// style
import General from '../../style/General'
import { RatiocalFontSize, RatiocalHeight, RatiocalWidth } from '../../style'
// view
import ButtonHighlight from '../../components/ButtonHighlight'
// utils
import { Jump } from '../../config'
import SelectBankStyle from './style/SelectBankStyle'

export default class SelectBank extends Component {
	constructor (props) {
		super(props)
		this.BankList = []
	}

	bankLeft = (BankName, CardNumber) => {
		return (
			<View style={{ justifyContent: 'center', flexDirection: 'row' }}>
				<Image
					style={{ alignSelf: 'center' }}
					source={require('../../images/Home_Prompt.png')}
				/>
				<View
					style={{ flexDirection: 'column', marginLeft: RatiocalWidth(20) }}>
					<Text style={SelectBankStyle.bankNameText}>{BankName}</Text>
					<Text style={SelectBankStyle.CardNumberText}>{CardNumber}</Text>
				</View>
			</View>
		)
	}

	selectBank = bankName => {
		this.props.getBank && this.props.getBank(bankName);
		Jump.back()
	}

	goBindBank = enable => {
		Jump.go('BindBankCard')
		enable()
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'选择收款银行'} leftAction={() => Jump.back()}/>
				<Cell
					wrapperBtnStyle={{ height: RatiocalHeight(120) }}
					isFirst isLast
					slotLeft={() => this.bankLeft('中国银行', '123123')}
					rightIcon1={require('../../images/Home_Prompt.png')}
					clickCell={() => this.selectBank('中国银行')}/>
				<Cell
					wrapperBtnStyle={{ height: RatiocalHeight(120) }}
					isFirst={false} isLast
					slotLeft={() => this.bankLeft('招商银行', '123123')}
					rightIcon1={require('../../images/Home_Prompt.png')}
					clickCell={() => this.selectBank('招商银行')}/>
				<Cell
					wrapperBtnStyle={{ height: RatiocalHeight(120) }}
					isFirst={false} isLast
					slotLeft={() => this.bankLeft('建设银行', '123123')}
					rightIcon1={require('../../images/Home_Prompt.png')}
					clickCell={() => this.selectBank('建设银行')}/>
				<ButtonHighlight
					title={'添加银行卡'}
					onPress={this.goBindBank}
					buttonStyle={SelectBankStyle.bindButton}/>
			</View>
		)
	}
}