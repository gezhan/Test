'use strict'
/**
 * Tyrant 2017.02.17
 */
import React, { Component } from 'react'
import {
	Text,
	StyleSheet,
	TouchableHighlight
} from 'react-native'
import { RatiocalWidth, RatiocalHeight, AppColors, AppFonts, AppSizes, General } from '../style'
import LinearGradient from 'react-native-linear-gradient'

export default class ButtonHighlight extends Component {
	constructor (props) {
		super(props)
		this.state = {
			disabled: false,
			textColor: this.props.underlayTextColor || '#333333'
		}
	}

	static defaultProps = {
		LGColor: AppColors.mainLG
	}

	onPress = () => {
		this.disable()
		this.props.onPress && this.props.onPress(this.enable)
	}

	enable = () => {
		this.setState({ disabled: false, textColor: this.props.underlayTextColor || '#ffffff' })
	}

	disable = () => {
		this.setState({
			disabled: true,
			textColor: this.props.underlayTextColor || '#333333'
		})
	}

	render () {
		const { underlayColor, title, buttonStyle, titleStyle, disabled } = this.props
		let underlay = underlayColor ? [underlayColor, underlayColor] : ['#dddddd', '#dddddd']
		let LGColor = (this.state.disabled || disabled) ? underlay : this.props.LGColor
		// console.log('this.state.disabled:  ' + this.state.disabled)
		// console.log('this.props.disabled:  ' + this.props.disabled)
		// console.log('this.state.textColor:  ' + this.state.textColor)
		return (
			<TouchableHighlight
				style={[CustomBtStyles.button, buttonStyle, { backgroundColor: 'transparent' }]}
				activeOpacity={0.5}
				disabled={this.state.disabled || disabled}
				onPress={this.onPress}
				underlayColor={underlayColor || '#dddddd'}>
				<LinearGradient colors={LGColor} start={{ x: 0.0, y: 1.0 }} end={{ x: 1.0, y: 1.0 }} style={[CustomBtStyles.button, buttonStyle, CustomBtStyles.initStyle]}>
					<Text style={[CustomBtStyles.buttonTitle, titleStyle, (this.state.disabled || disabled) ? { color: this.state.textColor } : null]}>
						{title}
					</Text>
				</LinearGradient>
			</TouchableHighlight>
		)
	}
}

const CustomBtStyles = StyleSheet.create({
	pointView: {
		position: 'absolute',
		top: RatiocalHeight(5),
		right: RatiocalWidth(20),
		width: RatiocalWidth(13),
		height: RatiocalWidth(13),
		borderRadius: RatiocalWidth(13) / 2,
		backgroundColor: AppColors.redBg
	},
	button: {
		width: AppSizes.width - RatiocalWidth(60),
		height: RatiocalHeight(88),
		borderRadius: RatiocalHeight(10),
		overflow: 'visible',
		padding: 1,
		...General.center
	},
	buttonTitle: {
		backgroundColor: AppColors.tranBg,
		textAlign: 'center',
		color: AppColors.whiteColor,
		fontSize: AppFonts.text_size_32
	},
	initStyle: {
		marginTop: 0,
		marginRight: 0,
		marginBottom: 0,
		marginLeft: 0,
		top: 0,
		right: 0,
		bottom: 0,
		left: 0,
		backgroundColor: 'transparent',
		borderColor: 'transparent'
	}
})