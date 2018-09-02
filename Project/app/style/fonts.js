/**
 * App Theme - Fonts
 *
 * React Native Starter App
 * https://github.com/mcnamee/react-native-starter-app
 */
import { Dimensions, Platform } from 'react-native';
import AppSizes, { RatiocalWidth, RatiocalHeight, RatiocalFontSize } from './sizes';

function lineHeight (fontSize) {
	const multiplier = (fontSize > 20) ? 0.1 : 0.33;
	return parseInt(fontSize + (fontSize * multiplier), 10);
}

const { width, height } = Dimensions.get('window');
const base = {
	fontSize: 14,
	lineHeight: lineHeight(14),
	...Platform.select({
		ios: {
			// fontFamily: 'HelveticaNeue',
		},
		android: {
			fontFamily: 'Roboto'
		}
	})
};
const fontSize = {
	text_size_80: RatiocalFontSize(80),
	text_size_60: RatiocalFontSize(60),
	text_size_52: RatiocalFontSize(52),
	text_size_48: RatiocalFontSize(48),
	text_size_44: RatiocalFontSize(44),
	text_size_40: RatiocalFontSize(40),
	text_size_38: RatiocalFontSize(38),
	text_size_36: RatiocalFontSize(36),
	text_size_34: RatiocalFontSize(34),
	text_size_32: RatiocalFontSize(32),
	text_size_30: RatiocalFontSize(30),
	text_size_28: RatiocalFontSize(28),
	text_size_26: RatiocalFontSize(26),
	text_size_24: RatiocalFontSize(24),
	text_size_22: RatiocalFontSize(22),
	text_size_20: RatiocalFontSize(20),
	text_size_18: RatiocalFontSize(18),
	text_size_16: RatiocalFontSize(16)
};

export default {
	base: { ...base },
	h1: { ...base, fontSize: base.fontSize * 1.75, lineHeight: lineHeight(base.fontSize * 2) },
	h2: { ...base, fontSize: base.fontSize * 1.5, lineHeight: lineHeight(base.fontSize * 1.75) },
	h3: { ...base, fontSize: base.fontSize * 1.25, lineHeight: lineHeight(base.fontSize * 1.5) },
	h4: { ...base, fontSize: base.fontSize * 1.1, lineHeight: lineHeight(base.fontSize * 1.25) },
	h5: { ...base },
	...fontSize
};