/**
 * 联系人列表 样式
 */

'use strict';

import { StyleSheet } from 'react-native';
import {
	RatiocalWidth,
	RatiocalHeight,
	AppColors,
	AppFonts,
	AppSizes,
	General
} from '../../../style';

/**
 * 常用联系人列表 样式
 */
const EmergencyContactStyle = StyleSheet.create({
	contact1: {
		backgroundColor: AppColors.whiteBg,
		marginTop: RatiocalHeight(30),
		borderWidth: AppSizes.pixelRatioWidth,
		borderRadius: RatiocalHeight(10),
		borderColor: AppColors.grayBorder,
		...General.containerMrgin
	},
	contact2: {
		backgroundColor: AppColors.whiteBg,
		marginTop: RatiocalHeight(20),
		borderWidth: AppSizes.pixelRatioWidth,
		borderRadius: RatiocalHeight(10),
		borderColor: AppColors.grayBorder,
		...General.containerMrgin
	},
	topCellWrapperStyle: {
		borderColor: AppColors.grayBorder,
		height: RatiocalHeight(80),
		borderTopLeftRadius: RatiocalHeight(10),
		borderTopRightRadius: RatiocalHeight(10),
		paddingRight: 0
	},
	bottomCellWrapperStyle: {
		borderColor: AppColors.grayBorder,
		borderBottomLeftRadius: RatiocalHeight(10),
		borderBottomRightRadius: RatiocalHeight(10)
	},
	paddingRight0: {
		backgroundColor: AppColors.tranBg,
		paddingRight: 0
	},
	paddingRight30: {
		paddingRight: RatiocalWidth(30)
	},
	cellTitle: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_24
	},
	cellWrapperStyle: {
		justifyContent: 'flex-start'
	},
	cellLeftStyle: {
		minWidth: RatiocalWidth(100)
	},
	cellRightStyle: {
		flex: 1,
		justifyContent: 'space-between'
	},
	contentWrapStyle: {
		backgroundColor: AppColors.whiteBg,
		flexDirection: 'row',
		alignItems: 'center',
		width: AppSizes.width,
		...General.container,
		...General.borderBottom
	},
	contentLeftWrapStyle: {
		paddingRight: RatiocalWidth(30),
		flexDirection: 'column',
		justifyContent: 'center',
		flex: 1
	},
	contentLeftStyle: {
		...General.borderBottom,
		flexDirection: 'row',
		alignItems: 'center',
		height: RatiocalHeight(100)
	},
	contentLeftLabelStyle: {
		minWidth: RatiocalWidth(100),
		color: AppColors.blackColor
	},
	inputs: {
		fontSize: AppFonts.text_size_28,
		flex: 1,
		marginLeft: RatiocalWidth(30),
		color: AppColors.blackColor
	},
	chooseBtn: {
		paddingLeft: RatiocalWidth(30),
		height: RatiocalHeight(200),
		width: RatiocalWidth(200),
		...General.borderLeft,
		...General.center
	},
	chooseText: {
		fontSize: AppFonts.text_size_24,
		color: AppColors.subColor,
		marginTop: RatiocalHeight(20)
	},
	nextButtonStyle: {
		marginTop: RatiocalHeight(100)
	},
	textContact: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_26,
		textAlign: 'center',
		marginLeft: RatiocalWidth(20)
	},
	buttonBottom: {
		marginTop: RatiocalHeight(60),
		height: RatiocalHeight(40),
		flexDirection: 'row',
		alignItems: 'center',
		justifyContent: 'center'
	}
});

export default EmergencyContactStyle