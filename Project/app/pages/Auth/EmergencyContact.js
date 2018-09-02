'use strict'
import React, {
	Component
} from 'react'
import {
	View,
	Text,
	Image,
	Platform,
	ScrollView,
	NativeModules
} from 'react-native'
// views
import Cell from '../../components/Cell'
import GpsAlert from '../../components/GpsAlert'
import Loading from '../../components/Loading'
import AlertConfirm from '../../components/AlertConfirm'
import NavBarCommon from '../../components/NavBarCommon'
import ButtonHighlight from '../../components/ButtonHighlight'
import GeneralSelector from '../../components/GeneralSelector'
// styles
import EmergencyContactStyle from './style/EmergencyContactStyle'
import { General, RatiocalHeight, AppColors } from '../../style'
// utils
import { Types, HttpRequest, Url, toastShort, FunctionUtils, Jump } from '../../config'
// action
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { GetAuth } from '../../actions/AuthAction'
import { GetIpLocate } from '../../actions/BaseAction'

// ios权限检测
const PermissionsDetect = Platform.OS === 'ios' ? NativeModules.PermissionsDetect : NativeModules.BqsDeviceModule

@connect(
	state => ({
		baseInfo: state.baseInfo,
		authInfo: state.authInfo
	}),
	dispatch => ({
		dispatch,
		...bindActionCreators({ GetIpLocate, GetAuth }, dispatch)
	})
)
export default class EmergencyContact extends Component {
	constructor (props) {
		super(props)
		this.state = {
			nextBtnDisabled: true,
			firRelationValue: '',
			secRelationValue: '',
			isChooseFirstType: false,
			firstList: ['父母', '配偶', '兄弟姐妹', '子女'],
			secondList: ['朋友', '同事', '亲戚', '其他'],
			firstPerson: '',
			firstTel: '',
			secondPerson: '',
			secondTel: '',
			// 通讯录联系人
			contactsData: [],
			relationTag: 1,		// 1是亲属，2是其他
			// 权限检测   弹框文字
			ContactMsg: ''
		}
	}
	componentDidMount () {
		this.props.GetIpLocate()
		this.fetch()
	}

	fetch = () => {
		this.loading.show()
		HttpRequest.request(Types.POST, Url.GET_LINKMAN)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							if (responseData.Data && responseData.Data.length !== 0) {
								if (responseData.Data[0].RelationTag === 1) {
									this.setState({
										firRelationValue: responseData.Data[0].Relation,
										firstPerson: responseData.Data[0].LinkName,
										firstTel: responseData.Data[0].ContactPhoneNumber,
										secRelationValue: responseData.Data[1].Relation,
										secondPerson: responseData.Data[1].LinkName,
										secondTel: responseData.Data[1].ContactPhoneNumber
									});
								} else {
									this.setState({
										firRelationValue: responseData.Data[1].Relation,
										firstPerson: responseData.Data[1].LinkName,
										firstTel: responseData.Data[1].ContactPhoneNumber,
										secRelationValue: responseData.Data[0].Relation,
										secondPerson: responseData.Data[0].LinkName,
										secondTel: responseData.Data[0].ContactPhoneNumber
									});
								}
							}
							break
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							responseData.Msg && toastShort(responseData.Msg)
							break
					}
				}
			})
			.catch(error => {
				this.loading.hide()
				console.log('error', error)
			})
	}

	// 点击cell 显示选择列表
	showChooseList = type => {
		!!this.selectorRef && this.selectorRef.show()
		if (type === 1) {
			this.setState({ isChooseFirstType: true })
		} else if (type === 2) {
			this.setState({ isChooseFirstType: false })
		}
	}

	// 选择关系
	clickSelector = (rowData, sectionID, rowID) => {
		!!this.selectorRef && this.selectorRef.hidden()
		if (this.state.isChooseFirstType) {
			this.state.firRelationValue = rowData
			this.state.relationTag = 1
			this.calculate()
			this.forceUpdate()
		} else {
			this.state.secRelationValue = rowData
			this.state.relationTag = 2
			this.calculate()
			this.forceUpdate()
		}
	}

	calculate = () => {
		const { authInfo } = this.props
		if (authInfo.IsLinkMan === 0) {
			if (!!this.state.firRelationValue &&
				!!this.state.firstTel &&
				!!this.state.firstPerson &&
				!!this.state.secRelationValue &&
				!!this.state.secondTel &&
				!!this.state.secondPerson) {
				this.state.nextBtnDisabled = false
			} else {
				this.state.nextBtnDisabled = true
			}
		} else {
			if ((!!this.state.firRelationValue &&
				!!this.state.firstTel &&
				!!this.state.firstPerson) ||
				(!!this.state.secRelationValue &&
				!!this.state.secondTel &&
				!!this.state.secondPerson)) {
				this.state.nextBtnDisabled = false
			} else {
				this.state.nextBtnDisabled = true
			}
		}
	}

	getContactList = result => {
		console.log(result)
		this.loading.hide()
		if (result.Ret === 200) {
			if (result.Data) {
				this.setState({ contactsData: result.Data })
			} else {
				toastShort('暂无可选联系人')
			}
		} else if (result.Ret === 304) {
			this.setState({
				ContactMsg: result.Msg
			})
			this.ConfirmWarn.show()
		}
	}

	getLinkman = (name, phoneValue, type) => {
		this.loading && this.loading.hide()
		if (name && phoneValue) {
			let phone = String(phoneValue).replace(/[^0-9]/ig, '')
			if (phone.length === 13) {
				phone = phone.substring(2, phone.length)
			}
			if (type === 1) {
				if (this.state.secondTel === phone) {
					toastShort('两个联系人不能为同一个号码')
					return
				}
				this.state.firstPerson = name
				this.state.firstTel = phone
			} else {
				if (this.state.firstTel === phone) {
					toastShort('两个联系人不能为同一个号码')
					return
				}
				this.state.secondPerson = name
				this.state.secondTel = phone
			}
			this.state.relationTag = type
			this.calculate()
			this.forceUpdate()
		}
	}

	// 从通讯录选择
	chooseType = type => {
		FunctionUtils.getContacts(this.getContactList, this.getLinkman, type)
	}

	submitEmercyContact = enable => {
		const { baseInfo } = this.props

		FunctionUtils.getLocation(baseInfo.isNeedLocation, (isOpenLocation, isGetLocation, locationObj) => {
			console.log(isOpenLocation)
			console.log(isGetLocation)
			if (isOpenLocation) {
				let isGetLocat = isOpenLocation && isGetLocation
				let emergencyContacts = [
					{
						Relation: this.state.firRelationValue,
						LinkMobile: this.state.firstTel,
						RelationTag: 1,
						LinkName: this.state.firstPerson
					},
					{
						Relation: this.state.secRelationValue,
						LinkMobile: this.state.secondTel,
						RelationTag: 2,
						LinkName: this.state.secondPerson
					}
				]
				let param = {
					LinkInfo: emergencyContacts,
					// ContactType: 3,
					IpLocation: baseInfo.ipCity,
					IpAddress: baseInfo.ipDetailLocation,
					Location: isGetLocat ? baseInfo.location : '',
					Address: isGetLocat ? baseInfo.locationDetail : '',
					LongitudeLatitude: isGetLocat ? baseInfo.longitudeAndLatitude : ''
				}
				HttpRequest.request(Types.POST, Url.UPDATE_LINKMAN, param)
					.then(responseData => {
						enable()
						this.loading.hide()
						this.setState({ nextBtnDisabled: false })
						if (responseData.Ret) {
							switch (responseData.Ret) {
								case 200:
									console.log('常用联系人提交成功！')
									toastShort('常用联系人提交成功！')
									this.props.GetAuth(this)
									Jump.back()
									break
								case 408:
									FunctionUtils.loginOut(responseData.Msg)
									break
								default:
									responseData.Msg && toastShort(responseData.Msg)
									break
							}
						}
					})
					.catch(error => {
						enable()
						this.setState({ nextBtnDisabled: false })
						this.loading.hide()
						console.log('error', error)
					})
			} else {
				this.loading.hide()
				enable();
				if (!isOpenLocation) {
					this.Alert.show({ msg: locationObj.msg })
				} else {
					locationObj.msg && toastShort(locationObj.msg);
				}
			}
		})
	}

	// 提交通讯录新
	subTXLNew = enable => {
		HttpRequest.request(Types.POST, Url.UPDATE_MAILLIST, {
			Contact: this.state.contactsData,
			ContactType: 2
		}).then(responseData => {
			if (responseData) {
				switch (responseData.Ret) {
					case 200:
						console.log('通讯录提交成功！')
						this.submitEmercyContact(enable)
						break
					case 408:
						this.loading.hide()
						enable()
						FunctionUtils.loginOut(responseData.Msg)
						break
					default:
						this.submitEmercyContact(enable)
						responseData.Msg && toastShort(responseData.Msg)
						break
				}
			}
		})
			.catch(error => {
				this.submitEmercyContact(enable)
				console.log('error', error)
			})
	}

	confirmRight = () => {
		this.ConfirmWarn.hide()
		if (Platform.OS === 'ios') {
			PermissionsDetect.JumpSetting();
		} else {
			PermissionsDetect.openSystemSetting();
		}
	}

	// Gps alert 按钮点击事件
	AlertBtnClick = () => {
		this.Alert.hide()
		if (Platform.OS === 'ios') {
			PermissionsDetect.JumpSetting()
		} else {
			PermissionsDetect.openSystemSetting()
		}
	}

	// 下一步
	nextStep = enable => {
		const { baseInfo } = this.props
		if (this.state.firRelationValue === '' || this.state.secRelationValue === '') {
			toastShort('与本人关系不能为空')
			enable()
			return
		}
		if (this.state.firstTel.length !== 11 || this.state.secondTel.length !== 11) {
			toastShort('常用联系人号码格式不符')
			enable()
			return
		}
		if (this.state.firstTel === this.state.secondTel) {
			toastShort('两个联系人不能为同一个号码')
			enable()
			return
		}
		if ((this.state.firstTel && parseInt(this.state.firstTel) === parseInt(baseInfo.account)) || (this.state.secondTel && parseInt(this.state.secondTel) === parseInt(baseInfo.account))) {
			toastShort('常用联系人号码不能与注册手机号一致')
			enable()
			return
		}
		this.loading.show()
		this.subTXLNew(enable)// 上传通讯录
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'紧急联系人'} leftAction={() => Jump.back()} />
				<ScrollView keyboardShouldPersistTaps={'always'} style={{ flex: 1 }} keyboardDismissMode={Platform.OS === 'ios' ? 'on-drag' : 'none'} >
					<View style={EmergencyContactStyle.contact1}>
						<Cell
							title={'亲属联系人'}
							titleTextStyle={EmergencyContactStyle.cellTitle}
							wrapperBtnStyle={ EmergencyContactStyle.topCellWrapperStyle }/>
						<Cell
							title={'与本人关系'}
							value={this.state.firRelationValue === '' ? '请选择关系' : this.state.firRelationValue}
							clickCell={() => { this.showChooseList(1) }}
							wrapperBtnStyle={EmergencyContactStyle.paddingRight0}
						/>
						<Cell
							title={'常用联系人'} noBorder
							value={this.state.firstPerson === '' ? '请选择姓名' : this.state.firstPerson}
							clickCell={() => { this.chooseType(1) }}
							wrapperBtnStyle={ EmergencyContactStyle.bottomCellWrapperStyle }/>
					</View>
					<View style={EmergencyContactStyle.contact2}>
						<Cell
							title={'其他联系人'}
							titleTextStyle={EmergencyContactStyle.cellTitle}
							wrapperBtnStyle={ EmergencyContactStyle.topCellWrapperStyle }/>
						<Cell
							title={'与本人关系'}
							value={this.state.secRelationValue === '' ? '请选择关系' : this.state.secRelationValue}
							clickCell={() => { this.showChooseList(2) }}
							wrapperBtnStyle={EmergencyContactStyle.paddingRight0}
						/>
						<Cell
							title={'常用联系人'} noBorder
							value={this.state.secondPerson === '' ? '请选择姓名' : this.state.secondPerson}
							clickCell={() => { this.chooseType(2) }}
							wrapperBtnStyle={ EmergencyContactStyle.bottomCellWrapperStyle }/>
					</View>
					<View style={[General.container, { marginTop: RatiocalHeight(100) }]}>
						<ButtonHighlight
							title={'保存'}
							onPress={this.nextStep}
							disabled={this.state.nextBtnDisabled}
						/>
						<View style={EmergencyContactStyle.buttonBottom}>
							<Image source={require('../../images/Common_Safe.png')}/>
							<Text style={EmergencyContactStyle.textContact}>银行级数据加密防护</Text>
						</View>
					</View>
				</ScrollView>
				<AlertConfirm
					ref={ ref => { this.ConfirmWarn = ref }}
					msg={this.state.ContactMsg}
					leftClick={() => this.ConfirmWarn.hide()}
					rightBtnTextStyle={{ color: AppColors.lightBlackColor }}
					rightClick={this.confirmRight}/>
				<Loading ref={ref => { this.loading = ref }} />
				<GeneralSelector
					ref={ref => { this.selectorRef = ref }}
					clickCell={this.clickSelector}
					listData={this.state.isChooseFirstType ? this.state.firstList : this.state.secondList}
				/>
				<GpsAlert
					ref={ ref => { this.Alert = ref }}
					btnText={'立即开启'}
					btnClick={this.AlertBtnClick} />
			</View>
		)
	}
}
