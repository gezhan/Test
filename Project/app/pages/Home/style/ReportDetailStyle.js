/**
 * 报告详情样式
 */

'use strict';

import {StyleSheet, Platform, StatusBar} from 'react-native';
import {
	RatiocalHeight,
	RatiocalWidth,
	AppColors,
	AppFonts,
	General,
	AppSizes, RatiocalFontSize
} from '../../../style/index';

const ReportDetaileStyle = StyleSheet.create({
	scrollParent: {
		width: AppSizes.width,
		height: Platform.OS === 'ios' ? AppSizes.height === 812 ? AppSizes.height - RatiocalHeight(88) - 88 : AppSizes.height - RatiocalHeight(88) - 64 : AppSizes.height - StatusBar.currentHeight - RatiocalHeight(88) - 44// 44(title高度)+(tab高度)
	},
	scrollParent2: {
		width: AppSizes.width,
		height: Platform.OS === 'ios' ? AppSizes.height === 812 ? AppSizes.height - 88 : AppSizes.height - 64 : AppSizes.height - StatusBar.currentHeight - 44// 44(title高度)+(tab高度)
	},
	scrollView: {
		flex: 1
	},
	Btn: {
		position: 'absolute',
		bottom: RatiocalHeight(0),
		borderRadius: 0,
		width: AppSizes.width
	},
	creditHead: {
		height: RatiocalHeight(480),
		alignItems: 'center',
		backgroundColor: 'white',
		marginTop: 10,
		paddingVertical: 20
	},
	creditPanelView: {
		alignItems: 'center',
		justifyContent: 'center'
	},
	creditPanelImg: {
		width: RatiocalWidth(440),
		height: RatiocalHeight(380),
		alignItems: 'center',
		justifyContent: 'center',
		resizeMode: 'contain'
	},
	creditScore: {
		fontSize: RatiocalFontSize(60)
	},
	creditLevel: {
		fontSize: RatiocalFontSize(36)
	},
	testTime: {
		marginTop: RatiocalHeight(6),
		fontSize: RatiocalFontSize(24),
		color: '#999999'
	},
	promptView: {
		height: RatiocalHeight(26),
		marginTop: RatiocalHeight(23),
		marginBottom: RatiocalHeight(9),
		flexDirection: 'row',
		alignItems: 'center'
	},
	promptImg: {
		marginLeft: RatiocalWidth(13),
		resizeMode: 'contain'
	},
	promptText: {
		fontSize: RatiocalFontSize(24),
		color: '#333333',
		marginLeft: RatiocalWidth(7)
	}
});
export default ReportDetaileStyle;