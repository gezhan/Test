/**
 * App Theme - Quick layout
 *
 */
'use strict';
import AppColors from './colors';
import AppFonts from './fonts';
import AppSizes, { RatiocalWidth, RatiocalHeight, RatiocalFontSize } from './sizes';

const General = {
	Model: {
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		position: 'absolute',
		top: 0,
		left: 0,
		width: AppSizes.width,
		height: AppSizes.height
	},
	mt20: {
		marginTop: RatiocalHeight(20)
	},
	mb20: {
		marginBottom: RatiocalHeight(20)
	},
	pt20: {
		paddingTop: RatiocalHeight(20)
	},
	pb20: {
		paddingBottom: RatiocalHeight(20)
	},
	block: {
		height: RatiocalHeight(20),
		backgroundColor: AppColors.lightGrayBg
	},
	center: {
		alignItems: 'center',
		justifyContent: 'center'
	},
	container: {
		paddingRight: RatiocalWidth(30),
		paddingLeft: RatiocalWidth(30)
	},
	containerVertical: {
		paddingTop: RatiocalWidth(30),
		paddingBottom: RatiocalWidth(30)
	},
	containerMrgin: {
		marginRight: RatiocalWidth(30),
		marginLeft: RatiocalWidth(30)
	},
	containerVerticalMrgin: {
		marginTop: RatiocalWidth(30),
		marginBottom: RatiocalWidth(30)
	},
	wrapViewGray: {
		flexGrow: 1,
		backgroundColor: AppColors.lightGrayBg
	},
	wrapViewWhite: {
		flexGrow: 1,
		backgroundColor: AppColors.whiteBg
	},
	card: {
		backgroundColor: AppColors.whiteBg,
		marginTop: RatiocalHeight(30),
		borderTopWidth: AppSizes.pixelRatioWidth,
		borderBottomWidth: AppSizes.pixelRatioWidth,
		borderColor: '#e5e5e5'
	},
	horizontalLine: {
		backgroundColor: AppColors.grayBg,
		height: AppSizes.pixelRatioWidth,
		width: AppSizes.width - RatiocalWidth(60),
		alignSelf: 'center'
	},
	lastHorizontalLine: {
		backgroundColor: AppColors.grayBg,
		height: AppSizes.pixelRatioWidth,
		width: AppSizes.width,
		alignSelf: 'center'
	},
	btn: {
		marginRight: RatiocalWidth(30),
		marginLeft: RatiocalWidth(30)
	},
	fixedBottom: {
		position: 'absolute',
		bottom: RatiocalHeight(0),
		left: 0
	},
	listViewContent: {
		backgroundColor: AppColors.whiteBg,
		width: AppSizes.width,
		height: AppSizes.realHeight
	},
	border: {
		borderColor: AppColors.grayBorder,
		borderWidth: AppSizes.pixelRatioWidth
	},
	borderBottom: {
		borderColor: AppColors.grayBorder,
		borderBottomWidth: AppSizes.pixelRatioWidth
	},
	borderTop: {
		borderColor: AppColors.grayBorder,
		borderTopWidth: AppSizes.pixelRatioWidth
	},
	borderRight: {
		borderColor: AppColors.grayBorder,
		borderRightWidth: AppSizes.pixelRatioWidth
	},
	borderLeft: {
		borderColor: 'red',
		borderLeftWidth: AppSizes.pixelRatioWidth
	},
	borderVertical: {
		borderColor: AppColors.grayBorder,
		borderTopWidth: AppSizes.pixelRatioWidth,
		borderBottomWidth: AppSizes.pixelRatioWidth
	},
	borderHorizontal: {
		borderColor: AppColors.grayBorder,
		borderRightWidth: AppSizes.pixelRatioWidth,
		borderLeftWidth: AppSizes.pixelRatioWidth
	},
	Common_Arrow: {
		resizeMode: 'contain',
		height: RatiocalHeight(26),
		width: RatiocalWidth(14)
	},
	flexRowCenter: {
		flexDirection: 'row',
		alignItems: 'center'
	},
	loanCellWrapperStyle: {
		height: parseInt(RatiocalHeight(100))
	}
};
export default General;