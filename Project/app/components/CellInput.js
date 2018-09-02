'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	TextInput,
	StyleSheet,
	TouchableOpacity
} from 'react-native';

import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../style';

export default class CellInput extends Component {
	static defaultProps = {
		autoFocus: false
	}

	constructor (props) {
		super(props);
		this.eyesClose = require('../images/Eyes_Close.png');
		this.eyesOpen = require('../images/Eyes_Open.png');
		this.state = {
			eyeIcon: this.eyesClose,
			secureTextEntry: this.props.showEyes
		};
	}

	changeEye = () => {
		this.setState({
			eyeIcon: this.state.secureTextEntry ? this.eyesOpen : this.eyesClose,
			secureTextEntry: !this.state.secureTextEntry
		})
	}

	render () {
		const {
			showEyes, eyeBtnStyle, eyeIconStyle, leftTitle, leftTextStyle, leftIcon, leftIconStyle, placeholder, value, cellwrapper, InputStyle, inputRef, editable, textChange, secureTextEntry, clearButtonMode, onFocus, onBlur, maxLength, btnStyle, rightIcon, rightIconStyle, rightClick, rightComponent, isFirst, isLast, noBorder, keyboardType, autoFocus
		} = this.props;
		return (
			<View
				style={[Styles.cellwrapper, General.container, isFirst && General.borderTop, isLast && General.borderBottom, cellwrapper]}>
				<View style={[Styles.cell, !isLast && General.borderBottom]}>
					{!!leftIcon && <Image style={[Styles.leftIconStyle, leftIconStyle]} source={leftIcon}/>}
					{!!leftTitle && <Text style={[Styles.leftTextStyle, leftTextStyle]}>{leftTitle}</Text>}
					<TextInput
						ref={inputRef}
						style={[Styles.inPutStyle, InputStyle]}
						value={value}
						placeholderTextColor={this.props.placeholderColor || AppColors.ironColor}
						placeholder={placeholder}
						maxLength={maxLength}
						onFocus={onFocus}
						onBlur={onBlur}
						editable={editable}
						secureTextEntry={secureTextEntry || this.state.secureTextEntry}
						onChangeText={text => textChange(text)}
						underlineColorAndroid="transparent"
						autoFocus={autoFocus}
						// ('never', 'while-editing', 'unless-editing', 'always') #
						clearButtonMode={clearButtonMode || 'while-editing'}
						keyboardType={keyboardType || 'default'}
					/>
					{showEyes &&
					<TouchableOpacity style={[Styles.eyeBtnStyle, eyeBtnStyle]} onPress={this.changeEye} activeOpacity={1}>
						<Image source={this.state.eyeIcon} resizeMode="contain" style={[Styles.eyeIcon, eyeIconStyle]}/>
					</TouchableOpacity>
					}
					{!!rightIcon &&
					<TouchableOpacity
						style={[Styles.btnStyle, btnStyle]} onPress={rightClick || null}
						activeOpacity={rightClick ? 0.5 : 1}>
						<Image source={rightIcon} resizeMode="contain" style={[Styles.rightIcon, rightIconStyle]}/>
					</TouchableOpacity>
					}
					{ rightComponent ? rightComponent() : this.props.children }
				</View>
			</View>
		)
	}
}
const Styles = StyleSheet.create({
	cellwrapper: {
		backgroundColor: AppColors.whiteBg,
		height: parseInt(RatiocalHeight(100)),
		paddingBottom: AppSizes.pixelRatioWidth
	},
	cell: {
		flexDirection: 'row',
		flexGrow: 1,
		alignItems: 'center'
	},
	leftIconStyle: {
		marginRight: RatiocalWidth(30),
		width: RatiocalWidth(44),
		height: RatiocalHeight(44)
	},
	leftTextStyle: {
		marginRight: RatiocalWidth(40),
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_28
	},
	inPutStyle: {
		flex: 1,
		textAlign: 'right',
		color: AppColors.lightBlackColor,
		fontSize: RatiocalFontSize(28)
	},
	btnStyle: {
		height: RatiocalHeight(50),
		width: RatiocalWidth(50),
		...General.center
	},
	eyeBtnStyle: {
		height: RatiocalHeight(50),
		width: RatiocalWidth(50),
		...General.center
	},
	eyeIconStyle: {
		height: RatiocalHeight(36),
		width: RatiocalWidth(22)
	}
})