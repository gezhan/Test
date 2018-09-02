'use strict'

import React, { Component } from 'react'

import {
	View,
	Text,
	Image,
	ScrollView,
	Platform,
	DeviceEventEmitter,
	BackHandler
} from 'react-native'
// redux
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
// actions
import { GetLoan } from '../../actions/LoanAction';
// util
import {
	Jump
} from '../../config'
// view
import NavBarCommon from '../../components/NavBarCommon'
import ButtonHighlight from '../../components/ButtonHighlight'
// style
import { General, AppColors, AppSizes, AppFonts, RatiocalHeight } from '../../style'
import LoanSuccessStyle from './style/LoanSuccessStyle';

@connect(
	null,
	dispatch => ({
		dispatch,
		...bindActionCreators({ GetLoan }, dispatch)
	})
)
export default class LoanSuccess extends Component {
	constructor (props) {
		super(props)
		this.LoanDesc = props.LoanDesc
	}
	back = () => {
		this.props.GetLoan();
		Jump.backToTop(2);
	}

	// 安卓物理返回键
	_onBackAndroid = () => {
		if (Jump.navigator === null) {
			return false;
		} else if (Jump.navigator.getCurrentRoutes().length === 1) {
			return false;
		} else {
			this.back();
			return true;
		}
	};

	componentWillMount () {
		if (Platform.OS === 'android') {
			DeviceEventEmitter.emit('removeLoanHWBP')
			BackHandler.addEventListener('hardwareBackPress', this._onBackAndroid);
		}
	}

	componentWillUnmount = () => {
		if (Platform.OS === 'android') {
			BackHandler.removeEventListener('hardwareBackPress', this._onBackAndroid);
			DeviceEventEmitter.emit('addHWBP')
		}
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon
					leftAction={() => { this.back() }}
					title={'结果页面'}/>
				<ScrollView
					style={{ flex: 1 }}
					contentContainerStyle={[{ alignItems: 'center' }]}>
					<Image
						style={LoanSuccessStyle.resultImg}
						source={require('../../images/Credit_Report_Generating.png')}/>
					<View style={LoanSuccessStyle.result}>
						<Text style={LoanSuccessStyle.resultTxt}>{this.LoanDesc}</Text>
					</View>
					<ButtonHighlight
						title={'完成'}
						buttonStyle={LoanSuccessStyle.resultBtn}
						onPress={enable => {
							this.props.GetLoan();
							Jump.backToTop(2);
							enable()
						}}
					/>
				</ScrollView>
			</View>
		)
	}
}