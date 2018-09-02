'use strict';
import React, { Component } from 'react';
import {
	StyleSheet,
	View,
	Text,
	Modal,
	Image,
	TouchableHighlight,
	TextInput,
	Platform
} from 'react-native';

import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppSizes, General } from '../style';

export default class AlertView extends Component {
	_alertViewSub = () => {
		const { input, keyboardType, visible, animationType, containerStyle, backgroudStyle, imageSource, title, leftTitle, leftTxtStyle, rightTitle, rightTxtStyle, leftAction, rightAction } = this.props;
		if (leftTitle) {
			return (
				<View style={styles.bottomView}>
					<TouchableHighlight
						style={[styles.leftView, { width: RatiocalWidth(500) }]} onPress={() => rightAction()}
						underlayColor={'#e5e5e5'}>
						<View style={styles.rightView}>
							<Text style={styles.rightText}>
								{rightTitle}
							</Text>
						</View>
					</TouchableHighlight>
				</View>
			)
		} else {
			return (
				<View style={styles.bottomView}>
					<TouchableHighlight style={styles.leftView} onPress={() => leftAction()} underlayColor={'#e5e5e5'}>
						<View style={styles.leftView}>
							<Text style={[styles.leftText, this.props.leftTxtStyle, this.props.input && { color: '#000' }]}>
								{leftTitle}
							</Text>
						</View>
					</TouchableHighlight>
					<View style={styles.verticalLine}/>
					<TouchableHighlight style={styles.leftView} onPress={() => rightAction()} underlayColor={'#e5e5e5'}>
						<View style={styles.rightView}>
							<Text style={styles.rightText}>
								{rightTitle}
							</Text>
						</View>
					</TouchableHighlight>
				</View>
			)
		}
	};

	render () {
		const { input, keyboardType, placeholderText, visible, animationType, containerStyle, backgroudStyle, topViewStyle, bigImage, imageSource, bigTitle, bigTitleStyle, title, titleStyle, leftTitle, rightTitle, leftAction, rightAction, textChange } = this.props;
		let animationType1 = animationType && animationType !== '' ? animationType : 'fade';

		let boardType;
		if (keyboardType === 'number') {
			boardType = Platform.OS === 'ios' ? 'number-pad' : 'numeric'
		} else {
			boardType = 'default'
		}
		return (
			<Modal
				animationType={animationType1}
				visible={visible}
				transparent
				onRequestClose={() => { }}
			>
				<View style={[styles.container, containerStyle]}>
					<View style={[styles.backgroud, backgroudStyle]}>
						<View style={[styles.topView, topViewStyle]}>
							{bigImage && <Image style={styles.bigImage} source={bigImage}/>}
							{imageSource && <Image style={styles.finishImage} source={imageSource}/>}
							{bigTitle &&
							<Text style={[styles.bigTitleText, bigTitleStyle]}>
								{bigTitle}
							</Text>
							}
							<Text style={[styles.finishText, titleStyle]}>
								{title}
							</Text>
							{input &&
							<View
								style={ styles.inputWrap}>
								<TextInput
									style={ styles.input }
									autoFocus={true}
									maxLength={8}
									underlineColorAndroid={'transparent'}
									onChangeText={textChange}
									placeholder={placeholderText}
									keyboardType={boardType}
								/>
							</View>
							}
						</View>
						{((leftTitle) || (rightTitle)) &&
						<View style={styles.horizontalLine}/>
						}
						{((leftTitle) || (rightTitle)) &&
						<View style={styles.bottomView}>
							{this._alertViewSub()}
						</View>
						}
					</View>
				</View>
			</Modal>
		);
	}
}
const styles = StyleSheet.create({
	container: {
		flexGrow: 1,
		height: AppSizes.height,
		paddingLeft: AppSizes.width / 4,
		paddingRight: AppSizes.width / 4,
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		flexDirection: 'column',
		...General.center
	},
	backgroud: {
		minHeight: RatiocalHeight(234),
		width: RatiocalWidth(500),
		borderRadius: 5,
		backgroundColor: '#F1F1F1',
		flexDirection: 'column',
		marginTop: RatiocalHeight(-200)
	},
	loadingText: {
		marginTop: 10,
		textAlign: 'center',
		color: AppColors.whiteColor
	},
	topView: {
		flexGrow: 1,
		flexDirection: 'column',
		padding: RatiocalHeight(30),
		minHeight: RatiocalHeight(154),
		...General.center
	},
	inputWrap: {
		width: RatiocalWidth(500) - RatiocalWidth(60),
		height: RatiocalHeight(80),
		borderWidth: AppSizes.pixelRatioWidth * 2,
		borderRadius: 5,
		marginTop: RatiocalHeight(40),
		marginBottom: RatiocalHeight(20),
		borderColor: '#e5e5e5',
		paddingHorizontal: RatiocalWidth(20)
	},
	input: {
		height: RatiocalHeight(80),
		color: AppColors.blackColor
	},
	bigImage: {
		width: RatiocalWidth(224),
		height: RatiocalWidth(168),
		resizeMode: 'contain'
	},
	finishImage: {
		width: RatiocalWidth(30),
		height: RatiocalWidth(30)
	},
	bigTitleText: {
		fontSize: RatiocalFontSize(34),
		color: '#444444',
		textAlign: 'center',
		lineHeight: Platform.OS === 'ios' ? RatiocalFontSize(43) : null
	},
	finishText: {
		fontSize: RatiocalFontSize(33),
		color: '#444444',
		textAlign: 'center',
		lineHeight: Platform.OS === 'ios' ? RatiocalFontSize(43) : null
	},
	bottomView: {
		flexGrow: 1,
		height: RatiocalHeight(80),
		width: RatiocalWidth(500),
		flexDirection: 'row'
	},
	horizontalLine: {
		backgroundColor: AppColors.grayBg,
		height: AppSizes.pixelRatioWidth * 2,
		width: RatiocalWidth(500),
		alignSelf: 'center'
	},
	verticalLine: {
		backgroundColor: AppColors.grayBg,
		height: RatiocalHeight(80),
		width: AppSizes.pixelRatioWidth * 2
	},
	leftView: {
		justifyContent: 'center',
		alignItems: 'center',
		width: RatiocalWidth(250),
		height: RatiocalHeight(80)
	},
	rightView: {
		...General.center,
		width: RatiocalWidth(250),
		height: RatiocalHeight(80)
	},
	leftText: {
		textAlign: 'center',
		fontSize: RatiocalFontSize(33),
		color: AppColors.subColor
	},
	rightText: {
		textAlign: 'center',
		fontSize: RatiocalFontSize(33),
		color: AppColors.subColor
	}
});