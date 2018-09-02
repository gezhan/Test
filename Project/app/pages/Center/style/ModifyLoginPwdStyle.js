/**
 * 意见反馈 样式
 */

'use strict'

import { StyleSheet } from 'react-native'
import { RatiocalHeight, RatiocalWidth, RatiocalFontSize, AppColors, AppSizes, AppFonts, General } from '../../../style'

const ModifyLoginPwdStyle = StyleSheet.create({
	cellwrapper: {
		height: RatiocalHeight(110)
	},
	leftTextStyle: {
		width: RatiocalWidth(200),
		marginRight: 0
	},
	inputStyle: {
		textAlign: 'left',
		marginRight: RatiocalWidth(20)
	},
	buttonStyle: {
		marginTop: RatiocalHeight(90),
		...General.containerMrgin
	}
})

export default ModifyLoginPwdStyle