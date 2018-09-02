/**
 * 历史账单样式
 */

'use strict';

import { StyleSheet, Platform } from 'react-native';
import {
	RatiocalHeight,
	RatiocalWidth,
	AppColors,
	AppFonts,
	General,
	AppSizes
} from '../../../style';

const LoanHistoryStyle = StyleSheet.create({
	listView: {
		width: AppSizes.width,
		marginTop: RatiocalHeight(20),
		flex: 1
	},
	historyView: {
		flexDirection: 'row',
		justifyContent: 'space-between',
		alignItems: 'center',
		minHeight: parseInt(RatiocalHeight(118)),
		backgroundColor: AppColors.whiteBg,
		...General.container
	},
	historyLeftSub: {
		justifyContent: 'center',
		minHeight: parseInt(RatiocalHeight(118)),
		backgroundColor: AppColors.whiteBg
	},
	historyRightSub: {
		flexDirection: 'row',
		justifyContent: 'space-between',
		alignItems: 'center',
		minHeight: parseInt(RatiocalHeight(118)),
		backgroundColor: AppColors.whiteBg
	},
	historyTimeTxt: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_24
	},
	historyNameTxt: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_32
	},
	historyArrowImg: {
		marginLeft: RatiocalWidth(18)
	},
	cellTitleStyle: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_28
	},
	valueTextStyle: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_28
	},
	cellTitleStyleBacking: {
		color: AppColors.lightBlackColor
	},
	cellTitleStyleConfirm: {
		color: AppColors.warmRedColor
	},
	cellTitleStyleFinsh: {
		color: AppColors.ironColor
	},
	noDataWrap: {
		flex: 1,
		height: AppSizes.height - Platform.OS === 'android' ? 44 : AppSizes.height === 812 ? 88 : 64,
		paddingTop: RatiocalHeight(100)
	},
	noDataText: {
		color: AppColors.grayColor,
		marginTop: RatiocalHeight(70)
	}
});
export default LoanHistoryStyle