/**
 * 账单详情样式
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

const LoanDetailStyle = StyleSheet.create({
	scrollViewParent: {
		height: Platform.OS === 'android' ? AppSizes.height - 44 - RatiocalHeight(98) - StatusBar.currentHeight : AppSizes.height === 812 ? AppSizes.height - 80 - RatiocalHeight(98) : AppSizes.height - 64 - RatiocalHeight(98),
		width: AppSizes.width,
		flexDirection: 'column'
	},
	topView: {
		width: AppSizes.width,
		height: RatiocalHeight(178),
		backgroundColor: AppColors.mainBg,
		alignItems: 'center'
	},
	topText1: {
		fontSize: AppFonts.text_size_30,
		color: AppColors.lightBlackColor,
		marginTop: RatiocalHeight(34)
	},
	topText2: {
		fontSize: AppFonts.text_size_52,
		color: AppColors.lightBlackColor,
		fontWeight: 'bold',
		marginTop: RatiocalHeight(8)
	}
});
export default LoanDetailStyle