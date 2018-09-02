import {
	Platform,
	StyleSheet
} from 'react-native';
import {
	General,
	AppColors,
	AppSizes,
	RatiocalHeight,
	RatiocalWidth,
	AppFonts
} from '../../../style/index';

const ReportResultStyle = StyleSheet.create({
	topbackground: {
		width: AppSizes.width,
		alignItems: 'center',
		paddingBottom: (Platform.OS === 'ios' && AppSizes.height === 812) ? RatiocalHeight(20) : RatiocalHeight(0)
	},
	topTextStyle: {
		fontSize: AppFonts.text_size_32,
		color: AppColors.lightBlackColor,
		marginTop: RatiocalHeight(50)
	},
	hintTextView: {
		marginTop: RatiocalHeight(20),
		alignItems: 'center',
		marginHorizontal: RatiocalWidth(120)
	},
	hintTextStyle: {
		lineHeight: parseInt(RatiocalHeight(35)),
		fontSize: AppFonts.text_size_24,
		color: AppColors.grayColor,
		textAlign: 'center'
	},
	headimage: {
		width: RatiocalWidth(122),
		height: RatiocalWidth(122),
		resizeMode: 'contain',
		marginTop: RatiocalHeight(140)
	},
	firstCell: {
		height: RatiocalHeight(200),
		marginTop: RatiocalHeight(200)
	},
	wrapperBtnStyle: {
		height: parseInt(RatiocalHeight(200))
	},
	cellText: {
		fontSize: AppFonts.text_size_30
	},
	exitBtn: {
		marginTop: RatiocalHeight(178),
		...General.containerMrgin
	}
});

export default ReportResultStyle;