/**
 * 借款记录 样式
 */

'use strict';

import { StyleSheet } from 'react-native';
import {
	RatiocalWidth,
	RatiocalHeight,
	RatiocalFontSize,
	AppColors,
	AppFonts,
	AppSizes,
	General
} from '../../../style';

const AuthStyle = StyleSheet.create({
	/* -------------------------------------- 头部 -------------------------------------- */
	Title: {
		flexDirection: 'row',
		alignItems: 'center',
		height: RatiocalHeight(64),
		...General.containerMrgin
	},
	TitleImg: {
		width: RatiocalWidth(26),
		height: RatiocalHeight(26),
		marginRight: RatiocalWidth(14),
		resizeMode: 'contain'
	},
	TitleText: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_24
	},
	Btn: {
		marginTop: RatiocalHeight(120),
		...General.containerMrgin
	},
	NoReportImg: {
		width: RatiocalWidth(183),
		height: RatiocalWidth(183),
		marginTop: RatiocalHeight(50),
		alignItems: 'center',
		resizeMode: 'contain'
	}
});

export default AuthStyle;