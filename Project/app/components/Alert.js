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

export default class Alert extends Component {
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
			visible: false
		}
	}

	show = param => {
		this.setState({
			visible: true,
			title: (!!param && param.title) || this.state.title,
			msg: (!!param && param.msg) || this.state.msg
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
			msg, msgStyle,
			btnText, btnClick, btnStyle, btnTextStyle

		} = this.props

		let child = this.props.children
		if (child && child.length && child.length > 0) {
			throw new Error('onlyChild must be passed a children with exactly one child.')
		}
		let content = <View
			style={[styles.container, title ? styles.container_Title : styles.container_NoTitle, containerStyle]}>
			{child ||
			(
				<View
					style={[styles.content, title ? styles.content_Title : styles.content_NoTitle, General.borderBottom, contentStyle]}>
					{!!title &&
					<View style={[styles.titleWrap, titleWrap]}>
						<Text style={[styles.title, titleStyle]}>{title}</Text>
					</View>
					}
					{!!msg && <Text style={[styles.msg, msgStyle]}>{msg}</Text>}
				</View>
			)}
			<View style={styles.bottom}>
				<TouchableOpacity
					style={[styles.btn, btnStyle]}
					onPress={() => { btnClick ? btnClick() : this.hide() }}>
					<Text style={[styles.btnText, btnTextStyle]}>{btnText}</Text>
				</TouchableOpacity>
			</View>
		</View>
		// content = child || content
		return (
			this.state.visible &&
			<View style={[styles.parent, isShowTranBg && { backgroundColor: 'rgba(0, 0, 0, 0.3)' }]}>
				<Modal
					animationType={'fade'}
					transparent={true}
					visible={this.state.visible}
					onRequestClose={this.hide}
				>
					<TouchableOpacity style={styles.wrap} activeOpacity={1}>
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
	}
})
