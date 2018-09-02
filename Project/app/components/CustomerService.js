import React, { Component } from 'react';
import {
	View,
	Text,
	Image,
	TouchableOpacity,
	Platform,
	StyleSheet,
	StatusBar
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../style';
import DeviceInfo from '../utils/DeviceInfo'
export default class CustomerService extends Component {
	constructor (props) {
		super(props);
		this.state = {
			visible: false

		};
	}

	show = () => {
		this.setState({
			visible: true
		})
	}

	hide = () => {
		this.setState({
			visible: false
		})
	}

	render () {
		const { click } = this.props;
		return (
			this.state.visible &&
			<View style={shareStyle.Wrap}>
				<TouchableOpacity activeOpacity={1} onPress={() => this.hide()} style={{ flex: 1 }}/>
				<View style={ shareStyle.contentBlock }>
					<View style={ shareStyle.choiceWrap }>
						<TouchableOpacity style={ shareStyle.choiceBtn2 } onPress={() => { click(1); } }>
							<View style={shareStyle.inner}>
								<Image source={require('../images/Help_OnlineService.png')}/>
								<Text style={ shareStyle.choiceText }>在线客服</Text>
							</View>
						</TouchableOpacity>
						<TouchableOpacity style={ shareStyle.choiceBtn2 } onPress={() => { click(2); } }>
							<View style={shareStyle.inner}>
								<Image source={require('../images/Help_CustomerService.png')}/>
								<Text style={ shareStyle.choiceText }>客服电话</Text>
							</View>
						</TouchableOpacity>
					</View>
					<TouchableOpacity
						onPress={() => this.hide()}
						style={ shareStyle.cancelBtn }>
						<View style={ shareStyle.cancelBtnInner }>
							<Text style={ shareStyle.cancelText }>取消</Text>
						</View>
					</TouchableOpacity>
				</View>
			</View>
		);
	}
}
const shareStyle = StyleSheet.create({
	Wrap: {
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		position: 'absolute',
		bottom: 0,
		left: 0,
		width: AppSizes.width,
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height,
		flexDirection: 'column'
	},
	contentBlock: {
		backgroundColor: AppColors.whiteBg,
		position: 'absolute',
		left: 0,
		width: AppSizes.width,
		bottom: Platform.OS === 'ios' ? 0 : 0
	},
	choiceWrap: {
		...General.containerVertical,
		borderBottomWidth: AppSizes.pixelRatioWidth,
		borderColor: AppColors.grayBorder,
		flexDirection: 'row'
	},
	choiceBtn2: {
		width: AppSizes.width / 2
	},
	choiceText: {
		color: AppColors.grayColor,
		marginTop: RatiocalHeight(10)
	},
	inner: {
		flexGrow: 1,
		alignItems: 'center'
	},
	cancelBtn: {
		height: RatiocalHeight(100),
		width: AppSizes.width
	},
	cancelBtnInner: {
		flex: 1,
		alignItems: 'center',
		justifyContent: 'center'
	},
	cancelText: {
		color: AppColors.middleBlackColor,
		fontSize: AppFonts.text_size_36
	}
});