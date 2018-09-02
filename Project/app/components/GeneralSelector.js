'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	ListView,
	TouchableWithoutFeedback,
	Modal,
	TouchableOpacity,
	StyleSheet
} from 'react-native'
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../style'

export default class GeneralSelector extends Component {
	constructor (props) {
		super(props)
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2,
			sectionHeaderHasChanged: (s1, s2) => s1 !== s2
		})
		this.state = {
			dataSource: ds,
			modelVisible: false
		}
	}

	show = () => {
		this.setState({
			modelVisible: true
		})
	}

	hidden = () => {
		this.setState({
			modelVisible: false
		})
	}

	renderRow1 = (rowData, sectionID, rowID) => {
		const { clickCell, Key, listDataStyle } = this.props
		return (
			<TouchableOpacity onPress={() => clickCell(rowData, sectionID, rowID)} style={GeneralSelectorStyle.listViewBtn}>
				<View >
					<View style={GeneralSelectorStyle.listViewContent}>
						<Text style={[GeneralSelectorStyle.listViewText, listDataStyle]}>{Key ? rowData[Key] : rowData}</Text>
					</View>
					<View style={{ height: 0.5, width: AppSizes.width, backgroundColor: AppColors.grayBorder }}/>
				</View>
			</TouchableOpacity>
		)
	}

	render () {
		const { contentStyle, title, titleStyle, listData, cancelBtnVisible, canScroll = false } = this.props
		return (
			<Modal
				animationType={'fade'}
				visible={this.state.modelVisible}
				transparent
				onRequestClose={() => { this.setState({ modelVisible: false }) } }>
				<TouchableWithoutFeedback onPress={() => { this.setState({ modelVisible: false }) }}>
					<View style={{ flexGrow: 1, backgroundColor: 'rgba(0, 0, 0, 0.3)' }}>
						<View
							style={[GeneralSelectorStyle.pickListContent, { height: RatiocalHeight(100) * listData.length },
								!!cancelBtnVisible && { height: RatiocalHeight(100) + RatiocalHeight(100) * listData.length },
								!!title && { height: RatiocalHeight(100) + RatiocalHeight(100) * listData.length },
								(!!cancelBtnVisible && !!title) && { height: RatiocalHeight(100) + RatiocalHeight(100) + RatiocalHeight(100) * listData.length }
							]}>
							{!!title &&
								<View style={[GeneralSelectorStyle.content, General.borderBottom, contentStyle]}>
									<Text style={[GeneralSelectorStyle.title, titleStyle]}>{title}</Text>
								</View>
							}
							<ListView
								showsVerticalScrollIndicator={false}
								scrollEnabled={canScroll}
								style={[GeneralSelectorStyle.pickList, { height: RatiocalHeight(100) * listData.length }]}
								dataSource={this.state.dataSource.cloneWithRows(listData)}
								renderRow={this.renderRow1}
								removeClippedSubviews={false}
								enableEmptySections={true}/>
							{!!cancelBtnVisible &&
							<TouchableOpacity
								style={{ backgroundColor: '#e5e5e5', paddingTop: RatiocalHeight(10) }}
								onPress={() => {
									this.setState({ modelVisible: false })
								}}
								underlayColor={'#e5e5e5'}>
								<View style={ GeneralSelectorStyle.horizontalLine }/>
								<View style={GeneralSelectorStyle.pickHear}>
									<Text style={ GeneralSelectorStyle.cancelBtnText }>
										{'取消'}
									</Text>
								</View>
							</TouchableOpacity>
							}
						</View>
					</View>
				</TouchableWithoutFeedback>
			</Modal>
		)
	}
}

// GeneralSelector
export const GeneralSelectorStyle = StyleSheet.create({
	listViewBtn: {
		...General.borderBottom,
		height: RatiocalHeight(100)
	},
	content: {
		height: RatiocalHeight(100),
		paddingLeft: RatiocalWidth(30),
		paddingRight: RatiocalWidth(30),
		paddingTop: RatiocalHeight(30),
		paddingBottom: RatiocalHeight(30),
		alignItems: 'center'
	},
	title: {
		fontSize: AppFonts.text_size_30,
		color: AppColors.grayColor,
		// ...AppSizes.VerticalCenter(50),
		textAlign: 'center'
	},
	listViewContent: {
		...General.center,
		width: AppSizes.width,
		height: RatiocalHeight(100)
	},
	listViewText: {
		fontSize: AppFonts.text_size_34,
		color: AppColors.lightBlackColor,
		textAlign: 'center'
	},
	pickListContent: {
		position: 'absolute',
		bottom: 0,
		height: RatiocalHeight(600),
		width: AppSizes.width,
		backgroundColor: AppColors.whiteBg
	},
	pickHear: {
		justifyContent: 'center',
		paddingTop: RatiocalHeight(10),
		alignItems: 'center',
		width: AppSizes.width,
		height: RatiocalHeight(100),
		backgroundColor: AppColors.whiteBg
	},
	pickList: {
		height: RatiocalHeight(600),
		width: AppSizes.width,
		backgroundColor: AppColors.whiteBg
	},
	horizontalLine: {
		backgroundColor: AppColors.grayBg,
		height: AppSizes.pixelRatioWidth,
		width: AppSizes.width - RatiocalWidth(60),
		alignSelf: 'center'
	},
	cancelBtnText: {
		fontSize: RatiocalFontSize(34),
		color: AppColors.mainColor,
		textAlign: 'center',
		fontWeight: 'bold'
	}
})