'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Platform,
	Dimensions,
	Image,
	TouchableOpacity,
	Modal,
	StyleSheet,
	StatusBar,
	DeviceEventEmitter
} from 'react-native';
import { connect } from 'react-redux';

import { RatiocalHeight, RatiocalFontSize, AppColors, AppSizes } from '../style';
import Swiper from 'react-native-swiper';
import DeviceInfo from '../utils/DeviceInfo'
const {
	width,
	height
} = Dimensions.get('window');
const imageSource = AppSizes.height === 812 ? [
	require('../images/Guide_Page1_X.png'),
	require('../images/Guide_Page2_X.png'),
	require('../images/Guide_Page3_X.png'),
	require('../images/Guide_Page4_X.png')
] : [
	require('../images/Guide_Page1.png'),
	require('../images/Guide_Page2.png'),
	require('../images/Guide_Page3.png'),
	require('../images/Guide_Page4.png')
];

@connect(
	null,
	null,
	null,
	{
		pure: true,
		withRef: true
	}
)
export default class WelcomePage extends Component {
	constructor (props) {
		super(props);
		this.state = {
			isShowCircleDot: true,
			visible: false
		};
		this._renderImg = this._renderImg.bind(this);
	}

	show = () => {
		this.setState({ visible: true });
	};

	hide = () => {
		this.setState({ visible: false });
	};

	click = () => {
		this.hide();
		DeviceEventEmitter.emit('closeWel');
	};

	_renderImg () {
		let imageSource = AppSizes.height === 812 ? [
			require('../images/Guide_Page1_X.png'),
			require('../images/Guide_Page2_X.png'),
			require('../images/Guide_Page3_X.png'),
			require('../images/Guide_Page4_X.png')
		] : [
			require('../images/Guide_Page1.png'),
			require('../images/Guide_Page2.png'),
			require('../images/Guide_Page3.png'),
			require('../images/Guide_Page4.png')
		];
		let imageViews = [];
		for (let i = 0; i < imageSource.length; i++) {
			if (i === (imageSource.length - 1)) {
				imageViews.push(
					<Image
						key={i}
						style={styles.swiperImage}
						source={imageSource[i]}>
						<TouchableOpacity style={styles.btnEsperience} onPress={() => { this.click(); }}>
							<Text style={styles.btnText}>
								马上体验
							</Text>
						</TouchableOpacity>
					</Image>
				);
			} else {
				imageViews.push(
					<Image
						key={i}
						style={styles.swiperImage}
						source={imageSource[i]}
					/>
				);
			}
		}
		return imageViews;
	}

	_renderImage (val, i) {
		return (
			<View key={i} style={{ flex: 1, flexDirection: 'column' }}>
				<Image
					style={styles.swiperImage}
					source={imageSource[i]}>
					{
						i === (imageSource.length - 1) && <TouchableOpacity
							style={styles.btnEsperience}
							onPress={() => { this.click(); }}>
							<Text style={styles.btnText}>
								立即体验
							</Text>
						</TouchableOpacity>
					}
				</Image>
			</View>
		);
	}

	_onMomentumScrollEnd (e, state, context) {
		if (state.index === 3) {
			this.setState({
				isShowCircleDot: false
			});
		} else {
			this.setState({
				isShowCircleDot: true
			});
		}
	}

	render () {
		const { style } = this.props;
		return (
			Platform.OS === 'ios' ? <Modal
				animationType={'fade'}
				visible={this.state.visible}
				transparent
				onRequestClose={state => {
				}}>
				<View style={styles.backgroudView}>
					<Swiper
						loop={false}
						autoplay={false}
						showsButtons={false}
						showsPagination={false}
						width={width}
						height={height}
						index={0}
						onMomentumScrollEnd={(e, state, context) => this._onMomentumScrollEnd(e, state, context)}>
						{
							imageSource.map((val, i) => this._renderImage(val, i))
						}
					</Swiper>
				</View>
			</Modal>
				: this.state.visible &&
				<View style={[styles.backgroudView, style]}>
					<Swiper
						loop={false}
						autoplay={false}
						showsButtons={false}
						showsPagination={false}
						width={width}
						height={height}
						index={0}
						onMomentumScrollEnd={(e, state, context) => this._onMomentumScrollEnd(e, state, context)}>
						{
							imageSource.map((val, i) => this._renderImage(val, i))
						}
					</Swiper>
				</View>
		);
	}
}
const styles = StyleSheet.create({
	backgroudView: {
		flexGrow: 1,
		backgroundColor: '#ffffff',
		overflow: 'hidden',
		position: 'absolute',
		left: 0,
		bottom: 0,
		width: AppSizes.width,
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height,
	},
	swiperImage: {
		width: width,
		height: height,
		/**
		 *  contain 根据图片本身的宽高比
		 *    cover,
		 *    stretch
		 */
		resizeMode: Image.resizeMode.stretch,
		justifyContent: 'flex-end'
	},
	btnEsperience: {
		marginBottom: RatiocalHeight(140),
		width: width / 2,
		height: RatiocalHeight(100),
		backgroundColor: AppColors.mainColor,
		borderRadius: RatiocalHeight(100) / 2,
		// borderWidth: 1,
		alignSelf: 'center',
		alignItems: 'center',
		justifyContent: 'center'
	},
	btnText: {
		fontSize: RatiocalFontSize(36),
		textAlign: 'center',
		color: AppColors.whiteColor
	}
});