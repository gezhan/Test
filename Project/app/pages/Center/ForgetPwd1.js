'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	ListView,
	TouchableOpacity
} from 'react-native';
// components
import NavBarCommon from '../../components/NavBarCommon';
import { PaymentKeyboard } from '../../components/MyKeyboard/PaymentKeyboard';
import Loading from '../../components/Loading';
import { HttpRequest, Types, Url } from '../../config';
import { toastShort } from '../../utils/ToastUtil';
// style
import { SetPwStyle, ForgetPwStyle } from './style/SetPwStyle';
import { General } from '../../style';
import Jump from '../../utils/Jump';
import FunctionUtils from '../../utils/FunctionUtils';
import { connect } from 'react-redux';
// import { bindActionCreators } from 'redux'

let circleImage = require('../../images/SetTPwdIcon.png');
let wrapImage = require('../../images/SetTPwdWrap.png');

@connect(
	state => ({
		baseInfo: state.baseInfo,
		Sm: state.authInfo.Sm
	})
)
export default class ForgetPwd1 extends Component {
	constructor (props) {
		super(props);
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2
		});
		this.state = {
			dataSource: ds,
			data: [],
			pwd: '',
			pwdLength: 0,
			time: '收不到验证码？'
		};
	}

	_back = () => {
		Jump.back();
	};

	getCode = () => {
		HttpRequest.request(Types.POST, Url.MODIFY_TRADE_SEND_VCODE, { Verifyrealname: this.props.Sm.VerifyRealName, IdCard: this.props.Sm.IdCard })
			.then(responseData => {
				this.loading.hide();
				switch (responseData.Ret) {
					case 200:
						this.keyboardRef && this.keyboardRef.enterAnimate();
						toastShort('获取验证码成功');
						this.setState({
							time: '60s'
						}, () => {
							let timerCount = 60;
							this.interval = setInterval(() => {
								timerCount = timerCount - 1;
								if (timerCount === 0) {
									this.interval && clearInterval(this.interval);
									this.interval = null;
									this.setState({
										time: '收不到验证码？'
									})
								} else {
									this.setState({
										time: timerCount + 's'
									})
								}
							}, 1000)
						});
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
	}

	componentDidMount = () => {
		this.loading.show();
		this.getCode()
	};

	componentWillUnmount () {
		this.interval && clearInterval(this.interval);
		this.interval = null;
	}

	_changePwd = key => {
		switch (key) {
			case '回退':
				// 删除
				if (this.state.pwdLength > 0) {
					// console.log(this.state.pwd.substring(this.state.pwd.length-1,0));
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
					this.loading.show();
					HttpRequest.request(Types.POST, Url.CHECK_VCODE, { VCode: this.state.pwd, Step: 0 })
						.then(responseData => {
							this.loading.hide();
							switch (responseData.Ret) {
								case 200:
									Jump.go('ForgetPwd2', { code: this.state.pwd });
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
					this.keyboardRef && this.keyboardRef.outAnimate();
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

	// send = () => {
	// 	this.setState({
	// 		time: '60秒后重发',
	// 	});
	// 	let timerCount = 60;
	// 	this.interval = setInterval(() => {
	// 		timerCount = timerCount - 1;
	// 		if (timerCount === 0) {
	// 			this.interval && clearInterval(this.interval);
	// 			this.interval = null;
	// 			this.setState({
	// 				time: "收不到验证码？",
	// 			})
	// 		} else {
	// 			this.setState({
	// 				time: timerCount + '秒后重发'
	// 			})
	// 		}
	// 	}, 1000)
	// };

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
				<NavBarCommon
					title={'忘记交易密码'}
					leftAction={this._back}
				/>
				<View style={ForgetPwStyle.container}>
					<Text style={ForgetPwStyle.tip}>我们已发送验证码到您的手机</Text>
					<Text style={ForgetPwStyle.tel}>{FunctionUtils.ensurePhone(this.props.baseInfo.account)}</Text>
					<Image
						source={wrapImage}
						resizeMode={'stretch'}
						style={ForgetPwStyle.image}>
						<TouchableOpacity
							activeOpacity={1}
							onPress={() => { this.keyboardRef && this.keyboardRef.enterAnimate(); }}
							style={SetPwStyle.listviewWrap}>
							<ListView
								horizontal={true}
								enableEmptySections={true}
								dataSource={this.state.dataSource.cloneWithRows(this.state.data)}
								renderRow={this._renderRow}
							/>
						</TouchableOpacity>
					</Image>
					<Text style={ForgetPwStyle.tip2}>{this.state.time}
						{this.state.time === '收不到验证码？' &&
						<Text suppressHighlighting={true} style={ForgetPwStyle.send} onPress={() => this.getCode()}>重发短信</Text>}
					</Text>
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