import { StyleSheet } from 'react-native';
import {
	General,
	AppColors,
	AppFonts,
	AppSizes,
	RatiocalWidth,
	RatiocalHeight,
	RatiocalFontSize,
} from '../../../style';

const SelectBankStyle = StyleSheet.create({
	bankNameText: {
		fontSize: RatiocalFontSize(28),
		color: AppColors.lightBlackColor
	},
	CardNumberText: {
		fontSize: RatiocalFontSize(22),
		color: AppColors.grayColor
	},
	bindButton: {
		marginTop: RatiocalHeight(50),
		marginRight: RatiocalWidth(30),
		marginLeft: RatiocalWidth(30)
	}
})
export default SelectBankStyle