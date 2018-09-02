/**
 * 意见反馈 样式
 */

'use strict'

import { StyleSheet } from 'react-native'
import { RatiocalHeight, RatiocalWidth, RatiocalFontSize, AppColors, AppSizes, AppFonts, General } from '../../../style'

const FeedbackStyle = StyleSheet.create({
	textInputView: {
		flexGrow: 1,
		textAlignVertical: 'top',
		...General.container,
		fontSize: AppFonts.text_size_30
	},
	showTextareaLength: {
		position: 'absolute',
		width: AppSizes.width - RatiocalWidth(30),
		bottom: RatiocalHeight(10),
		right: RatiocalWidth(30),
		textAlign: 'right',
		color: AppColors.ironColor,
		fontSize: AppFonts.text_size_30
	},
	textareaWrap: {
		paddingTop: RatiocalWidth(10),
		paddingBottom: (RatiocalWidth(10) + RatiocalFontSize(30)),
		backgroundColor: AppColors.whiteBg,
		height: RatiocalHeight(300),
		marginBottom: RatiocalHeight(100)
	}
})

export default FeedbackStyle