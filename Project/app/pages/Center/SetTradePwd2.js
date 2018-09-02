'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	StatusBar,
	ListView,
	DeviceEventEmitter
} from 'react-native';
// components
import { connect } from 'react-redux';
import NavBarCommon from '../../components/NavBarCommon';
import { PaymentKeyboard } from '../../components/MyKeyboard/PaymentKeyboard';
import Loading from '../../components/Loading';
import { toastShort } from '../../utils/ToastUtil';
import { HttpRequest, Types, Url, DataAlgorithm } from '../../config';
// style
import { SetPwStyle } from './style/SetPwStyle';
import { General } from '../../style';
import Jump from '../../utils/Jump';
import FunctionUtils from '../../utils/FunctionUtils';

let circleImage = require('../../images/SetTPwdIcon.png');
let wrapImage = require('../../images/SetTPwdWrap.png');

@connect()
export default class SetTradePwd2 extends Component {
	constructor (props) {
		super(props);
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2
		});
		this.state = {
			dataSource: ds,
			data: [],
			pwd: '',
			pwdLength: 0
		};
	}

	_back = () => {
		Jump.back();
	};

	componentDidMount = () => {
		this.keyboardRef && this.keyboardRef.enterAnimate();
	};

	_changePwd = key => {
		switch (key) {
			case '回退':
				// 删除
				if (this.state.pwdLength > 0) {
					console.log(this.state.pwd.substring(this.state.pwd.length - 1, 0));
					this.setState({
						pwd: this.state.pwd.substring(this.state.pwd.length - 1, 0),
						pwdLength: this.state.pwd.substring(this.state.pwd.length - 1, 0).length,
						data: this.state.pwd.substring(this.state.pwd.length - 1, 0).split('')
					})
				}
				break;
			case '完成':
				// 完成
				if (this.state.pwd.length === 6) {
					if (this.state.pwd === this.props.pwd) {
						this.loading.show();
						HttpRequest.request(Types.POST, Url.SET_PAYPWD, { Verifytradepassword: DataAlgorithm.Md5Encrypt(this.state.pwd) })
							.then(responseData => {
								this.loading.hide();
								switch (responseData.Ret) {
									case 200:
										if (this.props.type === 'forgetTrade') {
											toastShort('重置交易密码成功');
										} else {
											toastShort('设置交易密码成功');
										}
										if (Jump.findRoute('LoanApplication')) {
											Jump.back('LoanApplication');
										} else {
											Jump.backToTop();
										}
										break;
									case 408:
										FunctionUtils.loginOut(this.props.dispatch);
										break;
									default:
										toastShort(responseData.Msg);
										break;
								}
							})
							.catch(error => {
								this.loading.hide();
								console.log('error', error);
							});
					} else {
						toastShort('密码前后不一致');
						this.props.resetPwd && this.props.resetPwd();
						Jump.back();
					}
				} else {
					toastShort('请输入完整的支付密码')
				}
				break;
			default:
				if (this.state.pwdLength < 6) {
					this.setState({
						pwd: this.state.pwd + key,
						pwdLength: (this.state.pwd + key).length,
						data: (this.state.pwd + key).split('')
					})
				}
				// 输入数字
				break;
		}
	};

	_renderRow = (rowData, sectionID, rowID) => {
		return (
			<View style={SetPwStyle.pwIconWrap}>
				<Image source={circleImage}/>
			</View>
		)
	};

	render () {
		return (
			<View style={General.wrapViewGray}>
				<StatusBar barStyle={'light-content'}/>
				<NavBarCommon
					title={'设置交易密码'}
					leftAction={this._back}
				/>
				<View style={SetPwStyle.titleWrap}>
					<View style={SetPwStyle.tipStyle}>
						<Text style={SetPwStyle.tipTextStyle}>确认交易密码</Text>
					</View>
				</View>
				<View style={SetPwStyle.textInputWrap}>
					<Image
						source={wrapImage}
						resizeMode={'stretch'}
						style={SetPwStyle.image}>
						<ListView
							horizontal={true}
							enableEmptySections={true}
							dataSource={this.state.dataSource.cloneWithRows(this.state.data)}
							renderRow={this._renderRow}
						/>
					</Image>
				</View>
				<PaymentKeyboard
					ref={ref => { this.keyboardRef = ref }}
					onItemClick={value => this._changePwd(value)}
				/>
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		)
	}
}