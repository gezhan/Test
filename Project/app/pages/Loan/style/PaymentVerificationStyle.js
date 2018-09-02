'use strict';
import {
	Image,
	StyleSheet
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppSizes, General } from '../../../style';
const PaymentVerificationStyles = StyleSheet.create({
	baseViews: {
		flex: 1,
		alignItems: 'center'
	},
	textBg: {
		backgroundColor: AppColors.whiteBg
	},
	textBg2: {
		marginTop: RatiocalHeight(20),
		...General.borderBottom,
		backgroundColor: AppColors.whiteBg
	},
	baseContent: {
		flexDirection: 'row',
		width: AppSizes.width,
		height: RatiocalHeight(100),
		alignItems: 'center'
	},
	verificationCode: {
		position: 'absolute',
		right: RatiocalWidth(30),
		width: RatiocalWidth(180),
		height: RatiocalHeight(60),
		borderColor: AppColors.cyanBg,
		borderWidth: AppSizes.pixelRatioWidth,
		borderRadius: 5,
		alignItems: 'center',
		justifyContent: 'center'
	},
	nextStepBg: {
		backgroundColor: AppColors.mainColor,
		width: RatiocalWidth(690),
		height: RatiocalHeight(80),
		borderRadius: 5,
		alignItems: 'center',
		justifyContent: 'center'
	},
	nextStepText: {
		color: AppColors.whiteBg,
		fontSize: RatiocalFontSize(36)
	},
	inputs1: {
		fontSize: RatiocalFontSize(28),
		width: 900,
		height: RatiocalHeight(100),
		borderWidth: 0,
		marginLeft: RatiocalWidth(20),
		color: AppColors.blackColor
	},
	inputs: {
		fontSize: RatiocalFontSize(28),
		flex: 1,
		height: RatiocalHeight(100),
		borderWidth: 0,
		marginLeft: RatiocalWidth(20),
		color: AppColors.blackColor
	},
	btnTextStyle: {
		color: AppColors.lightBlackColor,
		fontSize: RatiocalFontSize(36)
	},
	codeInputView: {
		width: RatiocalWidth(150),
		marginLeft: RatiocalWidth(30),
		fontSize: RatiocalFontSize(28),
		color: AppColors.blackColor
	}
});
export default PaymentVerificationStyles;