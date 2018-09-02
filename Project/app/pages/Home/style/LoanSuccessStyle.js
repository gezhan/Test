import { StyleSheet } from 'react-native';
import {
	General,
	AppColors,
	AppFonts,
	AppSizes,
	RatiocalWidth,
	RatiocalHeight,
	RatiocalFontSize
} from '../../../style';

const LoanSuccessStyle = StyleSheet.create({
	resultImg: {
		width: RatiocalWidth(122),
		height: RatiocalWidth(122),
		resizeMode: 'contain',
		marginTop: RatiocalHeight(140)
	},
	result: {
		marginTop: RatiocalHeight(50),
		...General.center
	},
	resultTxt: {
		lineHeight: parseInt(RatiocalHeight(52)),
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor,
		marginHorizontal: RatiocalWidth(120),
		textAlign: 'center'
	},
	resultBtn: {
		marginTop: RatiocalHeight(178)
	}
});
export default LoanSuccessStyle;