'use strict'

import React, { Component } from 'react'

import {
	Text,
	View,
	Modal,
	StyleSheet,
	TouchableOpacity,
	StatusBar
} from 'react-native'
import { RatiocalWidth, RatiocalHeight, AppColors, AppFonts, AppSizes, General } from '../style'
import DeviceInfo from '../utils/DeviceInfo'

class AlertConfirm extends Component {
	static defaultProps = {
		title: '',		// type为none时 的标题
		leftBtnText: '取消',
		rightBtnText: '确定',
		isShowTranBg: true,
		hideOnTouchOutside: false
	}

	static propTypes = {
		leftBtnText: React.PropTypes.string,
		rightBtnText: React.PropTypes.string,
		leftClick: React.PropTypes.func,
		rightClick: React.PropTypes.func

	}

	constructor (props) {
		super(props)

		this.state = {
			visible: false
		}
	}

	show = () => {
		this.setState({ visible: true })
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
			msg, msgStyle,
			btnStyle,
			leftBtnText, leftClick, leftBtnStyle, leftBtnTextStyle,
			rightBtnText, rightClick, rightBtnStyle, rightBtnTextStyle
		} = this.props

		let child = this.props.children
		if (child && child.length && child.length > 0) {
			throw new Error('onlyChild must be passed a children with exactly one child.')
		}
		let content = <View
			style={[styles.container, title ? styles.container_Title : styles.container_NoTitle, containerStyle]}>
			<View
				style={[styles.content, title ? styles.content_Title : styles.content_NoTitle, General.borderBottom, contentStyle]}>
				{!!title &&
				<View style={[styles.titleWrap, titleWrap]}>
					<Text style={[styles.title, titleStyle]}>{title}</Text>
				</View>
				}
				{!!msg && <Text style={[styles.msg, msgStyle]}>{msg}</Text>}
			</View>
			<View style={styles.bottom}>
				<TouchableOpacity
					style={[styles.btn, styles.btnLeft, btnStyle, leftBtnStyle]}
					onPress={() => { leftClick ? leftClick() : this.hide() }}>
					<Text style={[styles.btnText, styles.btnLeftText, leftBtnTextStyle]}>{leftBtnText}</Text>
				</TouchableOpacity>
				<TouchableOpacity style={[styles.btn, styles.btnRight, btnStyle, rightBtnStyle]} onPress={() => rightClick()}>
					<Text style={[styles.btnText, styles.btnRightText, rightBtnTextStyle]}>{rightBtnText}</Text>
				</TouchableOpacity>
			</View>
		</View>
		content = child || content
		return (
			this.state.visible &&
			<View style={[styles.parent, isShowTranBg && { backgroundColor: 'rgba(0, 0, 0, 0.3)' }]}>
				<Modal
					animationType={'fade'}
					transparent={true}
					visible={this.state.visible}
					onRequestClose={this.hide}
				>
					<TouchableOpacity style={styles.wrap} activeOpacity={1} onPress={() => hideOnTouchOutside && this.hide()}>
						{content}
					</TouchableOpacity>
				</Modal>
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
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height,
		width: AppSizes.width,
		justifyContent: 'center',
		...General.center
	},
	container: {
		width: RatiocalWidth(610),
		borderRadius: RatiocalHeight(10),
		backgroundColor: AppColors.whiteBg
	},
	content: {
		alignItems: 'center'
	},

	/* ------ ------ 有标题 ------ ------ */

	container_Title: {
		minHeight: RatiocalHeight(280)
	},
	content_Title: {
		minHeight: RatiocalHeight(190),
		paddingTop: RatiocalHeight(42),
		paddingBottom: RatiocalHeight(42),
		paddingLeft: RatiocalWidth(46),
		paddingRight: RatiocalWidth(46)
	},
	titleWrap: {
		height: RatiocalHeight(50),
		marginBottom: RatiocalHeight(6),
		...General.center
	},
	title: {
		fontSize: AppFonts.text_size_34,
		color: AppColors.boldBlackColor
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
		height: RatiocalHeight(90),
		borderBottomLeftRadius: RatiocalHeight(10),
		borderBottomRightRadius: RatiocalHeight(10)
	},
	btn: {
		width: RatiocalWidth(305),
		height: RatiocalHeight(90),
		...General.center
	},
	btnLeft: {
		...General.borderRight
	},
	btnRight: {},
	btnText: {
		fontSize: AppFonts.text_size_34
	},
	btnLeftText: {
		fontSize: AppFonts.text_size_34,
		color: AppColors.lightBlackColor
	},
	btnRightText: {
		fontSize: AppFonts.text_size_34,
		color: AppColors.mainColor
	}

})

export default AlertConfirm