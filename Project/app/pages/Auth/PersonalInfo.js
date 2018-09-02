'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Image,
	Platform,
	NativeModules
} from 'react-native'
// styles
import { AppColors, General } from '../../style'
import PersonalInfoStyles from './style/PersonalInfoStyles'
// utils
import Jump from '../../utils/Jump'
import { toastShort } from '../../utils/ToastUtil'
import { HttpRequest, Types, Url } from '../../config'
import FunctionUtils from '../../utils/FunctionUtils'
// components
import { KeyboardAwareScrollView } from '../../components/KeyboardAwareScrollView'
import ButtonHighlight from '../../components/ButtonHighlight'
import GeneralSelector from '../../components/GeneralSelector'
import NavBarCommon from '../../components/NavBarCommon'
import AlertConfirm from '../../components/AlertConfirm'
import CellInput from '../../components/CellInput'
import SmAuthen from '../../components/SmAuthen'
import Loading from '../../components/Loading'
import Cell from '../../components/Cell'
// action
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { GetAuth } from '../../actions/AuthAction'

const MAPView = Platform.OS === 'ios' ? NativeModules.GaodeModules : NativeModules.AMap2D

@connect(
	state => ({
		baseInfo: state.baseInfo,
		authInfo: state.authInfo,
		BaseInfo: state.authInfo.BaseInfo
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ GetAuth }, dispatch)
	})
)
export default class PersonalInfo extends Component {
	constructor (props) {
		super(props)
		const { BaseInfo } = this.props
		this.state = {
			// 我的身份选择弹框提示
			myIdentityAlertShow: false,
			// 定位权限弹框提示
			locationAlertShow: false,
			// 定位定位权限弹框提示文字
			locationAlertText: '',
			myIdentity: BaseInfo.UserType, // 我的身份
			Education: BaseInfo.Education,
			LiveTime: BaseInfo.LiveTime,
			Marriage: BaseInfo.Marriage,
			Email: BaseInfo.Email,
			LiveAddress: BaseInfo.LiveAddress,
			LiveDetailAddress: BaseInfo.LiveDetailAddress,
			seletData: [],
			selectRow: 0,
			// 登录按钮是否可点击
			submitBtnDisabled: true,
			// 页面信息手否有修改
			isChange: false, // 默认没有
			Province: '', // 省
			City: '', // 市
			District: '', // 区
			Lat: '', // 纬度
			Lng: '', // 经度
			emailInputStyle: PersonalInfoStyles.cellInputStyle,
			addressInputStyle: PersonalInfoStyles.cellInputStyle
		}
	}

	// 实名
	goToAuth = () => {
		if (this.props.authInfo.Sm.IsRZ === 1) {
			Jump.go('SmSuccess')
			return
		}
		if (this.props.authInfo.Sm.FailTime >= 2) {
			toastShort('实名次数已达上限')
			return
		}
		SmAuthen.Request(this, callback => {
			console.log(callback)
			if (callback) {
				if (callback.ErrCode) {
					if (callback.ErrCode !== '999' && callback.ErrCode !== '310') {
						// 999: 取消操作； 310: 次数用完
						this.props.GetAuth(this)
						this.state.isChange = true
						this.calculate()
						this.forceUpdate()
					}
				}
			}
			!!callback && !!callback.Msg && toastShort(callback.Msg)
		})
	}

	select = type => {
		if (type === 'edu') {
			!!this.selectorRef && this.selectorRef.show()
			this.setState({
				seletData: ['初中及以下', '高中', '中专', '大专', '本科', '硕士', '博士及以上'],
				selectRow: 1
			})
		} else if (type === 'Marriage') {
			!!this.selectorRef && this.selectorRef.show()
			this.setState({
				seletData: ['未婚', '已婚未育', '已婚已育', '离异', '其他'],
				selectRow: 2
			})
		} else if (type === 'time') {
			!!this.selectorRef && this.selectorRef.show()
			this.setState({
				seletData: ['半年以内', '半年到一年', '一年以上'],
				selectRow: 3
			})
		}
	}

	// 选择关系
	clickSelector = (rowData, sectionID, rowID) => {
		this.state.isChange = true
		!!this.selectorRef && this.selectorRef.hidden()
		if (this.state.selectRow === 1) {
			this.state.Education = rowData
		} else if (this.state.selectRow === 2) {
			this.state.Marriage = rowData
		} else if (this.state.selectRow === 3) {
			this.state.LiveTime = rowData
		}
		this.calculate()
		this.forceUpdate()
	}

	// 获取地址
	chooseAddress = () => {
		this.loading.show()
		MAPView.RNGaoDe(callBack => {
			this.loading.hide()
			console.log(callBack)
			// 1 代表成功  0 代表手动触发返回
			if (callBack.ret === 1) {
				this.state.isChange = true
				this.state.LiveAddress = callBack.name
				this.state.Province = callBack.province
				this.state.City = callBack.city
				this.state.District = callBack.district
				this.state.Lat = callBack.latitudeLocation
				this.state.Lng = callBack.longitudeLocation
				this.calculate()
				this.forceUpdate()
			} else {
				console.log('用户取消了定位操作，手动触发返回')
			}
		})
	}

	changeInput = (text, type) => {
		if (type === 'email') {
			this.state.Email = text
		} else if (type === 'address') {
			this.state.LiveDetailAddress = text
		}
		this.state.isChange = true
		this.calculate()
		this.forceUpdate()
	}

	calculate = () => {
		const { authInfo } = this.props
		let bool =
			this.state.isChange &&
			authInfo.Sm.IsRZ === 1 &&
			!!this.state.myIdentity &&
			!!this.state.Education &&
			!!this.state.Email &&
			!!this.state.LiveAddress &&
			!!this.state.LiveDetailAddress
		if (bool) {
			this.state.submitBtnDisabled = false
		} else {
			this.state.submitBtnDisabled = true
		}
	}

	submit = enable => {
		if (this.state.Email && !FunctionUtils.isEmail(this.state.Email)) {
			toastShort('邮箱格式不正确')
			enable()
			return
		}
		let params = {
			UserType: this.state.myIdentity,
			Education: this.state.Education,
			Lng: this.state.Lng,
			Lat: this.state.Lat,
			Province: this.state.Province,
			City: this.state.City,
			District: this.state.District,
			LiveAddress: this.state.LiveAddress,
			LiveDetailAddress: this.state.LiveDetailAddress,
			LiveTime: this.state.LiveTime,
			Marriage: this.state.Marriage,
			Email: this.state.Email
		}
		this.loading.show()
		HttpRequest.request(Types.POST, Url.BASEINFO, params)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.props.GetAuth(this)
							Jump.back()
							break
						case 408:
							enable()
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							enable()
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

	ConfirmWarnRight = () => {
		this.ConfirmWarn.hide()
		if (this.state.myIdentity !== '上班族') {
			this.state.isChange = true
			this.state.myIdentity = '上班族'
			this.calculate()
			this.forceUpdate()
		}
	}

	ConfirmExitRight = () => {
		this.ConfirmExit.hide()
		Jump.back()
	}

	back = () => {
		if (this.state.isChange) {
			this.ConfirmExit.show()
		} else {
			Jump.back()
		}
	}

	render () {
		const { authInfo } = this.props
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'个人信息'} leftAction={() => this.back()}/>
				<KeyboardAwareScrollView>
					<View style={PersonalInfoStyles.topView}>
						<Image style={PersonalInfoStyles.TitleImg} source={require('../../images/Home_Prompt.png')}/>
						<Text style={PersonalInfoStyles.topText}>实名认证信息保存后将无法修改，请务必保证正确</Text>
					</View>
					<Cell
						isFirst isLast
						title={'实名认证'}
						leftIcon2={authInfo.Sm.IsRZ === 1 ? require('../../images/Person_Ok.png') : null}
						value={authInfo.Sm.IsRZ === 0 ? '未认证' : '已认证'}
						clickCell={this.goToAuth}/>
					<Cell
						isLast
						title={'我的身份'}
						value={this.state.myIdentity === '' ? '请选择' : this.state.myIdentity}
						clickCell={() => this.ConfirmWarn.show()}/>
					<View style={PersonalInfoStyles.borderView}/>
					<Cell
						isFirst isLast
						title={'学历'}
						value={this.state.Education === '' ? '选择教育程度' : this.state.Education}
						clickCell={() => this.select('edu')}/>
					<Cell
						isLast
						title={'婚姻状况'}
						value={this.state.Marriage === '' ? '填写可提高通过率(选填)' : this.state.Marriage}
						clickCell={() => this.select('Marriage')}/>
					<CellInput
						isLast
						leftTitle={'邮箱'}
						placeholder={'示例: 1234567@qq.com'}
						maxLength={20}
						InputStyle={this.state.emailInputStyle}
						onFocus={() => {
							this.setState({
								emailInputStyle: PersonalInfoStyles.cellInputFocusStyle
							})
						}}
						onBlur={() => {
							this.setState({
								emailInputStyle: PersonalInfoStyles.cellInputStyle
							})
						}}
						value={this.state.Email}
						textChange={text => this.changeInput(text, 'email')}
						keyboardType={'email-address'}
					/>

					<View style={PersonalInfoStyles.borderView}/>
					<Cell
						isFirst isLast
						title={'居住地址'}
						value={this.state.LiveAddress === '' ? '选择目前居住地址' : this.state.LiveAddress}
						clickCell={this.chooseAddress}/>
					<CellInput
						isLast
						InputStyle={[{ textAlign: 'left' }, this.state.addressInputStyle]}
						placeholder={'详细街道和门牌号'}
						maxLength={15}
						value={this.state.LiveDetailAddress}
						onFocus={() => {
							this.setState({
								addressInputStyle: PersonalInfoStyles.cellInputFocusStyle
							})
						}}
						onBlur={() => {
							this.setState({
								addressInputStyle: PersonalInfoStyles.cellInputStyle
							})
						}}
						textChange={text => this.changeInput(text, 'address')}
					/>

					<Cell
						isLast
						title={'居住时长'}
						value={this.state.LiveTime === '' ? '填写可提高通过率(选填)' : this.state.LiveTime}
						clickCell={() => this.select('time')}/>

					<ButtonHighlight
						title={'提交'}
						onPress={this.submit}
						// disabled={false}
						disabled={this.state.submitBtnDisabled}
						buttonStyle={PersonalInfoStyles.Btn}
					/>
					<View style={PersonalInfoStyles.buttonBottom}>
						<Image source={require('../../images/Common_Safe.png')}/>
						<Text style={PersonalInfoStyles.textContact}>银行级数据加密防护</Text>
					</View>
				</KeyboardAwareScrollView>

				<AlertConfirm
					ref={ref => { this.ConfirmExit = ref }}
					msg={'修改内容未保存，是否退出？'}
					msgStyle={{ textAlign: 'center', color: AppColors.grayColor }}
					rightBtnTextStyle={{ color: AppColors.lightBlackColor }}
					rightClick={this.ConfirmExitRight}/>

				<AlertConfirm
					title={'提示'}
					ref={ref => { this.ConfirmWarn = ref }}
					msg={'我司该产品暂不支持学生使用，请选择您的身份信息，平台会进一步核实'}
					leftBtnText={'我是学生'}
					leftClick={() => {
						this.ConfirmWarn.hide()
						Jump.backToTop(0)
					}}
					rightBtnText={'我是上班族'}
					rightBtnTextStyle={{ color: AppColors.lightBlackColor }}
					rightClick={this.ConfirmWarnRight}/>

				<GeneralSelector
					ref={ref => { this.selectorRef = ref }}
					clickCell={this.clickSelector}
					listData={this.state.seletData}/>
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}