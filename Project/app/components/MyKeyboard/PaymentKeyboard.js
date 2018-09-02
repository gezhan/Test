'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	Animated,
	StyleSheet,
	TouchableOpacity
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../../style';

let deleteImage = require('../../images/keyboard_delete.png');
let blackDot = '●';
let onPress;
let keyValue = {
	'1': '1',
	'2': '2',
	'3': '3',
	'4': '4',
	'5': '5',
	'6': '6',
	'7': '7',
	'8': '8',
	'9': '9',
	'0': '0',
	'回退': '回退',
	'完成': '完成'
};

export class PaymentKeyboard extends Component {
	constructor (props) {
		super(props);
		this.animatedValue = new Animated.Value(-1);
	}

	componentDidMount () {
	}

	/**
	 * 进入动画
	 */
	enterAnimate () {
		this.animatedValue.setValue(-1);
		Animated.spring(
			this.animatedValue,
			{
				toValue: 0, // 属性目标值
				friction: 15, // 摩擦力 （越小 振幅越大）
				tension: 100 // 拉力
			}
		).start()
	}

	/**
	 * 退出动画
	 */
	outAnimate () {
		this.animatedValue.setValue(0);
		Animated.spring(
			this.animatedValue,
			{
				toValue: -1, // 属性目标值
				friction: 15, // 摩擦力 （越小 振幅越大）
				tension: 60 // 拉力
			}
		).start()
	}

	render () {
		const { config, userInfo, onItemClick, isPayment } = this.props;
		const marginBottom = this.animatedValue.interpolate({
			inputRange: [0, 1],
			outputRange: [0, 400]
		});
		return (
			<View style={KeyboardStyles.Container}>
				<Animated.View
					style={[KeyboardStyles.GlobalView, { marginBottom: marginBottom }]}>
					<Keyboard
						onPress={onItemClick}/>
				</Animated.View>
			</View>
		)
	}
}

export class Keyboard extends Component {
	render () {
		const { onPress } = this.props;
		return (
			<TouchableOpacity activeOpacity={1} style={KeyboardStyles.ContentView} onPress={() => {}}>
				<View style={{ flex: 3 }}>
					<View style={KeyboardStyles.RowView}>
						<Key value="1" onClick={onPress}/>
						<View style={KeyboardStyles.VerticalLineView}/>
						<Key value="2" onClick={onPress}/>
						<View style={KeyboardStyles.VerticalLineView}/>
						<Key value="3" onClick={onPress}/>
					</View>
					<View style={KeyboardStyles.RowView}>
						<Key value="4" onClick={onPress}/>
						<View style={KeyboardStyles.VerticalLineView}/>
						<Key value="5" onClick={onPress}/>
						<View style={KeyboardStyles.VerticalLineView}/>
						<Key value="6" onClick={onPress}/>
					</View>
					<View style={KeyboardStyles.RowView}>
						<Key value="7" onClick={onPress}/>
						<View style={KeyboardStyles.VerticalLineView}/>
						<Key value="8" onClick={onPress}/>
						<View style={KeyboardStyles.VerticalLineView}/>
						<Key value="9" onClick={onPress}/>
					</View>
					<View style={KeyboardStyles.RowView}>
						<Key value="0" onClick={onPress}/>
					</View>
				</View>
				<View style={KeyboardStyles.LongVerticalLineView}/>
				<View style={{ flex: 1.14, borderTopWidth: AppSizes.pixelRatioWidth, borderColor: AppColors.grayBorder }}>
					<Key value="回退" onClick={onPress} keyStyle={KeyboardStyles.DeleteView} isDelete/>
					<Key value="完成" onClick={onPress} keyStyle={KeyboardStyles.CompleteView} isComplete/>
				</View>
			</TouchableOpacity>
		)
	}
}

export class Key extends Component {
	render () {
		const { value, onClick, keyStyle, KeyTextStyle, isDelete, isComplete } = this.props;
		return (
			<TouchableOpacity
				style={[KeyboardStyles.KeyTextView, keyStyle]}
				onPress={() => { onClick && onClick(keyValue[value]) }}>
				{
					isDelete
						? <Image style={{ resizeMode: 'stretch' }} source={deleteImage}/>
						: isComplete ? <Text style={{ fontSize: RatiocalFontSize(36), color: AppColors.whiteColor }}>
							{
								value
							}
						</Text> : <Text style={[KeyboardStyles.KeyText, KeyTextStyle]}>{value}</Text>
				}
			</TouchableOpacity>
		)
	}
}

const KeyboardStyles = StyleSheet.create({
	Container: {
		flex: 1,
		flexDirection: 'column',
		alignItems: 'center',
		justifyContent: 'flex-end'
	},
	GlobalView: {
		width: AppSizes.width,
		alignItems: 'center',
		justifyContent: 'center',
		backgroundColor: AppColors.whiteBg
	},
	ContentView: {
		height: RatiocalHeight(404),
		width: AppSizes.width,
		alignItems: 'center',
		justifyContent: 'center',
		flexDirection: 'row'
	},
	RowView: {
		flex: 1,
		alignItems: 'center',
		justifyContent: 'center',
		flexDirection: 'row',
		borderTopWidth: AppSizes.pixelRatioWidth,
		borderColor: AppColors.grayBorder
	},
	KeyTextView: {
		flex: 1,
		height: RatiocalHeight(101),
		alignItems: 'center',
		justifyContent: 'center'
	},
	KeyText: {
		fontSize: RatiocalFontSize(48),
		color: AppColors.middleBlackColor
	},
	VerticalLineView: {
		width: AppSizes.pixelRatioWidth,
		height: RatiocalHeight(100),
		backgroundColor: AppColors.grayBg
	},
	LongVerticalLineView: {
		width: AppSizes.pixelRatioWidth,
		height: RatiocalHeight(404),
		backgroundColor: AppColors.grayBg
	},
	HorizontalLineView: {
		width: AppSizes.width,
		height: AppSizes.pixelRatioWidth,
		backgroundColor: AppColors.grayBg
	},
	DeleteView: {
		backgroundColor: AppColors.whiteBg
	},
	CompleteView: {
		backgroundColor: AppColors.mainColor,
		marginTop: AppSizes.pixelRatioWidth * (-1)
	}
});