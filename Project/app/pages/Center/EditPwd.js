'use strict';

import React, { Component } from 'react';

import {
	View
} from 'react-native';
import Jump from '../../utils/Jump'
import { General } from '../../style'
import Cell from '../../components/Cell'
import NavBarCommon from '../../components/NavBarCommon'

export default class EditPwd extends Component {
	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon title={'修改密码'} leftAction={() => Jump.back()} />
				<Cell title={'修改登录密码'} clickCell={() => Jump.go('ModifyLoginPwd')}/>
				<Cell title={'修改交易密码'} clickCell={() => Jump.go('ForgetPwd1')}/>
			</View>
		);
	}
}