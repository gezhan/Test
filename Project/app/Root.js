'use strict'
import React, { Component } from 'react'
import {
	Platform,
	BackHandler,
	DeviceEventEmitter
} from 'react-native'
import { Provider } from 'react-redux'
import configureStore from './store/index'
import { toastShort } from './utils/ToastUtil'
import CodePush from 'react-native-code-push';
import { Jump, FunctionUtils } from './config'
import { Navigator } from 'react-native-deprecated-custom-components'
import App from './App'
// 首页
import Home from './pages/Home/Home'
import ReportResult from './pages/Home/ReportResult'
import ReportDetail from './pages/Home/ReportDetail'
import LoanSuccess from './pages/Home/LoanSuccess';
import LoanApplication from './pages/Home/LoanApplication';
import SelectBank from './pages/Home/SelectBank'
// 信用
import Auth from './pages/Auth/Auth'
import SmSuccess from './pages/Auth/SmSuccess'
import PersonalInfo from './pages/Auth/PersonalInfo'
import EmergencyContact from './pages/Auth/EmergencyContact'
import BindBankCard from './pages/Auth/BindBankCard'
import ZmAuth from './pages/Auth/ZmAuth'
import MyBankCard from './pages/Auth/MyBankCard'
import BankList from './pages/Auth/BankList'
// 账单
import Loan from './pages/Loan/Loan'
import LoanHistory from './pages/Loan/LoanHistory'
import LoanDetail from './pages/Loan/LoanDetail'
// 我的
import Center from './pages/Center/Center'
import Feedback from './pages/Center/Feedback'
import EditPwd from './pages/Center/EditPwd'
import ModifyLoginPwd from './pages/Center/ModifyLoginPwd'
import ForgetPwd1 from './pages/Center/ForgetPwd1'
import ForgetPwd2 from './pages/Center/ForgetPwd2'
import SetTradePwd1 from './pages/Center/SetTradePwd1'
import SetTradePwd2 from './pages/Center/SetTradePwd2'
import MessageCenter from './pages/Center/MessageCenter'
import MyCreditReport from './pages/Center/MyCreditReport'

import JSWebView from './components/JSWebView'
// 登录&注册
import Login from './pages/Login/Login';
import Register from './pages/Login/Register';
import SetLoginPwd from './pages/Login/SetLoginPwd'
// 还款
import PaymentVerification from './pages/Loan/PaymentVerification'

export default class Root extends Component {
	constructor (props) {
		super(props)
		this.isAppComplete = false
		this.mHomeDidMount = DeviceEventEmitter.addListener('AppDidMount', () => {
			this.isAppComplete = true
			this.mHomeDidMount.remove()
			this.mHomeDidMount = null
		})
		this.mStore = configureStore(this.isComplete)
		this.mRoute = null
		this.mNavigator = null
	}

	isComplete = (err, restoredState) => {
		console.log(err, restoredState)
		if (err !== null) {
			this.mStore = configureStore(this.isComplete)
		} else {
			this.initTimer && clearInterval(this.initTimer)
			this.initTimer = null
			this.initTimer = setInterval(() => {
				if (this.isAppComplete) {
					FunctionUtils.setStore(this.mStore);
					DeviceEventEmitter.emit('isCompleteRedux')
					this.initTimer && clearInterval(this.initTimer)
					this.initTimer = null
				}
			}, 500)
		}
	}

	_configureScene = route => {
		let configure = Navigator.SceneConfigs.FloatFromRight
		let gestures = configure.gestures
		switch (route.name) {
			case 'App':
				configure = Navigator.SceneConfigs.FadeAndroid
				gestures = { pop: null };
				break
			case 'Login':
				configure = Navigator.SceneConfigs.FloatFromBottom
				gestures = configure.gestures;
				break
			case 'JSWebView':
				configure = Navigator.SceneConfigs.PushFromRight
				gestures = { pop: null };
				break
			case 'ReportDetail':
				configure = Navigator.SceneConfigs.PushFromRight
				gestures = { pop: null };
				break
			case 'LoanSuccess':
				configure = Navigator.SceneConfigs.PushFromRight
				gestures = { pop: null };
				break
			case 'PaymentVerification':
				configure = Navigator.SceneConfigs.PushFromRight
				gestures = { pop: null };
				break
			default:
				configure = Navigator.SceneConfigs.FloatFromRight
				gestures = configure.gestures;
				break
		}
		return {
			...configure,
			gestures: gestures
		}
	}

	_renderScene = (route, navigator) => {
		let Component = null
		this.mNavigator = navigator
		this.mRoute = route
		switch (route.name) {
			case 'App': 				// 根目录
				Component = App
				break
			case 'Home':// 首页
				Component = Home
				break
			case 'Auth':// 信用
				Component = Auth
				break
			case 'SmSuccess':// 信用
				Component = SmSuccess
				break
			case 'PersonalInfo':// 个人信息
				Component = PersonalInfo
				break
			case 'EmergencyContact':// 常用联系人
				Component = EmergencyContact
				break
			case 'BindBankCard':// 绑卡
				Component = BindBankCard
				break
			case 'MyBankCard':// 我的银行卡
				Component = MyBankCard
				break
			case 'BankList':// 所属银行列表
				Component = BankList
				break
			case 'ZmAuth':// 芝麻认证
				Component = ZmAuth
				break;
			case 'Loan':// 账单
				Component = Loan
				break
			case 'Center':// 个人中心
				Component = Center
				break
			case 'Feedback':// 意见反馈
				Component = Feedback
				break
			case 'JSWebView':// H5
				Component = JSWebView
				break
			case 'Login': // 登录
				Component = Login
				break
			case 'Register': // 登录
				Component = Register
				break
			case 'SetLoginPwd': // 设置登录密码
				Component = SetLoginPwd
				break
			case 'LoanHistory': // 历史账单
				Component = LoanHistory
				break
			case 'LoanDetail': // 账单详情
				Component = LoanDetail
				break
			case 'EditPwd': // 修改密码
				Component = EditPwd
				break
			case 'ModifyLoginPwd': // 修改密码
				Component = ModifyLoginPwd
				break
			case 'MessageCenter': // 消息中心
				Component = MessageCenter
				break
			case 'ForgetPwd1': // 忘记密码1
				Component = ForgetPwd1
				break
			case 'ForgetPwd2': // 忘记密码2
				Component = ForgetPwd2
				break
			case 'SetTradePwd1': // 设置交易密码1
				Component = SetTradePwd1
				break
			case 'SetTradePwd2': // 设置交易密码1
				Component = SetTradePwd2
				break
			case 'PaymentVerification':
				Component = PaymentVerification;
				break;
			case 'MyCreditReport': // 我的信用报告
				Component = MyCreditReport;
				break;
			case 'ReportDetail': // 信用报告详情
				Component = ReportDetail;
				break;
			case 'ReportResult': // 信用报告
				Component = ReportResult;
				break;
			case 'LoanApplication': // 申请订单
				Component = LoanApplication;
				break;
			case 'LoanSuccess': // 申请订单
				Component = LoanSuccess;
				break;
			case 'SelectBank': // 选择收款银行
				Component = SelectBank;
				break;
			default: // default view
				break
		}
		Jump.setNavigator(navigator)
		return <Component {...route.params} navigator={navigator}/>
	}

	componentWillMount () {
		if (Platform.OS === 'android') {
			BackHandler.addEventListener('hardwareBackPress', this._onBackAndroid)
			this.removeHWBP = DeviceEventEmitter.addListener('removeHWBP', () => {
				BackHandler.removeEventListener('hardwareBackPress', this._onBackAndroid)
			})
			this.addHWBP = DeviceEventEmitter.addListener('addHWBP', () => {
				BackHandler.addEventListener('hardwareBackPress', this._onBackAndroid)
			})
		}
		CodePush.disallowRestart();// 页面加载的禁止重启，在加载完了可以允许重启
	}

	componentDidMount () {
		CodePush.allowRestart();// 在加载完了可以允许重启
		CodePush.sync({
			mandatoryInstallMode: CodePush.InstallMode.IMMEDIATE
		});
	}

	componentWillUnmount () {
		if (Platform.OS === 'android') {
			BackHandler.removeEventListener('hardwareBackPress', this._onBackAndroid)
			!!this.removeHWBP && this.removeHWBP.remove()
			!!this.addHWBP && this.addHWBP.remove()
			this.removeHWBP = null
			this.addHWBP = null
		}
	}

	_onBackAndroid = () => {
		if (this.mRoute.name === 'App') {
			if (this.lastBackPressed && this.lastBackPressed + 2000 >= Date.now()) {
				// 最近2秒内按过back键，可以退出应用。
				return false
			}
			this.lastBackPressed = Date.now()
			toastShort('再按一次退出应用')
			return true
		} else {
			if (this.mNavigator === null) {
				return false
			}
			if (this.mNavigator.getCurrentRoutes().length === 1) {
				return false
			}
			this.mNavigator.pop()
			return true
		}
	}

	render () {
		return (
			<Provider store={this.mStore}>
				<Navigator
					initialRoute={{ name: 'App' }}
					configureScene={this._configureScene}
					renderScene={this._renderScene}/>
			</Provider>
		)
	}
}