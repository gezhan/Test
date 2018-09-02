'use strict';

import { Platform, StyleSheet } from 'react-native';
import {
	RatiocalHeight,
	AppColors,
	AppFonts,
	General,
	AppSizes,
	RatiocalFontSize
} from '../../../style/index';

const LoanApplicationStyle = StyleSheet.create({
	applyView: {
		backgroundColor: AppColors.whiteBg,
		height: RatiocalHeight(200),
		width: AppSizes.width,
		...General.container
	},
	applyMoneyTxt: {
		marginTop: RatiocalHeight(50),
		fontSize: AppFonts.text_size_30,
		color: AppColors.lightBlackColor
	},
	applyMoneyView: {
		flexDirection: 'row',
		alignItems: 'center',
		marginTop: Platform.OS === 'ios' ? RatiocalHeight(20) : RatiocalHeight(0)
	},
	applyMoney: {
		fontSize: AppFonts.text_size_60,
		color: AppColors.lightBlackColor
	},
	moneyCode: {
		fontSize: AppFonts.text_size_30,
		color: AppColors.lightBlackColor
	},
	applyCellWrapperStyle: {
		height: parseInt(RatiocalHeight(120))
	},
	contractText: {
		color: AppColors.mainColor,
		fontSize: RatiocalFontSize(24)
	}
});
export default LoanApplicationStyle;