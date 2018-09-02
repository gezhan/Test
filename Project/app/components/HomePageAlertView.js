'use strict';
import React, { Component } from 'react';
import {
	StyleSheet,
	View,
	Text,
	Modal,
	Image,
	TouchableOpacity
} from 'react-native';

import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, General, AppSizes, AppFonts } from '../style';

export default class HomePageAlertView extends Component {
	static propTypes = {
		leftBtnText: React.PropTypes.string,
		rightBtnText: React.PropTypes.string,
		btnClick: React.PropTypes.func,
		cancelbtnClick: React.PropTypes.func
	};

	constructor (props) {
		super(props);

		this.state = {
			visible: false
		};
	}

	show = () => {
		this.setState({ visible: true });
	};

	hide = () => {
		this.setState({ visible: false });
	};

	render () {
		const {
			visible,
			centerIcon,
			animationType,
			containerStyle,
			backgroudStyle,
			topViewStyle,
			title,
			titleStyle,
			title2,
			title2Style,
			title3,
			title3Style,
			middleStyle,
			centerIconStyle,
			moneyText,
			moneyTextStyle,
			msg,
			msgStyle,
			bottomText,
			bottomViewStyle,
			bottomTextStyle,
			bottomBtnStyle,
			btnClick,
			cancelbtnClick,
			isShowCloseBtn
		} = this.props;
		let animationType1 = animationType && animationType !== '' ? animationType : 'fade';
		console.log('Modal', !!visible);
		let isShow = isShowCloseBtn !== false
		return (
			<Modal
				animationType={animationType1}
				visible={!!visible}
				transparent={true}
				onRequestClose={() => {
					this.setState({ visible: false });
				}}
			>
				<View style={[styles.container, containerStyle]}>
					<View style={[styles.backgroud, backgroudStyle]}>
						<View style={[styles.topView, topViewStyle]}>
							{!!title && <Text style={[styles.title, titleStyle]}>
								{title}
							</Text>}
							{!!title2 && <Text style={[styles.title2, title2Style]}>
								{title2}
							</Text>}
						</View>
						{isShow &&
						<TouchableOpacity style={styles.close} onPress={() => {
							!!cancelbtnClick && cancelbtnClick();
						}}>
							<Image
								source={require('../images/HomeBalanceAlert_close.png')} resizeMode={'contain'}
								style={styles.closeImg}/>
						</TouchableOpacity>
						}
						<View style={[styles.middleView, middleStyle]}>
							{!!centerIcon && <Image
								source={centerIcon}
								style={[styles.centerIcon, centerIconStyle]}>
								{!!moneyText && <Text style={[styles.moneyText, moneyTextStyle]}>
									{moneyText}
								</Text>}
							</Image>}
							{!!title3 && <Text style={[styles.title, title3Style]}>
								{title3}
							</Text>}
						</View>

						{!!msg &&
						<View style={[styles.bottomView, bottomViewStyle]}>
							<Text style={[styles.msg, msgStyle]}>
								{msg}
							</Text>
						</View>}

						<View style={styles.bottom}>
							<TouchableOpacity style={[styles.bottomBtn, bottomBtnStyle]} onPress={() => btnClick()}>
								<Text style={[styles.bottomText, bottomTextStyle]}>{bottomText}</Text>
							</TouchableOpacity>
						</View>
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
		backgroundColor: 'rgba(0, 0, 0, 0.5)',
		flexDirection: 'column',
		justifyContent: 'center',
		...General.center
	},
	closeImg: {
		width: RatiocalWidth(22),
		height: RatiocalWidth(22)
	},
	backgroud: {
		width: AppSizes.width - AppSizes.width / 4,
		borderRadius: 5,
		backgroundColor: AppColors.whiteBg,
		flexDirection: 'column'
	},
	loadingText: {
		marginTop: 10,
		textAlign: 'center',
		color: AppColors.whiteColor
	},
	topView: {
		minHeight: RatiocalHeight(50),
		paddingTop: RatiocalHeight(40),
		paddingBottom: RatiocalHeight(30),
		paddingLeft: RatiocalWidth(50),
		paddingRight: RatiocalWidth(50),
		...General.center
	},
	title: {
		fontSize: AppFonts.text_size_32,
		color: AppColors.lightBlackColor,
		backgroundColor: 'transparent',
		textAlign: 'center',
		lineHeight: parseInt(RatiocalHeight(48))
	},
	title2: {
		fontSize: AppFonts.text_size_32,
		color: AppColors.lightBlackColor,
		backgroundColor: 'transparent',
		textAlign: 'center',
		lineHeight: parseInt(RatiocalHeight(48))
	},
	close: {
		position: 'absolute',
		right: 0,
		top: 0,
		width: RatiocalWidth(42),
		height: RatiocalWidth(42),
		paddingTop: RatiocalHeight(20),
		paddingRight: RatiocalWidth(20)
	},
	msg: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightGrayColor,
		backgroundColor: 'transparent',
		textAlign: 'center'
	},
	moneyText: {
		fontSize: AppFonts.text_size_48,
		color: AppColors.subColor,
		backgroundColor: 'transparent',
		textAlign: 'center'
	},
	unit2: {
		fontSize: AppFonts.text_size_28
	},
	middleView: {
		...General.center
	},
	centerIcon: {
		width: RatiocalWidth(240),
		height: RatiocalHeight(180),
		resizeMode: 'contain',
		paddingTop: RatiocalHeight(70),
		...General.center
	},
	bottomView: {
		minHeight: RatiocalHeight(48),
		paddingTop: RatiocalHeight(30),
		paddingBottom: RatiocalHeight(40),
		...General.center
	},
	bottom: {
		flexDirection: 'row',
		height: parseInt(RatiocalHeight(90)),
		borderBottomLeftRadius: 5,
		borderBottomRightRadius: 5
	},
	bottomBtn: {
		width: AppSizes.width - AppSizes.width / 4,
		height: parseInt(RatiocalHeight(90)),
		...General.borderTop,
		...General.center
	},
	bottomText: {
		fontSize: AppFonts.text_size_36,
		color: AppColors.subColor,
		backgroundColor: 'transparent',
		...AppSizes.VerticalCenter(90)
	}
});