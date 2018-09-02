/**
 * 设置交易密码 样式
 */

'use strict';

import { StyleSheet } from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../../../style';

const ForgetPwStyle = StyleSheet.create({
	container: {
		alignItems: 'center'
	},
	tip: {
		marginTop: RatiocalHeight(86),
		fontSize: AppFonts.text_size_28,
		color: AppColors.grayColor,
		...AppSizes.VerticalCenter(50)
	},
	tel: {
		marginTop: RatiocalHeight(14),
		fontSize: RatiocalFontSize(50),
		color: AppColors.lightBlackColor,
		...AppSizes.VerticalCenter(60)
	},
	image: {
		marginTop: RatiocalHeight(80),
		height: RatiocalHeight(90),
		width: RatiocalWidth(102) * 6
	},
	tip2: {
		marginTop: RatiocalHeight(22),
		fontSize: AppFonts.text_size_24,
		color: AppColors.grayColor,
		...AppSizes.VerticalCenter(40)
	},
	send: {
		color: AppColors.mainColor
	},
	// 忘记第二步

	title: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_32,
		textAlign: 'center',
		...AppSizes.VerticalCenter(290)
	},
	title2: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_32
	},
	inPutWrapper: {
		height: RatiocalHeight(100),
		backgroundColor: AppColors.whiteBg,

		...General.container,
		...General.borderVertical
	},
	inPutStyle: {
		flex: 1,
		width: AppSizes.width - RatiocalWidth(60),
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor
	},
	nextBtn: {
		marginTop: RatiocalHeight(80),
		borderRadius: RatiocalHeight(44),
		...General.containerMrgin
	}
});

const SetPwStyle = StyleSheet.create({
	tipStyle: {
		flexGrow: 1,
		flexDirection: 'row',
		...General.center
	},
	tipTextStyle: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.grayColor
	},
	pwIconWrap: {
		width: RatiocalWidth(102),
		flexDirection: 'row',
		...General.center
	},
	textInputWrap: {
		...General.containerMrgin,
		...General.center,
		height: RatiocalHeight(90),
		marginTop: RatiocalHeight(84)
	},
	titleWrap: {
		backgroundColor: AppColors.whiteBg,
		height: RatiocalHeight(200)
	},
	listviewWrap: {
		height: RatiocalHeight(90)
	},
	image: {
		height: RatiocalHeight(90),
		width: RatiocalWidth(102) * 6
	},
	tip2: {
		marginTop: RatiocalHeight(10),
		fontSize: AppFonts.text_size_32,
		color: AppColors.lightBlackColor,
		...AppSizes.VerticalCenter(60)
	},
	checkTip: {
		width: AppSizes.width,
		textAlign: 'center',
		marginTop: RatiocalHeight(22),
		fontSize: AppFonts.text_size_24,
		color: AppColors.grayColor,
		...AppSizes.VerticalCenter(40)
	}
});

export { SetPwStyle, ForgetPwStyle }