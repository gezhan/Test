/**
 * App Theme - Sizes
 *
 */
import { Dimensions, Platform, PixelRatio } from 'react-native';

const { width, height } = Dimensions.get('window');
const screenHeight = width < height ? height : width;
const screenWidth = width < height ? width : height;

export function RatiocalWidth (originalWidth) {
	return ((originalWidth / 2) / 375) * width;
}
export function RatiocalHeight (originalHeight) {
	return height === 812 ? ((originalHeight / 2) / 667) * 667 : ((originalHeight / 2) / 667) * height;
}
export function RatiocalFontSize (originalFont) {
	return ((originalFont / 2) / 375) * width;
}
export function VerticalCenter (height) {
	let ratio = 9;
	let adjustHeight = height >= 60 ? 0 : height / ratio;
	if (Platform.OS === 'ios') {
		return {
			height: parseInt(RatiocalHeight(height)),
			lineHeight: RatiocalHeight(height - adjustHeight)
		};
	} else {
		return {
			height: parseInt(RatiocalHeight(height)),
			textAlignVertical: 'center'
		};
	}
}

export default {
	VerticalCenter: VerticalCenter,
	height: screenHeight,
	width: screenWidth,
	realHeight: height - (Platform.OS === 'ios' ? 64 : 44),
	pixelRatioWidth: 1 / PixelRatio.get(),
	listCellGeneralHeight: RatiocalHeight(90)
};