'use strict'

import React, { Component } from 'react'
import {
	View
} from 'react-native'
import { connect } from 'react-redux'
// utils
import { FunctionUtils, HttpRequest, Types, Url, toastShort, DataAlgorithm } from '../../config'
import Jump from '../../utils/Jump'
// components
import Loading from '../../components/Loading'
import NavBarCommon from '../../components/NavBarCommon'
import ButtonHighlight from '../../components/ButtonHighlight'
// styles
import { General } from '../../style'
import ModifyLoginPwdStyle from './style/ModifyLoginPwdStyle'
import CellInput from '../../components/CellInput'

@connect()
export default class ModifyLoginPwd extends Component {
	constructor (props) {
		super(props)
		this.state = {
			OldPwd: '',
			NewPwd1: '',
			NewPwd2: '',
			disabled: true
		}
	}

	go = path => {
		Jump.go(path)
	}

	changeOldPwd = pwd => {
		this.state.OldPwd = pwd
		this.calculate()
	}

	changeNewPwd1 = pwd => {
		this.state.NewPwd1 = pwd
		this.calculate()
	}

	changeNewPwd2 = pwd => {
		this.state.NewPwd2 = pwd
		this.calculate()
	}

	calculate = () => {
		let bool = this.state.OldPwd.length >= 6 && this.state.NewPwd1.length >= 6 && this.state.NewPwd2.length >= 6
		this.setState({ disabled: !bool })
	}

	save = enable => {
		if (this.state.OldPwd === this.state.NewPwd2) {
			toastShort('您的新密码和旧密码不能一样')
			enable()
			return
		}
		if (this.state.NewPwd1 !== this.state.NewPwd2) {
			toastShort('两次密码输入不一致')
			enable()
			return
		}
		if (!FunctionUtils.isNumberOrLetter(this.state.NewPwd2)) {
			toastShort('请输入6-20位登录密码(字母或数字)')
			enable()
			return
		}
		this.loading.show()
		let params = {
			Type: 1,
			OldPassword: DataAlgorithm.Md5Encrypt(this.state.OldPwd),
			Password: DataAlgorithm.Md5Encrypt(this.state.NewPwd2)
		}
		HttpRequest.request(Types.POST, Url.UPDAGE_LOGINPWD, params)
			.then(responseData => {
				this.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							toastShort('登录密码修改成功')
							FunctionUtils.loginOut()
							break
						case 408:
							enable()
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							enable()
							responseData.Msg && toastShort(responseData.Msg)
							break
					}
				}
			})
			.catch(error => {
				enable()
				this.loading.hide()
				console.log('error', error)
			})
	}

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'修改登录密码'} leftAction={() => Jump.back()} />
				<CellInput
					leftTitle="旧密码"
					placeholder={'请输入当前密码'}
					maxLength={20}
					cellwrapper={ModifyLoginPwdStyle.cellwrapper}
					leftTextStyle={ModifyLoginPwdStyle.leftTextStyle}
					InputStyle={ModifyLoginPwdStyle.inputStyle}
					value={this.state.OldPwd}
					textChange={this.changeOldPwd}
					showEyes={true}
				/>
				<CellInput  
					leftTitle="新密码"
					placeholder={'请输入6-20位数字或字母'}
					maxLength={20}
					cellwrapper={ModifyLoginPwdStyle.cellwrapper}
					leftTextStyle={ModifyLoginPwdStyle.leftTextStyle}
					InputStyle={ModifyLoginPwdStyle.inputStyle}
					value={this.state.NewPwd1}
					textChange={this.changeNewPwd1}
					showEyes={true}
				/>
				<CellInput
					isLast
					leftTitle="新密码确认"
					placeholder={'请输入6-20位数字或字母'}
					maxLength={20}
					cellwrapper={ModifyLoginPwdStyle.cellwrapper}
					leftTextStyle={ModifyLoginPwdStyle.leftTextStyle}
					InputStyle={ModifyLoginPwdStyle.inputStyle}
					value={this.state.NewPwd2}
					textChange={this.changeNewPwd2}
					showEyes={true}
				/>

				<ButtonHighlight
					title={'确定'}
					onPress={this.save}
					disabled={this.state.disabled}
					buttonStyle={ModifyLoginPwdStyle.buttonStyle}
				/>
				<Loading ref={ref => { this.loading = ref }} />
			</View>
		)
	}
}
