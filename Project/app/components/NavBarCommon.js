'use strict';
import React, { Component } from 'react';
import {
	View,
	Text,
	Image,
	StatusBar,
	StyleSheet,
	Platform,
	TouchableOpacity
} from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../style';

export const MyStatusBar = ({ backgroundColor, ...props }) => (
	<View style={[NavBarStyles.statusBar, { backgroundColor }]}>
		<StatusBar backgroundColor={backgroundColor} {...props} />
	</View>
);

export default class NavigationBar extends Component {
	static defaultProps = {
		leftImage: require('../images/Common_Arrow_Back.png')
	};

	render () {
		const {
			backgroundColor, title, titleColor, titleSize, leftTitle, leftImage, leftAction, rightTitle, rightTitleStyle, rightImage, rightImageStyle, rightAction, closeImage, locatImage,
			msgNum, isShowPoint
		} = this.props;
		return (
			<LinearGradient
				colors={ backgroundColor || [AppColors.mainColor, AppColors.mainColor]}
				start={{ x: 0.0, y: 1.0 }} end={{ x: 1.0, y: 1.0 }}
				style={[NavBarStyles.barView, this.props.style]}>
				<MyStatusBar barStyle={this.props.StatusBarStyle ? this.props.StatusBarStyle : Platform.OS === 'ios' ? 'light-content' : 'default'}/>
				<View style={NavBarStyles.showView}>
					{
						(() => {
							if (leftTitle && leftImage) {
								return <TouchableOpacity style={NavBarStyles.leftNav} onPress={() => { leftAction() }}>
									<View style={ NavBarStyles.btnContainer }>
										<Image style={NavBarStyles.leftImage} source={leftImage} resizeMode="contain"/>
										<Text
											style={[NavBarStyles.barLeftButton, this.props.leftTitleColor || this.props.titleColor, { marginLeft: RatiocalWidth(10) }]}>{leftTitle}</Text>
									</View>
								</TouchableOpacity>
							} else if (leftTitle && locatImage) {
								return <TouchableOpacity style={NavBarStyles.leftNav} onPress={() => { leftAction() }}>
									<View style={ NavBarStyles.btnContainer1 }>
										<Text
											style={[NavBarStyles.barLeftButton, this.props.leftTitleColor || this.props.titleColor]}>{leftTitle}</Text>
										<Image style={NavBarStyles.leftLocateImage} source={locatImage} resizeMode="contain"/>
									</View>
								</TouchableOpacity>
							} else if (leftTitle) {
								return <TouchableOpacity
									style={NavBarStyles.leftNav}
									activeOpacity={leftAction ? 0.5 : 1}
									onPress={() => { leftAction && leftAction() }}>
									<View style={ NavBarStyles.btnContainer2 }>
										<Text
											style={[NavBarStyles.barLeftButton, this.props.leftTitleColor || this.props.titleColor]}>{leftTitle}</Text>
									</View>
								</TouchableOpacity>
							} else if (leftImage && leftAction) {
								return <TouchableOpacity style={NavBarStyles.leftNav} onPress={() => { leftAction() }}>
									<View style={ NavBarStyles.btnContainer2 }>
										<Image style={NavBarStyles.leftImage} source={leftImage} resizeMode="contain"/>
									</View>
								</TouchableOpacity>
							} else if (closeImage) {
								return <TouchableOpacity style={NavBarStyles.leftNav} onPress={() => { leftAction() }}>
									<View style={ NavBarStyles.btnContainer2 }>
										<Image
											style={[NavBarStyles.leftImage, NavBarStyles.leftImage2]}
											source={closeImage}
											resizeMode="contain"/>
									</View>
								</TouchableOpacity>
							}
						})()
					}
					{
						(() => {
							if (title) {
								return <Text
									style={[NavBarStyles.title, this.props.titleColor, this.props.titleSize]}>{title || ''}</Text>
							}
						})()
					}
					{
						(() => {
							if (rightTitle) {
								return <TouchableOpacity style={NavBarStyles.rightNav} onPress={() => { rightAction() }}>
									<View style={{ justifyContent: 'center' }}>
										<Text
											style={[NavBarStyles.barRightButton, this.props.rightTitleColor || this.props.titleColor, this.props.rightTitleStyle || this.props.rightTitleStyle]}>{rightTitle}</Text>
									</View>
								</TouchableOpacity>
							} else if (rightImage) {
								return <TouchableOpacity style={NavBarStyles.rightNav} onPress={() => { rightAction() }}>
									<View style={{ justifyContent: 'center', alignItems: 'flex-end' }}>
										<Image style={[NavBarStyles.rightImage, rightImageStyle]} source={rightImage} resizeMode="contain">
											{
												isShowPoint &&
												<View style={NavBarStyles.pointView}/>
											}
											{
												msgNum > 0 &&
												<View style={NavBarStyles.readMsgView}>
													<Text
														includeFontPadding={false}
														textAlignVertical="center" textAlign="center"
														style={NavBarStyles.msgTxt}>
														{
															msgNum > 0 && msgNum <= 99 ? msgNum
																: 99
														}
													</Text>
												</View>
											}
										</Image>
									</View>
								</TouchableOpacity>
							}
						})()
					}

				</View>
			</LinearGradient>
		);
	}
}
const NavBarStyles = StyleSheet.create({
	barView: {
		height: Platform.OS === 'android' ? 44 : AppSizes.height === 812 ? 88 : 64,
		backgroundColor: AppColors.tranBg
	},
	showView: {
		flexGrow: 1,
		alignItems: 'center',
		justifyContent: 'center',
		flexDirection: 'row',
		marginTop: Platform.OS === 'android' ? 0 : AppSizes.height === 812 ? 44 : 20,
		height: 44
	},
	btnContainer1: {
		flexDirection: 'row',
		alignItems: 'center'
	},
	btnContainer2: {
		justifyContent: 'center'
	},
	title: {
		backgroundColor: AppColors.tranBg,
		color: AppColors.whiteColor,
		fontSize: AppFonts.text_size_36
	},
	leftNav: {
		position: 'absolute',
		left: 0,
		top: 0,
		bottom: 0,
		width: RatiocalWidth(200),
		justifyContent: 'center'
	},
	leftImage: {
		marginLeft: RatiocalWidth(30),
		width: RatiocalWidth(18),
		height: RatiocalHeight(32),
		justifyContent: 'center'
	},
	leftImage2: {
		width: RatiocalWidth(40),
		height: RatiocalHeight(40)
	},
	leftLocateImage: {
		marginLeft: RatiocalWidth(10),
		width: RatiocalWidth(33),
		height: RatiocalHeight(19),
		justifyContent: 'center'
	},
	rightNav: {
		position: 'absolute',
		right: 0,
		top: 0,
		bottom: 0,
		width: RatiocalWidth(200),
		justifyContent: 'center'
	},
	rightImage: {
		overflow: 'visible',
		marginRight: RatiocalWidth(30),
		width: RatiocalWidth(40),
		height: RatiocalHeight(30),
		justifyContent: 'center'
	},
	barLeftButton: {
		backgroundColor: AppColors.tranBg,
		marginLeft: RatiocalWidth(30),
		fontSize: AppFonts.text_size_32,
		color: AppColors.whiteColor
	},
	barRightButton: {
		backgroundColor: AppColors.tranBg,
		marginRight: RatiocalWidth(30),
		textAlign: 'right',
		fontSize: AppFonts.text_size_32,
		color: AppColors.whiteColor
	},
	pointView: {
		position: 'absolute',
		top: RatiocalWidth(3),
		right: RatiocalWidth(3),
		width: RatiocalWidth(10),
		height: RatiocalWidth(10),
		borderRadius: RatiocalWidth(10) / 2,
		backgroundColor: AppColors.redBg
	},
	readMsgView: {
		position: 'absolute',
		top: -RatiocalWidth(12),
		right: -RatiocalWidth(12),
		width: RatiocalWidth(28),
		height: RatiocalWidth(28),
		borderRadius: RatiocalWidth(28) / 2,
		backgroundColor: AppColors.msgTipColor,
		...General.center
	},
	msgTxt: {
		backgroundColor: AppColors.tranBg,
		fontSize: AppFonts.text_size_16,
		color: AppColors.whiteColor
	}
});