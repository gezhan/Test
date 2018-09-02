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

const RegisterStyle = StyleSheet.create({
	cellwrapper: {
		height: parseInt(RatiocalHeight(110))
	},
	leftTextStyle: {
		width: RatiocalWidth(100)
	},
	submitBtn: {
		marginTop: RatiocalHeight(80),
		marginBottom: RatiocalHeight(30)
	},
	EyesClose: {
		width: RatiocalWidth(32),
		height: RatiocalHeight(12)
	},
	EyesOpen: {
		width: RatiocalWidth(36),
		height: RatiocalHeight(22)
	},
	btnStyle: {
		height: RatiocalHeight(50),
		width: RatiocalWidth(50)
	}
});

export default RegisterStyle