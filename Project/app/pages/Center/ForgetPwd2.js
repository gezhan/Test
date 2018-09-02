'use strict';

import React, { Component } from 'react';

import {
	Text,
	View,
	TextInput
} from 'react-native';
import Jump from '../../utils/Jump';
import { General } from '../../style';
import NavBarCommon from '../../components/NavBarCommon';
import { toastShort } from '../../utils/ToastUtil';
import ButtonHighlight from '../../components/ButtonHighlight';
import { ForgetPwStyle } from './style/SetPwStyle';
import { connect } from 'react-redux';
import FunctionUtils from '../../utils/FunctionUtils';
import Loading from '../../components/Loading';
import { HttpRequest, Types, Url } from '../../config';

@connect(
	state => ({
		baseInfo: state.baseInfo,
		Sm: state.authInfo.Sm
	})
)
export default class ForgetPwd2 extends Component {
	constructor (props) {
		super(props);

		this.state = {
			idCard: '',
			disabled: true

		};
	}

	textChange = text => {
		this.state.idCard = text;
		this.state.disabled = !!this.state.idCard !== true
		this.forceUpdate()
	};

	next = enable => {
		this.loading.show();
		HttpRequest.request(Types.POST, Url.CHECK_VCODE, { IdCard: this.state.idCard, Step: 1 })
			.then(responseData => {
				enable();
				this.loading.hide();
				this._txtInput.blur();
				switch (responseData.Ret) {
					case 200:
						Jump.go('SetTradePwd1', { type: 'forgetTrade' });
						break;
					case 408:
						FunctionUtils.loginOut(this.props.dispatch);
						break;
					default:
						toastShort(responseData.Msg);
						break;
				}
			}).catch(error => {
				enable();
				this.loading.hide();
				console.log('error', error);
			});
	};

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon
					title={'忘记交易密码'}
					leftAction={() => Jump.back()}
				/>

				<Text style={ForgetPwStyle.title}>
					填写
					<Text style={ForgetPwStyle.title2}>{FunctionUtils.ensureName(this.props.Sm.VerifyRealName) + '的身份证号'}</Text>
					验证身份
				</Text>

				<View style={ForgetPwStyle.inPutWrapper}>
					<TextInput
						ref={ref => { this._txtInput = ref }}
						style={ForgetPwStyle.inPutStyle}
						value={this.state.idCard}
						placeholder={'请输入证件号码'}
						maxLength={18}
						onChangeText={text => this.textChange(text)}
						underlineColorAndroid="transparent"
					/>
				</View>
				<ButtonHighlight
					buttonStyle={ForgetPwStyle.nextBtn}
					onPress={enable => this.next(enable)}
					title="下一步"
					disabled={this.state.disabled}
				/>
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		);
	}
}