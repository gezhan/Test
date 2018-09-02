'use strict'

import React, { Component } from 'react'

import {
	StyleSheet,
	View,
	Text,
	Modal,
	TouchableOpacity,
	PixelRatio,
	Animated
} from 'react-native'
import { RatiocalWidth, RatiocalHeight, AppColors, AppFonts, General } from '../style'
export default class AlertType extends Component {
	static defaultProps = {
		type: 'none', 	// confirm／alert
		visibles: false,
		title: '',		// type为none时 的标题
		message: '',
		confirmLeftBtnText: '取消',
		confirmRightBtnText: '确定',
		alertBtnText: '确定',
		variable: new Animated.Value(0)
	}

	static propTypes = {
		// ...View.propTypes,
		type: React.PropTypes.string,
		visibles: React.PropTypes.bool,
		title: React.PropTypes.string,
		message: React.PropTypes.string,

		// alert
		alertSlot: React.PropTypes.func,
		alertClick: React.PropTypes.func,
		alertBtnText: React.PropTypes.string,

		// type=none 传此参数(点击模态框，关闭模态框)
		close: React.PropTypes.func,
		// confirm
		confirmLeftBtnText: React.PropTypes.string,
		confirmRightBtnText: React.PropTypes.string,
		confirmLeftBtnTextClick: React.PropTypes.func,
		confirmRightBtnTextClick: React.PropTypes.func

	}

	constructor (props) {
		super(props)

		this.state = {
			modalVisible: false
		}
	}

	componentWillMount () {

	}

	componentWillReceiveProps (nextProps) {
		this.setState({
			modalVisible: nextProps.visibles
		})
	}

	show = () => {
		this.setState({ modalVisible: true })
	}
	close = () => {
		this.setState({ modalVisible: false })
	}

	renderText () {
		let content
		if (!this.props.alertSlot) {
			let msgList = this.props.message.split('#')
			let message = msgList.map((item, index) => {
				if (item === '邮箱文本已复制到粘贴板') {
					return (
						<Text
							key={index}
							style={ { fontSize: AppFonts.text_size_28, color: AppColors.grayColor, height: RatiocalHeight(55) } }>邮箱文本已复制到粘贴板</Text>
					)
				} else {
					return (
						<Text key={index} style={ stylesText.contentText }>{item}</Text>
					)
				}
			})
			content = message
		} else {
			content = this.props.alertSlot()
		}
		return (
			<View style={stylesText.innerContainer}>
				{ !!this.props.title && <Text style={stylesText.title}>{this.props.title}</Text>}
				<View style={[stylesText.content]}>
					{content}
				</View>
			</View>
		)
	}

	renderAlert () {
		let content
		if (!this.props.alertSlot) {
			let message = this.props.message.split('#').map((item, index) => {
				return (
					<Text key={index} style={ [stylesConfirm.contentText, this.props.messageStyle]}>{item}</Text>
				)
			})
			content = message
		} else {
			content = this.props.alertSlot()
		}

		return (
			<View style={stylesAlert.innerContainer}>
				<View style={[stylesAlert.content, this.props.contentStyle]}>
					{content}
				</View>
				<TouchableOpacity style={stylesAlert.alertBtn} onPress={() => { this.props.alertClick() }}>
					<Text style={[stylesAlert.alertBtnText, this.props.alertBtnTextStyle]}>{this.props.alertBtnText}</Text>
				</TouchableOpacity>
			</View>
		)
	}

	renderConfirm () {
		const {
			innerContainer,
			confirmSlot,
			variable,
			theme
		} = this.props

		let content, list
		if (this.props.message) {
			list = this.props.message.split('#')
			content = list.map((item, index) => {
				return (
					<Text key={index} style={ [stylesConfirm.contentText, this.props.messageStyle]}>{item}</Text>
				)
			})
		}
		if (confirmSlot) {
			content = this.props.confirmSlot()
		}
		return (
			<Animated.View
				style={[stylesConfirm.innerContainer, theme === 'gray' && { backgroundColor: AppColors.lightGrayBg }, !!innerContainer && innerContainer, { marginBottom: variable }]}>
				<View
					style={[stylesConfirm.content, (list && list.length <= 1) && stylesConfirm.content2, this.props.contentStyle]}>
					{content}
				</View>
				<View style={stylesConfirm.confirmBottom}>
					<TouchableOpacity style={stylesConfirm.confirmBtn} onPress={() => { this.props.confirmLeftBtnTextClick() }}>
						<Text
							style={[stylesConfirm.confirmBtnLeft, stylesConfirm.confirmBtnText, this.props.confirmBtnLeftStyle]}>{this.props.confirmLeftBtnText}</Text>
					</TouchableOpacity>
					<View style={stylesConfirm.centerLine}/>
					<TouchableOpacity style={stylesConfirm.confirmBtn} onPress={() => { this.props.confirmRightBtnTextClick() }}>
						<Text
							style={[stylesConfirm.confirmBtnRight, stylesConfirm.confirmBtnText, this.props.confirmBtnRightStyle]}>{this.props.confirmRightBtnText}</Text>
					</TouchableOpacity>
				</View>

			</Animated.View>
		)
	}

	_onRequestClose () {
		console.log('已关闭')
	}

	_close = () => {
		if (this.props.close) {
			this.props.close()
		} else {
			if (this.props.type === 'none') {
				this.setState({ modalVisible: false })
				!!this.props.closeCallback && this.props.closeCallback()
			}
		}
	}

	render () {
		const { container } = this.props
		if (!this.state.modalVisible) {
			return null
		} else {
			let content = this.props.type === 'none' ? this.renderText()
				: this.props.type === 'alert' ? this.renderAlert() : this.renderConfirm()
			return (
				<Modal
					animationType={'fade'}
					transparent={true}
					visible={this.state.modalVisible}
					onRequestClose={() => this._onRequestClose() }
				>
					<TouchableOpacity
						style={[styles.container, !!container && container]}
						activeOpacity={1}
						onPress={ this._close }>
						{content}
					</TouchableOpacity>
				</Modal>
			)
		}
	}
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		justifyContent: 'center',
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		...General.center
	}
})

const stylesText = StyleSheet.create({
	innerContainer: {
		backgroundColor: '#fff',
		borderRadius: 5,
		width: RatiocalWidth(540),
		minHeight: RatiocalHeight(280),
		paddingHorizontal: RatiocalWidth(58),
		paddingVertical: RatiocalHeight(44),
		// paddingTop: RatiocalHeight(44),
		// paddingBottom: RatiocalHeight(76),
		alignItems: 'center'
	},
	title: {
		height: RatiocalHeight(56),
		fontSize: AppFonts.text_size_36,
		color: AppColors.mainColor
	},
	content: {
		flexGrow: 1,
		...General.center,
		justifyContent: 'space-around',
		alignItems: 'center'
		// paddingBottom: RatiocalHeight(10)
	},
	content1: {
		justifyContent: 'flex-start'
	},
	contentText: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor,
		lineHeight: parseInt(RatiocalHeight(55)),
		includeFontPadding: false
	}
})

const stylesAlert = StyleSheet.create({
	innerContainer: {
		backgroundColor: '#fff',
		borderRadius: 5,
		width: RatiocalWidth(540),
		minHeight: RatiocalHeight(280)
	},
	content: {
		flexGrow: 1,
		minHeight: RatiocalHeight(190),
		paddingHorizontal: RatiocalHeight(58),
		...General.center,
		...General.borderBottom
	},
	contentText: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor,
		lineHeight: parseInt(RatiocalHeight(50))
	},
	alertBtn: {
		height: RatiocalHeight(90),
		borderBottomLeftRadius: 5,
		borderBottomRightRadius: 5,
		...General.center
	},
	alertBtnText: {
		color: AppColors.mainColor,
		fontSize: AppFonts.text_size_32
	}
})

const stylesConfirm = StyleSheet.create({
	innerContainer: {
		backgroundColor: '#fff',
		borderRadius: 5,
		width: RatiocalWidth(540),
		minHeight: RatiocalHeight(280)
	},
	content: {
		minHeight: RatiocalHeight(190),
		paddingHorizontal: RatiocalHeight(58),
		paddingVertical: RatiocalHeight(20),
		...General.borderBottom,
		marginBottom: RatiocalHeight(90)
	},
	content2: {
		...General.center
	},
	contentText: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor,
		lineHeight: parseInt(RatiocalHeight(50))
	},
	confirmBottom: {
		position: 'absolute',
		bottom: 0,
		left: 0,
		right: 0,
		height: RatiocalHeight(90),
		borderBottomLeftRadius: 5,
		borderBottomRightRadius: 5,
		flexDirection: 'row',
		...General.center
	},
	confirmBtn: {
		...General.center,
		width: RatiocalWidth(270),
		height: RatiocalHeight(90)
	},
	confirmBtnText: {
		fontSize: AppFonts.text_size_32
	},
	confirmBtnLeft: {
		color: AppColors.mainColor
	},
	confirmBtnRight: {
		color: AppColors.orangeColor
	},
	centerLine: {
		width: 1 / PixelRatio.get(),
		height: RatiocalHeight(90),
		backgroundColor: AppColors.grayBorder
	}
})
