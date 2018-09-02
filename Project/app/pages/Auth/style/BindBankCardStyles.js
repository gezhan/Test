'use strict'

import { StyleSheet, Image } from 'react-native'
import {
	RatiocalWidth,
	RatiocalHeight,
	RatiocalFontSize,
	AppColors,
	AppFonts,
	AppSizes,
	General
} from '../../../style'

// 绑定银行卡
const BindBankCardStyle = StyleSheet.create({
	content: {
		marginTop: RatiocalHeight(20)
	},
	footerSubView1: {
		flexDirection: 'row',
		alignItems: 'center',
		width: AppSizes.width - RatiocalWidth(60),
		marginTop: RatiocalHeight(20),
		...General.container
	},
	footerSubView1Image1: {
		height: RatiocalWidth(30),
		width: RatiocalWidth(30)
	},
	gouWrap: {
		borderColor: '#cccccc',
		borderWidth: 1
	},
	footerSubView1Image2: {
		flex: 1,
		resizeMode: Image.resizeMode.contain
	},
	footerSubView1Text1: {
		color: AppColors.ironColor,
		marginLeft: RatiocalWidth(20),
		fontSize: RatiocalFontSize(30),
		textAlign: 'left'
	},
	footerSubView1Text2: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_30
	},
	btnCode: {
		height: RatiocalHeight(70),
		width: RatiocalWidth(180)
	},
	btnCodeText: {
		fontSize: AppFonts.text_size_28,
		textAlign: 'center'
	},
	btnSubmit: {
		marginTop: RatiocalHeight(60),
		...General.containerMrgin
	},
	buttonBottom: {
		marginTop: RatiocalHeight(20),
		height: RatiocalHeight(40),
		flexDirection: 'row',
		alignItems: 'center',
		justifyContent: 'center'
	},
	textContact: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_26,
		textAlign: 'center',
		marginLeft: RatiocalWidth(10)
	},
	cellInputStyle: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_30
	},
	cellInputFocusStyle: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_30
	},
	cellInputStyleCenter: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_30,
		textAlign: 'center'
	},
	cellInputFocusStyleCenter: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_30,
		textAlign: 'center'
	}
})
export default BindBankCardStyle