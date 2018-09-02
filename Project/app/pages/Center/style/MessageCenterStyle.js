/**
 * 消息中心 样式
 */

'use strict';

import { StyleSheet } from 'react-native';
import { RatiocalWidth, RatiocalHeight, AppColors, AppFonts, AppSizes, General } from '../../../style';

const MessageCenterStyle = StyleSheet.create({
	navigatorBg: {
		backgroundColor: AppColors.mainColor
	},
	card: {
		width: AppSizes.width,
		marginTop: RatiocalHeight(20),
		backgroundColor: AppColors.whiteBg,
		...General.container,
		...General.borderVertical
	},
	cardHeader: {
		height: RatiocalHeight(90),
		flexDirection: 'row',
		justifyContent: 'space-between',
		alignItems: 'center',
		...General.borderBottom
	},
	title: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_30
	},
	createTime: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_24
	},
	des: {
		color: AppColors.middleBlackColor,
		fontSize: AppFonts.text_size_28
	},
	desWrap: {
		paddingVertical: RatiocalHeight(46)
	},
	isIosLineHeight: {
		lineHeight: RatiocalHeight(40)
	}
});

export default MessageCenterStyle;