import {
	Platform,
	StyleSheet,
	StatusBar
} from 'react-native';
import {
	General,
	AppColors,
	AppFonts,
	AppSizes,
	RatiocalWidth,
	RatiocalHeight,
	RatiocalFontSize
} from '../../../style';
import DeviceInfo from '../../../utils/DeviceInfo'

const HomeStyle = StyleSheet.create({

	/* -------------------------------------- 核心部分 -------------------------------------- */
	scrollParent: {
		paddingTop: RatiocalHeight(20),
		width: AppSizes.width,
		height: Platform.OS === 'ios' ? AppSizes.height - RatiocalHeight(98) - RatiocalHeight(160) - (AppSizes.height === 812 ? 88 : 64) : AppSizes.height - (DeviceInfo.getModel() === 'OS105' ? 0 : StatusBar.currentHeight) - RatiocalHeight(98) - RatiocalHeight(160) - 44// 44(title高度)+(tab高度)
	},
	scrollView: {
		flex: 1
	},
	/* --------------- 其他 --------------- */
	Btn: {
		position: 'absolute',
		bottom: RatiocalHeight(42),
		...General.containerMrgin
	},
	/* ---------头部panel相关------- */
	creditHead: {
		height: RatiocalHeight(480),
		alignItems: 'center',
		backgroundColor: 'white',
		paddingTop: RatiocalHeight(40),
		paddingBottom: RatiocalHeight(36)
	},
	creditPanelView: {
		alignItems: 'center',
		justifyContent: 'center'
	},
	creditPanelImg: {
		width: RatiocalWidth(418),
		height: RatiocalHeight(362),
		alignItems: 'center',
		justifyContent: 'center',
		resizeMode: 'contain'
	},
	creditScore: {
		fontSize: RatiocalFontSize(60),
		color: AppColors.mediumRiskColor
	},
	creditLevel: {
		fontSize: RatiocalFontSize(36),
		color: AppColors.mediumRiskColor
	},
	testTime: {
		marginTop: RatiocalHeight(6),
		fontSize: RatiocalFontSize(24),
		color: AppColors.grayColor
	},
	/* -----------提示------------ */
	promptView: {
		height: RatiocalHeight(26),
		marginTop: RatiocalHeight(23),
		marginBottom: RatiocalHeight(9),
		flexDirection: 'row',
		alignItems: 'center'
	},
	promptImg: {
		marginLeft: RatiocalWidth(13),
		resizeMode: 'contain'
	},
	promptText: {
		fontSize: RatiocalFontSize(24),
		color: AppColors.lightBlackColor,
		marginLeft: RatiocalWidth(7)
	},
	exampleView: {
		flex: 1,
		alignItems: 'center',
		justifyContent: 'center'
	},
	exampleImg: {
		position: 'absolute',
		top: parseInt(RatiocalHeight(100)) / 2
	}
});

export default HomeStyle;