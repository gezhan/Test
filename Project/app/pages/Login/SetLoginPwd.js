'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	DeviceEventEmitter,
	Platform,
	BackHandler
} from 'react-native'
// actions
import { connect } from 'react-redux'
import { LogOut, LoginSuccess, FetchHome } from '../../actions/BaseAction';
import { UpdateAuth } from '../../actions/AuthAction';
// views
import Loading from '../../components/Loading'
import CellInput from '../../components/CellInput'
import NavBarCommon from '../../components/NavBarCommon'
import ButtonHighlight from '../../components/ButtonHighlight'
// styles
import SetLoginPwdStyle from './style/SetLoginPwdStyle'
import { General } from '../../style'
// utils
import {
	Types,
	HttpRequest,
	Url,
	DataAlgorithm,
	toastShort,
	FunctionUtils,
	Jump
} from '../../config'

@connect(
	state => ({
		baseInfo: state.baseInfo
	})
)
export default class SetLoginPwd extends Component {
	constructor (props) {
		super(props)
		this.state = {
			pwd: '',
			submitBtnDisabled: true
		}
	}

	componentWillMount () {
		if (Platform.OS === 'android') {
			DeviceEventEmitter.emit('removeHWBP')
			BackHandler.addEventListener('hardwareBackPress', this.onBackAndroid)
		}
	}

	componentWillUnmount () {
		if (Platform.OS === 'android') {
			BackHandler.removeEventListener('hardwareBackPress', this.onBackAndroid)
			DeviceEventEmitter.emit('addHWBP')
		}
	}

	onBackAndroid = () => {
		this.back()
		return true
	}

	calculate = () => {
		let bool = !!this.state.pwd && this.state.pwd.length >= 6
		this.setState({
			submitBtnDisabled: !bool
		})
	}

	changePwd = text => {
		this.state.pwd = text
		this.calculate()
	}

	submit = enable => {
		if (!FunctionUtils.isNumberOrLetter(this.state.pwd)) {
			toastShort('请输入6-20位登录密码(字母或数字)')
			enable()
			return
		}
		let params = {
			Password: DataAlgorithm.Md5Encrypt(this.state.pwd),
			Account: this.props.BaseParams.account,
			Token: this.props.BaseParams.token,
			Uid: this.props.BaseParams.uid
		}
		this.loading.show()
		HttpRequest.request(Types.POST, Url.SET_PASSWORD, params).then(responseData => {
			this.loading.hide()
			if (responseData.Ret) {
				switch (responseData.Ret) {
					case 200:
						console.log('设置登录密码成功!')
						toastShort('设置登录密码成功!')
						Jump.backToTop(0)
						this.props.dispatch(LoginSuccess(this.props.BaseParams));
						this.props.dispatch(UpdateAuth(this.props.AuthParams));
						FetchHome(this.props.dispatch);
						break
					default:
						enable()
						responseData.Msg && toastShort(responseData.Msg)
						break
				}
			}
		})
			.catch(error => {
				this.loading.hide()
				enable()
				console.log('error', error)
			})
	}

	back = () => {
		this.props.dispatch(LogOut())
		Jump.back()
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'设置登录密码'} leftAction={() => this.back() }/>
				<CellInput
					isFirst isLast
					placeholder={'请输入6~20位数字或字母'}
					maxLength={20}
					cellwrapper={SetLoginPwdStyle.cellwrapper}
					InputStyle={SetLoginPwdStyle.inputStyle}
					value={this.state.pwd}
					textChange={this.changePwd}
					showEyes={true}
					autoFocus={true}
				/>
				<ButtonHighlight
					title={'确定'}
					onPress={this.submit}
					disabled={this.state.submitBtnDisabled}
					buttonStyle={ SetLoginPwdStyle.submitBtn }
				/>
				<Loading ref={ref => { this.loading = ref }} />
			</View>
		)
	}
}
