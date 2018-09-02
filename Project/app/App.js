'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	StatusBar,
	StyleSheet,
	Platform,
	DeviceEventEmitter,
	NativeModules,
	NetInfo
} from 'react-native'

// utils
import { FunctionUtils, Jump } from './config'
// views
import WelcomePage from './components/WelcomePage'
import TabBar from './components/TabBar'
import UpdateBox from './components/UpdateBox'
// pages
import Home from './pages/Home/Home'
import Auth from './pages/Auth/Auth'
import Loan from './pages/Loan/Loan'
import Center from './pages/Center/Center'
// action
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { GetAuth } from './actions/AuthAction'
import { FetchHome, FetchCenter, FetchConfig } from './actions/BaseAction';
import { GetLoan } from './actions/LoanAction';
// styles
import { AppColors } from './style'
// modules
const SplashManager = NativeModules.SplashScreen
@connect(
	state => ({
		baseInfo: state.baseInfo
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ GetAuth, GetLoan, FetchCenter }, dispatch)
	})
)
export default class App extends Component {
	constructor (props) {
		super(props)
		this.tabIndex = 0;
		this.isCompleteRedux = false;
	}

	componentDidMount () {
		// registerWechat();
		NetInfo.addEventListener('change', this.onNetChange);
		this.tabListener = DeviceEventEmitter.addListener('changTab', (params, updateTab) => {
			if (params || params === 0) {
				if (typeof (params) === 'number') {
					if (this.tabIndex === params) return
					if (params === 0) {
						this.tabIndex = params
						if (updateTab) {
							updateTab(this.tabIndex)
						} else {
							!!this._tabbar && this._tabbar.update(this.tabIndex)
						}
						FetchHome(this.props.dispatch);
					} else if (params === 1) {
						if (FunctionUtils.isLogin(this.props.baseInfo)) {
							this.tabIndex = params
							if (updateTab) {
								updateTab(this.tabIndex)
							} else {
								!!this._tabbar && this._tabbar.update(this.tabIndex)
							}
							this.props.GetAuth()
						} else {
							Jump.go('Login')
						}
					} else if (params === 2) {
						if (FunctionUtils.isLogin(this.props.baseInfo)) {
							this.tabIndex = params
							if (updateTab) {
								updateTab(this.tabIndex)
							} else {
								!!this._tabbar && this._tabbar.update(this.tabIndex)
							}
							DeviceEventEmitter.emit('hidePayBox');
							this.props.GetLoan();
						} else {
							Jump.go('Login')
						}
					} else if (params === 3) {
						if (FunctionUtils.isLogin(this.props.baseInfo)) {
							this.tabIndex = params
							if (updateTab) {
								updateTab(this.tabIndex)
							} else {
								!!this._tabbar && this._tabbar.update(this.tabIndex)
							}
							this.props.FetchCenter()
						} else {
							Jump.go('Login')
						}
					}
				}
			}
		})
		this.showWelListen = DeviceEventEmitter.addListener('showWel', () => {
			!!this.welcomePage && !!this.welcomePage.wrappedInstance && this.welcomePage.wrappedInstance.show()
			this.showWelListen.remove()
			this.showWelListen = null
		})
		this.showUpdateListen = DeviceEventEmitter.addListener('showUpdate', params => {
			!!this.updateBox && !!this.updateBox.wrappedInstance && this.updateBox.wrappedInstance.setData(params.version, params.desc, params.url, params.closeAble, () => {
				!!this.updateBox && !!this.updateBox.wrappedInstance && this.updateBox.wrappedInstance.show()
			});
			this.showUpdateListen.remove()
			this.showUpdateListen = null
		})
		this.mCompleteRedux = DeviceEventEmitter.addListener('isCompleteRedux', () => {
			this.isCompleteRedux = true;
			SplashManager.hide()
			FetchConfig(this.props.dispatch);
			this.mCompleteRedux.remove();
			this.mCompleteRedux = null;
		});
		this.mHomeDidMount = DeviceEventEmitter.addListener('HomeDidMount', () => {
			this.mReduxTimer = setInterval(() => {
				if (this.isCompleteRedux) {
					DeviceEventEmitter.emit('completeRedux');
					this.mReduxTimer && clearInterval(this.mReduxTimer);
					this.mReduxTimer = null
					this.mHomeDidMount.remove();
					this.mHomeDidMount = null;
				}
			}, 500);
		});
		DeviceEventEmitter.emit('AppDidMount');
	}

	componentWillUnmount () {
		this.tabListener && this.tabListener.remove()
		this.tabListener = null;
		NetInfo.removeEventListener('change', this.onNetChange);
	}

	onNetChange = status => {
		if (Platform.OS === 'ios') {
			if (this.isCompleteRedux && (status === 'wifi' || status === 'cell')) {
				FetchConfig(this.props.dispatch);
			}
		} else {
			NetInfo.isConnected.fetch().done(isConnected => {
				if (this.isCompleteRedux && isConnected) {
					FetchConfig(this.props.dispatch);
				}
			});
		}
	}

	render () {
		return (
			<View style={styles.container}>
				<StatusBar barStyle="dark-content"/>
				<TabBar
					ref={ref => { this._tabbar = ref }}
					style={styles.content}
					navTextColor={'#3a3a3a'}
					defaultPage={this.tabIndex}
					isReal={true}
					navTextColorSelected={AppColors.mainColor}>
					<TabBar.Item
						icon={require('./images/Tab_Home.png')}
						selectedIcon={require('./images/Tab_Home_Active.png')}
						onPress={updateTab => DeviceEventEmitter.emit('changTab', 0, updateTab)}
						title={'首页'}>
						<Home {...this.props} welcomePage={this.welcomePage} updateBox={this.updateBox}/>
					</TabBar.Item>
					<TabBar.Item
						icon={require('./images/Tab_Auth.png')}
						selectedIcon={require('./images/Tab_Auth_Active.png')}
						onPress={updateTab => DeviceEventEmitter.emit('changTab', 1, updateTab)}
						title={'信用评估'}>
						<Auth {...this.props} />
					</TabBar.Item>
					{this.props.baseInfo.IsShowLoanTab &&
					<TabBar.Item
						icon={require('./images/Tab_Record.png')}
						selectedIcon={require('./images/Tab_Record_Active.png')}
						onPress={updateTab => DeviceEventEmitter.emit('changTab', 2, updateTab)}
						title={'账单'}>
						<Loan {...this.props} />
					</TabBar.Item>
					}
					<TabBar.Item
						icon={require('./images/Tab_Center.png')}
						selectedIcon={require('./images/Tab_Center_Active.png')}
						onPress={updateTab => DeviceEventEmitter.emit('changTab', 3, updateTab)}
						title={'我的'}>
						<Center {...this.props} />
					</TabBar.Item>
				</TabBar>
				<WelcomePage ref={ref => { this.welcomePage = ref }}/>
				<UpdateBox ref={ref => { this.updateBox = ref }}/>
			</View>
		)
	}
}
const styles = StyleSheet.create({
	container: {
		flex: 1
	},
	content: {
		flex: 1
	}
})