'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Image,
	TouchableOpacity,
	StyleSheet
} from 'react-native'
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, General } from '../style'
export default class Cell extends Component {
	constructor (props) {
		super(props)
		this.state = {}
	}

	/*

	 * @param {object} [wrapperBtnStyle] - 最外层样式(按钮层)
	 * @param {object} [wrapperStyle] - 按钮层下一层视图样式

	 * @param {boolean} [isFirst] - 是否第一个(显示上边框)
	 * @param {boolean} [isLast] - 是否最后一个(显示下边框)
	 * @param {boolean} [noBorder] - 是否显示边框

	 * @param {slot} [slotLeft] - 自定义左边
	 * @param {slot} [slotRight] - 自定义右边

	 * @param {string} [title] - 标题(左边的文字)
	 * @param {object} [leftStyle] - 标题(左边整体的样式)
	 * @param {object} [titleStyle] - 左边文字外框的样式
	 * @param {object} [titleTextStyle] - 左边文字的样式
	 * @param {img uri} [leftIcon1] - 右边的图片地址 字左边
	 * @param {img uri} [leftIcon2] - 左边的图片地址 字右边
	 * @param {object} [leftIcon1Style] - leftIcon1的样式
	 * @param {object} [leftIcon2Style] - leftIcon2的样式

	 * @param {string} [value] - 值(右边的文字)
	 * @param {object} [rightStyle] - 右边整体的样式
	 * @param {object} [valueStyle] - 右边文字外框的样式
	 * @param {object} [valueTextStyle] - 右边文字的样式
	 * @param {img uri} [rightIcon1] - 右边的图片地址 字左边
	 * @param {img uri} [rightIcon2] - 右边的图片地址 字右边 -----> clickCell点击事件存在 且 isLink为true 才显示
	 * @param {object} [rightIcon1Style] - rightIcon1的样式
	 * @param {object} [rightIcon2Style] - rightIcon2的样式

	 * @param {function} [clickCell] - 点击事件
	 * @param {boolean} [isLink] - 是否显示rightIcon2

	 */

	static defaultProps = {
		isLink: true,
		rightIcon2: require('../images/Common_Arrow.png'),
		styleType: 1
	};

	render () {
		const {
			styleType,
			mediaImg, mediaImgStyle,
			clickCell, isLink,
			isFirst, isLast, noBorder,
			wrapperBtnStyle, wrapperStyle,
			slotLeft, slotRight,

			title, leftStyle, titleStyle, titleTextStyle, leftNumberOfLines, leftAdjustsFontSizeToFit,
			leftIcon1, leftIcon2, leftIcon1Style, leftIcon2Style, leftAction1, leftAction2,

			value, rightStyle, valueStyle, valueTextStyle, rightNumberOfLines, rightAdjustsFontSizeToFit,
			rightIcon1, rightIcon2, rightIcon1Style, rightIcon2Style, rightAction1, rightAction2
		} = this.props

		let opacity = !clickCell ? 1 : 0.5
		return (
			<TouchableOpacity
				activeOpacity={opacity}
				onPress={() => { !!clickCell && clickCell() } }
				style={[CellStyle.cell1, !!wrapperBtnStyle && wrapperBtnStyle, styleType === 1 && General.container, isFirst && General.borderTop, isLast && General.borderBottom]}>

				{styleType === 2 &&
				<View style={CellStyle.Media}>
					<Image style={[CellStyle.MediaImg, mediaImgStyle]} source={mediaImg} resizeMode="contain"/>
				</View>
				}
				<View style={[CellStyle.wrapper, !isLast && !noBorder && General.borderBottom, !!wrapperStyle && wrapperStyle]}>
					<View style={[CellStyle.cellTitle, leftStyle]}>
						{!!leftIcon1 &&
						<TouchableOpacity onPress={leftAction1} activeOpacity={!leftAction1 ? 1 : 0.5}>
							<Image source={leftIcon1} style={[CellStyle.leftIcon1Style, !!leftIcon1Style && leftIcon1Style]}/>
						</TouchableOpacity>
						}
						{!slotLeft &&
						<View style={[CellStyle.title, titleStyle]}>
							<Text
								numberOfLines={leftNumberOfLines} adjustsFontSizeToFit={leftAdjustsFontSizeToFit}
								style={ [CellStyle.titleText, titleTextStyle] }>{title}</Text>
						</View>
						}
						{!!slotLeft && slotLeft()}
						{!!leftIcon2 &&
						<TouchableOpacity onPress={leftAction2} activeOpacity={!leftAction2 ? 1 : 0.5}>
							<Image source={leftIcon2} style={ [CellStyle.leftIcon2Style, !!leftIcon2Style && leftIcon2Style] }/>
						</TouchableOpacity>
						}
					</View>

					<View style={[CellStyle.cellValue, rightStyle]}>
						{!!rightIcon1 &&
						<TouchableOpacity onPress={rightAction1} activeOpacity={!rightAction1 ? 1 : 0.5}>
							<Image source={rightIcon1} style={[CellStyle.rightIcon1Style, !!rightIcon1Style && rightIcon1Style]}/>
						</TouchableOpacity>
						}
						{!slotRight &&
						<View style={[CellStyle.value, valueStyle]}>
							<Text
								numberOfLines={rightNumberOfLines} adjustsFontSizeToFit={rightAdjustsFontSizeToFit}
								style={ [CellStyle.valueText, valueTextStyle] }>{value}</Text>
						</View>
						}
						{!!slotRight && slotRight()}
						{((isLink && (!!clickCell)) || rightAction2) &&
						<TouchableOpacity onPress={rightAction2} activeOpacity={!rightAction2 ? 1 : 0.5}>
							<Image source={rightIcon2} style={[CellStyle.rightIcon2Style, !!rightIcon2Style && rightIcon2Style]}/>
						</TouchableOpacity>
						}
					</View>
				</View>

			</TouchableOpacity>
		)
	}
}

export const CellStyle = StyleSheet.create({
	cell1: {
		height: parseInt(RatiocalHeight(100)),
		backgroundColor: AppColors.whiteBg,
		flexDirection: 'row',
		paddingRight: RatiocalWidth(30)
	},
	Media: {
		flexDirection: 'row',
		alignItems: 'center',
		marginRight: RatiocalWidth(30),
		marginLeft: RatiocalWidth(30)
	},
	MediaImg: {
		width: RatiocalWidth(40),
		height: RatiocalWidth(40)
	},
	wrapper: {
		flexDirection: 'row',
		flexGrow: 1,
		justifyContent: 'space-between',
		alignItems: 'center'
	},
	cellTitle: {
		flexDirection: 'row',
		alignItems: 'center',
		marginRight: RatiocalWidth(30)
	},
	cellValue: {
		flexDirection: 'row',
		alignItems: 'center'
	},
	titleText: {
		fontSize: RatiocalFontSize(30),
		marginRight: RatiocalWidth(20),
		color: AppColors.lightBlackColor
	},
	valueText: {
		fontSize: RatiocalFontSize(30),
		color: AppColors.grayColor
	},
	leftIcon1Style: {
		marginRight: RatiocalWidth(20)
	},
	leftIcon2Style: {
		resizeMode: 'contain'
		// marginRight: RatiocalWidth(20)
	},
	rightIcon1Style: {
		marginRight: RatiocalWidth(12),
		width: RatiocalWidth(35),
		height: RatiocalWidth(35)
	},
	rightIcon2Style: {
		marginLeft: RatiocalWidth(20)
	}
})