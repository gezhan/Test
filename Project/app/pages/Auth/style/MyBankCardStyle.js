/**
 * 我的银行卡 样式
 */

'use strict';

import { StyleSheet } from 'react-native';
import { RatiocalWidth, RatiocalHeight, AppColors, AppFonts, AppSizes, General, RatiocalFontSize } from '../../../style';

const MyBankCardStyle = StyleSheet.create({
	BankBGWrap: {
		marginTop: RatiocalHeight(20),
		alignItems: 'center'
	},
	BankBG: {
		width: RatiocalWidth(704),
		height: RatiocalWidth(364),
		resizeMode: 'stretch'
	},
	BankTextWrap: {
		width: RatiocalWidth(704),
		marginTop: RatiocalHeight(145),
		paddingHorizontal: RatiocalWidth(30),
		flexDirection: 'row',
		justifyContent: 'space-around',
		alignItems: 'center'
	},
	BankText1: {
		backgroundColor: AppColors.tranBg,
		color: AppColors.whiteColor,
		paddingTop: RatiocalHeight(10)
	},
	BankText2: {
		fontSize: RatiocalFontSize(35),
		color: AppColors.whiteColor,
		backgroundColor: AppColors.tranBg

	}
});

export default MyBankCardStyle;