'use strict'

import React, { Component } from 'react'
import {
	View,
	Text,
	Image,
	Platform,
	ScrollView
} from 'react-native'
// utils
import { FunctionUtils, toastShort } from '../../config'
import Jump from '../../utils/Jump'
// components
import Cell from '../../components/Cell'
import Loading from '../../components/Loading'
import NavBarCommon from '../../components/NavBarCommon'
import ButtonHighlight from '../../components/ButtonHighlight'
// styles
import { General, AppColors, AppSizes } from '../../style'
import CenterStyle from './style/CenterStyle'
// redux
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
// action
import { FetchCenter } from '../../actions/BaseAction';
@connect(
	state => ({
		baseInfo: state.baseInfo
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ FetchCenter }, dispatch)
	})
)

export default class Center extends Component {
	constructor (props) {
		super(props)
		this.state = {}
	}

	go = path => {
		Jump.go(FunctionUtils.isLogin(this.props.baseInfo) ? path : 'Login')
	}

	exit = enable => {
		enable()
		toastShort('退出')
		FunctionUtils.loginOut()
	}

	render () {
		const { baseInfo } = this.props;
		return (
			<View style={General.wrapViewGray}>
				<Image
					style={CenterStyle.topBackground}
					source={Platform.OS === 'ios' ? AppSizes.height === 812 ? require('../../images/Center_BgImgX.png')
						: require('../../images/Center_BgImgIOS.png')
						: require('../../images/Center_BgImgAndroid.png')}>
					<View style={CenterStyle.headImageBackground}>
						<Image
							source={require('../../images/Center_HeadImage.png')}
							style={CenterStyle.headImage}/>
					</View>
					<Text style={CenterStyle.topTextStyle}>{baseInfo.account}</Text>
				</Image>
				<NavBarCommon
					title={'我的'}
					backgroundColor={AppColors.tranLG}
					isShowPoint={baseInfo.CenterData.MessageCount > 0}
					rightImage={FunctionUtils.isLogin(this.props.baseInfo) ? require('../../images/Center_MsgList.png') : null}
					rightImageStyle={CenterStyle.msgIcon}
					rightAction={() => this.go('MessageCenter')}/>
				<ScrollView style={CenterStyle.cellParent}>
					<Cell
						isFirst isLast
						styleType={2} mediaImg={require('../../images/Center_pwd.png')} title={'修改密码'}
						clickCell={() => this.go(baseInfo.CenterData.HasPayPwd ? 'EditPwd' : 'ModifyLoginPwd')}
						titleTextStyle={CenterStyle.cellText}
						wrapperBtnStyle={CenterStyle.wrapperBtnStyle}/>
					<Cell
						isLast styleType={2} mediaImg={require('../../images/Center_order.png')} title={'我的信用报告'}
						clickCell={() => this.go('MyCreditReport')}
						titleTextStyle={CenterStyle.cellText}
						wrapperBtnStyle={CenterStyle.wrapperBtnStyle}/>
					<Cell
						isLast styleType={2}
						mediaImg={require('../../images/Center_question.png')} title={'帮助中心'}
						clickCell={() => Jump.go('JSWebView', {
							showCuser: true,
							url: baseInfo.CenterData.ProblemUrl
						})}
						titleTextStyle={CenterStyle.cellText}
						wrapperBtnStyle={CenterStyle.wrapperBtnStyle}/>
					<Cell
						isLast styleType={2}
						mediaImg={require('../../images/Center_OpionBack.png')} title={'意见反馈'}
						clickCell={() => this.go('Feedback')} titleTextStyle={CenterStyle.cellText}
						wrapperBtnStyle={CenterStyle.wrapperBtnStyle}/>
					{FunctionUtils.isLogin(baseInfo) &&
					<ButtonHighlight
						title={'退出'} onPress={this.exit} disabled={false}
						buttonStyle={CenterStyle.exitBtn}/>
					}
				</ScrollView>
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}