import {
	StyleSheet
} from 'react-native';
import {
	General,
	AppSizes,
	AppColors,
	AppFonts,
	RatiocalHeight,
	RatiocalFontSize,
	RatiocalWidth
} from '../../../style';

const LoginStyle = StyleSheet.create({
	scrollStyle: {
		flexDirection: 'row',
		width: AppSizes.width * 2,
		marginTop: 10
	},
	inputParentStyle: {
		width: AppSizes.width
	},
	inputStyle: {
		fontSize: RatiocalFontSize(28),
		color: AppColors.lightBlackColor,
		textAlign: 'left'
	},
	codeBtnStyle: {
		justifyContent: 'center',
		alignItems: 'center',
		marginLeft: RatiocalWidth(20),
		width: RatiocalWidth(150),
		height: RatiocalHeight(54),
		borderRadius: RatiocalHeight(60) / 5,
		borderWidth: AppSizes.pixelRatioWidth * 2,
		borderColor: AppColors.lightBlackColor
	},
	codeTxtStyle: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_24,
		textAlign: 'center'
	},
	submitBtn: {
		marginTop: RatiocalHeight(60),
		marginBottom: RatiocalHeight(18)
	},
	fakeSubmitBtn: {
		marginTop: RatiocalHeight(60),
		marginBottom: RatiocalHeight(18)
	},
	tabWrapper: {
		backgroundColor: '#fff',
		height: parseInt(RatiocalHeight(110)),
		...General.container
	},
	tabInner: {
		flexDirection: 'row',
		flex: 1,
		...General.borderBottom
	},
	tab: {
		...AppSizes.VerticalCenter(109),
		flex: 1,
		textAlign: 'center',
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_30
	},
	tabLine: {
		backgroundColor: AppColors.mainColor,
		height: 2,
		width: (AppSizes.width - RatiocalWidth(60)) / 2,
		position: 'absolute',
		left: 0,
		top: RatiocalHeight(109) - 2
	},
	forgetPwdParent: {
		flexDirection: 'row',
		justifyContent: 'flex-end'
	},
	forgetPwd: {
		color: AppColors.mainColor,
		fontSize: AppFonts.text_size_28,
		marginTop: RatiocalHeight(10 + 12),
		marginRight: RatiocalWidth(30),
		marginLeft: RatiocalWidth(30)
	},
	TipView: {
		height: RatiocalHeight(48),
		...General.center
	},
	Tip1: {
		fontSize: AppFonts.text_size_24,
		color: AppColors.grayColor
	},
	Tip2: {
		fontSize: AppFonts.text_size_24,
		color: AppColors.lightBlackColor
	},
	cellwrapper: {
		height: parseInt(RatiocalHeight(110))
	},
	leftTextStyle: {
		width: RatiocalWidth(100)
	}
});

export default LoginStyle