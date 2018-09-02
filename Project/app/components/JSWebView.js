'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	WebView,
	Platform,
	Clipboard,
	BackHandler,
	DeviceEventEmitter
} from 'react-native';

import { connect } from 'react-redux';
import {
	toastShort,
	Jump,
	FunctionUtils,
	Udesk
} from '../config';
import { FetchHome } from '../actions/BaseAction'

import NavBarCommon from './NavBarCommon';
import AlertConfirm from './AlertConfirm'
import CustomerService from './CustomerService'

import { RatiocalWidth, RatiocalHeight, AppColors, AppSizes, General, AppFonts } from '../style';

@connect(
	state => ({
		baseInfo: state.baseInfo,
		authInfo: state.authInfo
	})
)
export default class JSWebView extends Component {
	constructor (props) {
		super(props);
		let url = props.url;
		if (!!url && FunctionUtils.isLogin(props.baseInfo) && !props.notAdd) {
			url = FunctionUtils.getAddParamsUrl(props.baseInfo, url);
		}
		// this.isRefresh = true// 控制返回是否刷新
		this.from = props.from;// 判断来源，来源于首页则刷新首页，来源于认证则刷新认证
		this.isBackTop = props.isPopTop; // 是否需要跳回一级页面
		this.isFirst = true; // 是否是第一张网页，不是则需要进行WebView的goBack
		this.isAutoBack = !props.isZmSuccess; // 是否不进行Js认证结果页面的自动返回上一个页面
		this.state = {
			title: this.props.title,
			url: url
		};
	}

	componentWillMount () {
		if (Platform.OS === 'android') {
			DeviceEventEmitter.emit('removeHWBP')
			BackHandler.addEventListener('hardwareBackPress', this._onBackAndroid);
		}
	}

	componentDidMount () {
		const { baseInfo, authInfo } = this.props;
		Udesk.Initialize(baseInfo, authInfo);
	}

	componentWillUnmount = () => {
		console.log(this.props.from)
		if (this.props.from === 'home') {
			FetchHome(this.props.dispatch)
		} else if (this.props.from === 'auth') {
			this.props.updateAuth && this.props.updateAuth()
		}
		if (Platform.OS === 'android') {
			BackHandler.removeEventListener('hardwareBackPress', this._onBackAndroid);
			DeviceEventEmitter.emit('addHWBP')
		}
	}

	back = () => {
		if (this.isBackTop) {
			Jump.backToTop()
		} else {
			if (this.isFirst) {
				Jump.back()
			} else {
				this.webviewRef.goBack();
			}
		}
	}

	/*
	 与h5交互	传递值
	 一、帮助中心
	 0 ===> 支付宝转账
	 1 ===> 在线客服，	2 ===> 客服电话
	 */
	onMessage = e => {
		let info = e.nativeEvent.data;
		if (this.props.tag === 'Activity') {
			if (info === '去登录') {
				Jump.go('Login', {
					reload: this.reloadUrl
				});
			} else if (info === 'paysuccess') {
				this.props.toDetail && this.props.toDetail();
			}
		} else if (this.props.tag === 'AliTransfer') {
			if (info.slice(0, info.indexOf(',')) === '1') {
				toastShort('复制账户成功');
			} else if (info.slice(0, info.indexOf(',')) === '2') {
				toastShort('复制备注成功');
			}
			Clipboard.setString(info.slice(info.indexOf(',') + 1));
		}
	}

	reloadUrl = () => {
		this.setState({
			url: FunctionUtils.getAddParamsUrl(this.props.baseInfo, this.props.url)
		})
	};

	// 安卓物理返回键
	_onBackAndroid = () => {
		if (Jump.navigator === null) {
			return false;
		} else if (Jump.navigator.getCurrentRoutes().length === 1) {
			return false;
		} else {
			this.back();
			return true;
		}
	};

	_clickCustomerService = index => {
		this.shareTimer = setTimeout(() => {
			if (index === 1) {
				Udesk.OpenChatView();
			} else if (index === 2) {
				if (this.props.baseInfo.serviceMobile) {
					this.AlertConfirmTel && this.AlertConfirmTel.show();
				} else {
					toastShort('请先使用在线客服')
				}
			}
			this.shareTimer && clearTimeout(this.shareTimer);
			this.shareTimer = null;
		}, 500);
	};

	// 导航栏状态发生变化
	_onNavigationStateChange = navState => {
		const webviewRef = this.webviewRef;

		console.log('webviewRef: ' + webviewRef);
		console.log('url地址：' + navState.url);
		console.log('url标题：' + navState.title);
		console.log('url加载状态：' + navState.loading);
		console.log('url可以后退：' + navState.canGoBack);
		console.log('url可以前进：' + navState.canGoForward);
		// 更新标题
		!this.props.title && navState.title && navState.title.indexOf('uid') <= -1 && navState.title.indexOf('source=OK') <= -1 && this.setState({ title: navState.title })

		this.isFirst = !(String(navState.url).indexOf('hsstatic.5ujr.cn/H5/html/alipay.html') >= 0 && navState.canGoBack);
		console.log('是否是第一张网页：' + this.isFirst);
	};

	render () {
		const { baseInfo } = this.props;
		return (
			<View style={{ flexGrow: 1, backgroundColor: '#ffffff' }}>
				<NavBarCommon
					title={this.state.title}
					leftAction={() => this.back()}
					rightTitle={this.props.showCuser ? '在线客服' : ''}
					rightAction={() => this.cuserRef && this.cuserRef.show()}/>
				<WebView
					ref={ref => { this.webviewRef = ref }}
					style={{ backgroundColor: '#ffffff' }}
					source={{ uri: this.state.url }}
					startInLoadingState={true}
					domStorageEnabled={true}
					javaScriptEnabled={true}
					onMessage={this.onMessage}
					automaticallyAdjustContentInsets={true}
					onNavigationStateChange={this._onNavigationStateChange}
					bounces={false}
					scalesPageToFit={true}
					scrollEnabled={true}
				/>
				<CustomerService
					ref={ref => { this.cuserRef = ref }}
					click={this._clickCustomerService}/>
				<AlertConfirm
					ref={ ref => { this.AlertConfirmTel = ref }}
					isShowTranBg={false}
					msg={'拨打' + baseInfo.serviceMobile}
					leftClick={() => this.AlertConfirmTel.hide()}
					rightBtnTextStyle={{ color: AppColors.lightBlackColor }}
					rightClick={() => {
						this.cuserRef.hide();
						this.AlertConfirmTel.hide();
						FunctionUtils.callPhone(baseInfo.serviceMobile);
					}}/>
			</View>
		);
	}
}