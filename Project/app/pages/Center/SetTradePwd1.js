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
	TouchableOpacity
} from 'react-native';
// components
import NavBarCommon from '../../components/NavBarCommon';
import { PaymentKeyboard } from '../../components/MyKeyboard/PaymentKeyboard';
import { toastShort } from '../../utils/ToastUtil';
import { connect } from 'react-redux';
// style
import { SetPwStyle, ForgetPwStyle } from './style/SetPwStyle';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../../style';
import Jump from '../../utils/Jump';
import FunctionUtils from '../../utils/FunctionUtils';
let circleImage = require('../../images/SetTPwdIcon.png');
let wrapImage = require('../../images/SetTPwdWrap.png');
@connect(
	state => ({
		baseInfo: state.baseInfo
	})
)
export default class SetTradePwd1 extends Component {
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
			checkTipText: '交易密码不能重复、连续的数字'
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
					if (FunctionUtils.isContinueNum(this.state.pwd) || FunctionUtils.isRepeat(this.state.pwd)) {
						toastShort('请不要输入连续或重复的数字作为密码')
					} else {
						Jump.go('SetTradePwd2', {
							code: this.props.code,
							idCard: this.props.idCard,
							pwd: this.state.pwd,
							type: this.props.type,
							resetPwd: () => {
								this.setState({ data: [], pwd: '', pwdLength: 0 }, () => {
									this.keyboardRef && this.keyboardRef.enterAnimate();
								})
							}
						});
						this.keyboardRef && this.keyboardRef.outAnimate();
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
				<View style={[ForgetPwStyle.container, { marginTop: RatiocalHeight(100) }]}>
					<Text style={{
						color: AppColors.grayColor,
						fontSize: AppFonts.text_size_32,
						textAlign: 'center'
					}}>
						请为账号
						<Text style={ForgetPwStyle.title2}>{FunctionUtils.ensurePhone(this.props.baseInfo.account)}</Text>
					</Text>
					<Text style={SetPwStyle.tip2}>设置6位数字交易密码</Text>
				</View>
				<View style={SetPwStyle.textInputWrap}>
					<Image
						source={wrapImage}
						resizeMode={'stretch'}
						style={SetPwStyle.image}>
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
				</View>

				<Text style={SetPwStyle.checkTip}>{this.state.checkTipText}</Text>
				<PaymentKeyboard
					ref={ref => { this.keyboardRef = ref }}
					onItemClick={value => this._changePwd(value)}
				/>
			</View>
		)
	}
}
