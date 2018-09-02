/**
 * 账单样式
 */

'use strict';

import { StyleSheet, Platform, StatusBar } from 'react-native';
import {
	RatiocalWidth,
	RatiocalHeight,
	RatiocalFontSize,
	AppColors,
	AppFonts,
	AppSizes,
	General
} from '../../../style';
import DeviceInfo from '../../../utils/DeviceInfo'

const LoanStyle = StyleSheet.create({
	navRightTxt: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.whiteColor
	},
	scrollViewParent: {
		height: Platform.OS === 'android' ? AppSizes.height - 44 - RatiocalHeight(98) - RatiocalHeight(358 + 20) - (DeviceInfo.getModel() === 'OS105' ? -RatiocalHeight(20) : StatusBar.currentHeight) : AppSizes.height - (AppSizes.height === 812 ? -88 : -64) - RatiocalHeight(98) - RatiocalHeight(358 + 20),
		width: AppSizes.width
	},
	detailScrollViewParent: {
		height: Platform.OS === 'android' ? AppSizes.height - 44 - RatiocalHeight(358 + 20) - (DeviceInfo.getModel() === 'OS105' ? -RatiocalHeight(20) : StatusBar.currentHeight) : AppSizes.height - (AppSizes.height === 812 ? 88 : 64),
		width: AppSizes.width
	},
	noOrderView: {
		width: AppSizes.width,
		marginTop: RatiocalHeight(140),
		alignItems: 'center'
	},
	noOrder: {
		height: RatiocalHeight(124),
		width: RatiocalWidth(124),
		resizeMode: 'contain'
	},
	noOrderText: {
		fontSize: AppFonts.text_size_30,
		color: AppColors.lightBlackColor,
		marginTop: RatiocalHeight(60),
		marginBottom: RatiocalHeight(160)
	},
	buttonText: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_34
	},
	overValueTxt: {
		color: AppColors.warmRedColor,
		fontSize: AppFonts.text_size_28
	},
	topView: {
		position: 'absolute',
		alignItems: 'center',
		resizeMode: 'stretch',
		width: AppSizes.width,
		backgroundColor: AppColors.mainColor,
		height: Platform.OS === 'ios' ? (AppSizes.height === 812 ? 44 : 20) + 44 + RatiocalHeight(358) : 44 + RatiocalHeight(358)
	},
	topTxt1View: {
		height: RatiocalHeight(40),
		marginTop: RatiocalHeight(84) + 44 + (Platform.OS === 'ios' ? (AppSizes.height === 812 ? 44 : 20) : 0),
		marginBottom: RatiocalHeight(24),
		...General.center
	},
	topText1: {
		backgroundColor: AppColors.tranBg,
		fontSize: AppFonts.text_size_32,
		color: AppColors.whiteColor
	},
	topTxt2View: {
		height: RatiocalHeight(86),
		...General.center
	},
	topText2: {
		backgroundColor: AppColors.tranBg,
		fontSize: AppFonts.text_size_80,
		color: AppColors.whiteColor
	},
	topTxt3View: {
		position: 'absolute',
		bottom: RatiocalHeight(40),
		height: RatiocalHeight(46),
		width: AppSizes.width,
		flexDirection: 'row',
		justifyContent: 'flex-end',
		alignItems: 'center'
	},
	topText3: {
		color: AppColors.whiteColor,
		fontSize: AppFonts.text_size_26,
		marginRight: RatiocalWidth(30)
	},
	bottomTop: {
		marginTop: RatiocalHeight(358 + 20)
	}
});

export default LoanStyle