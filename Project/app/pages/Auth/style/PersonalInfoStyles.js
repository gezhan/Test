'use strict';

import { StyleSheet } from 'react-native';
import {
	General,
	RatiocalWidth,
	RatiocalHeight,
	RatiocalFontSize,
	AppColors,
	AppFonts,
	AppSizes
} from '../../../style';

const PersonalInfoStyles = StyleSheet.create({
	topView: {
		flexDirection: 'row',
		alignItems: 'center',
		height: RatiocalHeight(64),
		...General.containerMrgin
	},
	topText: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_24
	},
	borderView: {
		height: RatiocalHeight(20)
	},
	textInPutStyle: {
		height: parseInt(RatiocalHeight(100)),
		backgroundColor: 'white',
		fontSize: RatiocalFontSize(28),
		...General.container
	},
	submitBtnbtn: {
		backgroundColor: AppColors.subColor,
		marginTop: RatiocalHeight(100),
		height: RatiocalHeight(80),
		borderRadius: 5,
		alignItems: 'center',
		justifyContent: 'center',
		...General.containerMrgin
	},
	submitBtntext: {
		fontSize: RatiocalFontSize(36),
		textAlign: 'center'
	},
	itemParentView: {
		alignItems: 'center',
		flexDirection: 'row',
		width: AppSizes.width,
		height: parseInt(RatiocalHeight(100)),
		backgroundColor: AppColors.whiteBg,
		...General.container
	},
	itemTextView: {
		color: AppColors.lightBlackColor,
		fontSize: RatiocalFontSize(28),
		paddingLeft: 0,
		paddingRight: 0
	},
	itemTextInput: {
		marginLeft: RatiocalWidth(30),
		color: AppColors.lightBlackColor,
		fontSize: RatiocalFontSize(28),
		paddingLeft: 0,
		paddingRight: 0,
		flex: 1,
		textAlign: 'right'
	},
	alertParentView: {
		padding: RatiocalWidth(30),
		paddingLeft: RatiocalWidth(15),
		paddingRight: RatiocalWidth(15)
	},

	Btn: {
		marginTop: RatiocalHeight(80),
		...General.containerMrgin
	},

	buttonBottom: {
		flexDirection: 'row',
		alignItems: 'center',
		justifyContent: 'center',
		height: RatiocalHeight(40),
		marginTop: RatiocalHeight(30),
		marginBottom: RatiocalHeight(40)
	},
	textContact: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_26,
		textAlign: 'center',
		marginLeft: RatiocalWidth(20)
	},
	TitleImg: {
		width: RatiocalWidth(26),
		height: RatiocalHeight(26),
		marginRight: RatiocalWidth(14),
		resizeMode: 'contain'
	},
	cellInputStyle: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_30
	},
	cellInputFocusStyle: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_30
	}
});

export default PersonalInfoStyles;