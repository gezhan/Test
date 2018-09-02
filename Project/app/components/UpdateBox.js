'use strict';
import React, { Component } from 'react';
import {
	StyleSheet,
	View,
	Text,
	Modal,
	Image,
	Platform,
	ScrollView,
	TouchableOpacity,
	StatusBar,
	NativeModules
} from 'react-native';
import { connect } from 'react-redux';
import { FunctionUtils, DeviceInfo } from '../config'
import { AppSizes, RatiocalHeight, RatiocalWidth, RatiocalFontSize } from '../style';
const DownloadModules = NativeModules.DownloadDilaogs;

@connect(
	null,
	null,
	null,
	{
		pure: true,
		withRef: true
	}
)
export default class UpdateBox extends Component {
	constructor (props) {
		super(props);
		this.state = {
			isVisible: false,
			version: '',
			desc: '',
			closeAble: true,
			url: ''
		};
	}

	renderLine = (descArr, index) => {
		return (
			<Text key={index} style={styles.infoText}>{descArr}</Text>
		);
	};

	hide = () => {
		this.setState({
			isVisible: false
		})
	}

	show = () => {
		this.setState({
			isVisible: true
		})
	}

	setData = (version, updateDesc, updateUrl, closeAble, callBack) => {
		this.setState({
			version: version,
			desc: updateDesc,
			url: updateUrl,
			closeAble: closeAble
		}, () => {
			callBack();
		})
	}

	update = () => {
		if (Platform.OS === 'ios') {
			!!this.state.url && FunctionUtils.goUpdate(this.state.url);
		} else {
			//  是否强制更新
			DownloadModules.showDialog(!this.state.closeAble, this.state.url, DeviceInfo.getVersion(), (status, errmsg) => {
				console.log('status=' + status + ',errmsg=' + errmsg);
				//  如果强制更新,重新显示版本更新的弹框
				if (status === 2) {
					this.setState({ isVisible: true });
				}
			});
			this.setState({ isVisible: !this.state.closeAble });
		}
	}

	render () {
		const { style } = this.props;
		let descArr = this.state.desc ? this.state.desc.split('#') : [];
		return (
			Platform.OS === 'ios' && this.state.isVisible ? (
				<Modal
					animationType={'fade'}
					visible={this.state.isVisible}
					transparent
					onRequestClose={() => this.hide() }>
					<View style={styles.Model}>
						<View>
							<Image style={styles.wrapper} source={require('../images/UpdateImg.png')}>
								<Text style={styles.versionStyle}>—— {this.state.version} ——</Text>
								<ScrollView style={styles.ScrollViewStyle}>
									{descArr.map((item, index) => this.renderLine(item, index))}
								</ScrollView>
								<TouchableOpacity onPress={() => this.update()} style={styles.updateBtn}>
									<Text style={styles.updateBtnText}>立即升级</Text>
								</TouchableOpacity>
							</Image>
							{this.state.closeAble &&
							<TouchableOpacity style={styles.close} onPress={() => this.hide() }>
								<Image
									source={require('../images/Update_Close.png')} resizeMode={'contain'}
									style={styles.closeImg}/>
							</TouchableOpacity>
							}
						</View>
					</View>
				</Modal>
			) : this.state.isVisible &&
				<View style={[styles.Model, style]}>
					<View>
						<Image style={styles.wrapper} source={require('../images/UpdateImg.png')}>
							<Text style={styles.versionStyle}>—— {this.state.version} ——</Text>
							<ScrollView style={styles.ScrollViewStyle}>
								{descArr.map((item, index) => this.renderLine(item, index))}
							</ScrollView>
							<TouchableOpacity onPress={() => this.update()} style={styles.updateBtn}>
								<Text style={styles.updateBtnText}>立即升级</Text>
							</TouchableOpacity>
						</Image>
						{this.state.closeAble &&
						<TouchableOpacity style={styles.close} onPress={() => this.hide() }>
							<Image
								source={require('../images/Update_Close.png')}
								style={styles.closeImg}/>
						</TouchableOpacity>
						}
					</View>
				</View>
		);
	}
}

const styles = StyleSheet.create({
	Model: {
		position: 'absolute',
		width: AppSizes.width,
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height,
		bottom: 0,
		left: 0,
		justifyContent: 'center',
		alignItems: 'center',
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		overflow: 'hidden'
	},
	wrapper: {
		width: RatiocalWidth(530),
		height: RatiocalHeight(630),
		justifyContent: 'center',
		alignItems: 'center'
	},
	close: {
		position: 'absolute',
		right: RatiocalWidth(-25),
		top: RatiocalWidth(10),
		width: RatiocalWidth(50),
		height: RatiocalWidth(50)
	},
	closeImg: {
		width: RatiocalWidth(50),
		height: RatiocalWidth(50),
		resizeMode: 'contain'
	},
	ScrollViewStyle: {
		position: 'absolute',
		bottom: RatiocalHeight(130),
		width: RatiocalWidth(470),
		height: RatiocalHeight(150),
		marginHorizontal: RatiocalWidth(30)
	},
	updateBtn: {
		position: 'absolute',
		bottom: RatiocalHeight(30),
		left: RatiocalWidth(140),
		height: RatiocalHeight(80),
		width: RatiocalWidth(250),
		borderRadius: RatiocalWidth(80),
		padding: RatiocalHeight(20),
		borderColor: '#ffffff',
		backgroundColor: '#0386ff'
	},
	updateBtnText: {
		color: '#ffffff',
		textAlign: 'center',
		fontSize: RatiocalFontSize(32)
	},
	inner: {
		position: 'absolute',
		bottom: 0,
		width: RatiocalWidth(530),
		height: RatiocalHeight(330),
		paddingHorizontal: RatiocalWidth(30)
	},
	versionStyle: {
		color: '#333333',
		textAlign: 'center',
		textAlignVertical: 'center'
	},
	infoText: {
		color: '#333333',
		fontSize: RatiocalFontSize(26)
	}
});