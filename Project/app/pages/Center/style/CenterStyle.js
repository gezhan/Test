import {
	Platform,
	StyleSheet,
	StatusBar
} from 'react-native';
import {
	General,
	AppColors,
	AppSizes,
	RatiocalHeight,
	RatiocalWidth,
	AppFonts
} from '../../../style';

const CenterStyle = StyleSheet.create({
	msgIcon: {
		width: RatiocalWidth(46),
		height: RatiocalHeight(46),
		resizeMode: 'contain'
	},
	topBackground: {
		position: 'absolute',
		resizeMode: 'stretch',
		width: AppSizes.width,
		height: (Platform.OS === 'ios' ? (AppSizes.height === 812 ? 44 : 20) : 0) + 44 + RatiocalHeight(372),
		...General.center
	},
	headImageBackground: {
		marginTop: RatiocalHeight(20),
		width: RatiocalWidth(160),
		height: RatiocalWidth(160),
		borderRadius: RatiocalWidth(160) / 2,
		backgroundColor: AppColors.whiteBg,
		...General.center
	},
	topTextStyle: {
		backgroundColor: AppColors.tranBg,
		fontSize: AppFonts.text_size_36,
		color: AppColors.whiteColor,
		marginTop: (Platform.OS === 'ios' && AppSizes.height === 812) ? RatiocalHeight(20) : RatiocalHeight(15)
	},
	headImage: {
		width: RatiocalWidth(160),
		height: RatiocalWidth(160),
		resizeMode: 'contain'
	},
	cellParent: {
		marginTop: RatiocalHeight(372 + 20),
		flex: 1
	},
	wrapperBtnStyle: {
		height: parseInt(RatiocalHeight(120))
	},
	mediaImgStyle: {
		height: RatiocalHeight(48),
		width: RatiocalWidth(48)
	},
	cellText: {
		fontSize: AppFonts.text_size_30
	},
	exitBtn: {
		marginTop: RatiocalHeight(80),
		marginBottom: RatiocalHeight(74),
		...General.containerMrgin
	}
});

export default CenterStyle;