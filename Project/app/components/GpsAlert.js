'use strict'

import React, { Component } from 'react'

import {
	Text,
	View,
	StyleSheet,
	TouchableOpacity,
	StatusBar,
	Image
} from 'react-native'
import { RatiocalWidth, RatiocalHeight, AppColors, AppFonts, AppSizes, General } from '../style'
import DeviceInfo from '../utils/DeviceInfo'

export default class GpsAlert extends Component {
	static defaultProps = {
		title: '',		// type为none时 的标题
		btnText: '确定',
		isShowTranBg: true,
		hideOnTouchOutside: false
	}

	static propTypes = {
		btnText: React.PropTypes.string,
		btnClick: React.PropTypes.func
	}

	constructor (props) {
		super(props)
		this.state = {
			visible: false,
			msg: ''
		}
	}

	show = params => {
		this.setState({
			msg: !!params && params.msg ? params.msg : this.state.msg,
			visible: true
		})
	}

	hide = () => {
		this.props.close && this.props.close();
		this.setState({ visible: false })
	}

	render () {
		const {
			isShowTranBg,
			hideOnTouchOutside,
			containerStyle,
			contentStyle,
			titleWrap, title, titleStyle,
			msgStyle,
			btnText, btnClick, btnStyle, btnTextStyle

		} = this.props

		let child = this.props.children
		if (child && child.length && child.length > 0) {
			throw new Error('onlyChild must be passed a children with exactly one child.')
		}
		return (
			this.state.visible &&
			<View style={[styles.parent, isShowTranBg && { backgroundColor: 'rgba(0, 0, 0, 0.3)' }]}>
				<View style={styles.wrap}>
					<View
						style={styles.container}>
						<View style={styles.GpsContent}>
							<Text style={styles.GpsMsg}>{this.state.msg}</Text>
						</View>
						<View style={styles.bottom}>
							<TouchableOpacity
								style={[styles.btn, btnStyle]}
								onPress={() => { btnClick ? btnClick() : this.hide() }}>
								<Text style={[styles.btnText, styles.GpsBtnTextStyle]}>{btnText}</Text>
							</TouchableOpacity>
						</View>
					</View>
					<Image style={styles.GpsImg} source={require('../images/Gps_Alert.png')} resizeMode={'contain'}/>
				</View>
			</View>
		)
	}
}

const styles = StyleSheet.create({
	parent: {
		position: 'absolute',
		top: 0,
		left: 0,
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height,
		width: AppSizes.width
	},
	wrap: {
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height,
		width: AppSizes.width,
		justifyContent: 'center',
		...General.center
	},
	container: {
		minHeight: RatiocalWidth(200),
		width: RatiocalWidth(610),
		borderRadius: RatiocalHeight(10),
		backgroundColor: AppColors.whiteBg,
		overflow: 'visible'
	},
	content: {
		alignItems: 'center'
	},

	/* ------ ------ 无标题 ------ ------ */

	container_NoTitle: {
		minHeight: RatiocalHeight(242)
	},
	content_NoTitle: {
		minHeight: RatiocalHeight(152),
		paddingLeft: RatiocalWidth(30),
		paddingRight: RatiocalWidth(30),
		paddingTop: RatiocalHeight(48),
		paddingBottom: RatiocalHeight(48)
	},

	msg: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor,
		lineHeight: parseInt(RatiocalHeight(50))
	},

	/* ------ ------ 下面按钮部分 ------ ------ */

	bottom: {
		flexDirection: 'row',
		bottom: 0,
		height: parseInt(RatiocalHeight(90)),
		borderBottomLeftRadius: 5,
		borderBottomRightRadius: 5
	},
	btn: {
		width: RatiocalWidth(610),
		height: parseInt(RatiocalHeight(90)),
		...General.borderTop,
		...General.center
	},
	btnText: {
		fontSize: AppFonts.text_size_34,
		color: AppColors.mainColor
	},
	GpsContent: {
		paddingLeft: RatiocalWidth(30),
		paddingRight: RatiocalWidth(30),
		paddingTop: RatiocalHeight(48),
		paddingBottom: RatiocalHeight(48),
		minHeight: RatiocalWidth(200),
		justifyContent: 'center',
		alignItems: 'center'
	},
	GpsMsg: {
		fontSize: AppFonts.text_size_26,
		color: AppColors.lightBlackColor
	},
	GpsImg: {
		position: 'absolute',
		top: ((DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height) / 2) - RatiocalWidth(200) * 1.35,
		left: ((AppSizes.width - RatiocalWidth(610)) / 2) + RatiocalWidth(610) / 2 - AppSizes.width / 4 / 2,
		width: AppSizes.width / 4,
		height: AppSizes.width / 4
	},
	GpsBtnTextStyle: {
		color: AppColors.lightBlackColor
	},
})