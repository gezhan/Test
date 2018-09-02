'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	ListView,
	Image,
	TouchableOpacity,
	TouchableWithoutFeedback,
	TextInput,
	StyleSheet,
	Platform,
	NativeModules
} from 'react-native';
import { connect } from 'react-redux';
// import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, General, CellStyle} from '../style/Style';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, General, AppFonts, AppSizes } from '../style';
import CameraRollPicker from './Camerarollpicker';
import { toastShort } from '../utils/ToastUtil';
import NavBar from './NavBarCommon';
import Jump from '../utils/Jump';
import ButtonHighlight from './ButtonHighlight';
import { AlertView } from './AlertView';
const ImageShow = Platform.OS === 'ios' ? NativeModules.ImageShow : NativeModules.MyImageModule;
let _maximun;
class CameraSelect extends Component {
	constructor (props) {
		super(props);
		this.state = {
			confirmTelAlert: false,
			num: 0,
			selected: [],
			imgData: [],
			ylStatus: false
		};
		_maximun = 3
	}

	_imgSelect = imgdata => {
		console.log(imgdata);
		if (imgdata.length > 0) {
			this.setState({
				ylStatus: true
			})
			let data = [];
			imgdata.map((item, i) => {
				let uri = imgdata[i].uri
				data.push(uri)
			})
			this.state.imgData = data;
			console.log('this.state.imgData' + this.state.imgData, 'data' + data)
		} else {
			this.setState({
				ylStatus: false
			})
		}
	}

	_sumbitAction = () => {
		const { callBack } = this.props
		if (this.state.ylStatus === true) {
			this.props.callBack(this.state.imgData);
			Jump.back()
		} else {
			toastShort('请先选择图片')
		}
	};

	_exitRight = () => {
		Jump.back()
	};

	_preview = () => {
		if (Platform.OS === 'ios') {
			// enable()
			ImageShow.ShowImage(this.state.imgData, '0');
		} else {
			// enable()
			if (this.state.imgData.length > 0) {
				ImageShow.startImageGalleryActivity(0, JSON.stringify(this.state.imgData));
			} else {
				toastShort('请先选择图片进行预览')
			}
		}
	}
	_preview1 = () => {
		toastShort('请先选择图片')
	}

	render () {
		const groupType = Platform.OS === 'ios' ? 'SavedPhotos' : 'SavedPhotos';
		let ylStyle = this.state.ylStatus ? styles.yltextunStyle : styles.yltextStyle;
		let NavBarHeight = Platform.OS === 'android' ? 44 : AppSizes.height === 812 ? 88 : 64;
		return (
			<View style={General.wrapViewGray}>
				<NavBar
					backgroundColor={['white', 'white']}
					title={'所有照片'}
					titleColor={{ color: AppColors.blackColor }}
					titleSize={{ fontSize: AppFonts.text_size_32 }}
					rightTitleColor={{ color: AppColors.subColor }}
					rightTitleStyle={{ fontSize: AppFonts.text_size_28 }}
					rightTitle={'取消'}
					rightAction={this._exitRight}
				/>
				{AppSizes.height === 812
					? <View style={{ height: AppSizes.height - NavBarHeight - RatiocalHeight(120) }}>
						<CameraRollPicker
							backgroundColor={'#EDEDED'}
							scrollRenderAheadDistance={500}
							groupTypes={groupType}
							batchSize={5}
							maximum={this.props.maxSelect}
							selected={this.state.selected}
							assetType="Photos"
							imagesPerRow={3}
							imageMargin={4}
							selectedMarker={require('../images/delete_bingo.png')}
							defaultMarker={require('../images/publish_uncheck.png')}
							callback={this._imgSelect}
						/>
					</View>
					: <CameraRollPicker
						backgroundColor={'#EDEDED'}
						scrollRenderAheadDistance={500}
						groupTypes={groupType}
						batchSize={5}
						maximum={this.props.maxSelect}
						selected={this.state.selected}
						assetType="Photos"
						imagesPerRow={3}
						imageMargin={4}
						selectedMarker={require('../images/delete_bingo.png')}
						defaultMarker={require('../images/publish_uncheck.png')}
						callback={this._imgSelect}
					/>
				}
				<View style={{
					height: AppSizes.height === 812 ? RatiocalHeight(120) : RatiocalHeight(88),
					backgroundColor: AppColors.whiteColor
				}}>
					<TouchableOpacity
						style={{
							height: AppSizes.height === 812 ? RatiocalHeight(120) : RatiocalHeight(88),
							flexDirection: 'row',
							justifyContent: 'space-between',
							alignItems: 'center',
							paddingHorizontal: RatiocalWidth(50)
						}}
						disabled={true}
					>
						<TouchableOpacity onPress={this.state.ylStatus === true ? this._preview : this._preview1}>
							<Text
								style={[this.state.ylStatus === true ? { color: AppColors.subColor } : { color: 'gray' }, { fontSize: AppFonts.text_size_28 }]}>预览</Text>
						</TouchableOpacity>
						<TouchableOpacity onPress={this._sumbitAction}>
							<Text
								style={[this.state.ylStatus === true ? { color: AppColors.subColor } : { color: 'gray' }, { fontSize: AppFonts.text_size_28 }]}>
								{this.state.ylStatus === true ? '(' + this.state.imgData.length + ')' + ' 确定' : '确定'}
							</Text>
						</TouchableOpacity>
					</TouchableOpacity>
				</View>
				<AlertView
					visible={this.state.confirmTelAlert}
					title={'您最多只能选择四张照片'}
					rightTitle={'确定'}
					rightAction={this._dialing}/>
			</View>
		)
	}

	_dialing = () => {
		this.setState({ confirmTelAlert: false })
	};
}
export const styles = StyleSheet.create({
	yltextStyle: {
		color: AppColors.subColor
	},
	yltextunStyle: {
		color: AppColors.grayColor
	}
})

function mapStateToProps (state) {
	const {
		userInfo
	} = state;
	return {
		userInfo
	}
}
export default connect(mapStateToProps)(CameraSelect);