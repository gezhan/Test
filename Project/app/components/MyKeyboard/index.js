'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	StatusBar,
	Animated,
	StyleSheet,
	TouchableOpacity
} from 'react-native';
import { toastShort } from '../../utils/ToastUtil';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../../style';
import { Keyboard, Key } from './PaymentKeyboard';
import Jump from '../../utils/Jump';
import DeviceInfo from '../../utils/DeviceInfo'

let backImage = require('../../images/PayBox_Close.png');
let blackDot = '●';
let onPress;
export default class MyKeyboard extends Component {
	static defaultProps = {
		showModal: true
	};

	constructor (props) {
		super(props);
		this.animatedValue = new Animated.Value(-1);
		this.state = {
			visible: false,
			passwordLength: 0,
			one: '',
			two: '',
			three: '',
			four: '',
			five: '',
			six: ''
		};
	}

	componentDidMount () {
	}

	/**
	 * 进入动画
	 */
	enterAnimate () {
		this.setState({
			visible: true
		}, () => {
			this.animatedValue.setValue(-1);
			Animated.spring(
				this.animatedValue,
				{
					toValue: 0, // 属性目标值
					friction: 15, // 摩擦力 （越小 振幅越大）
					tension: 90 // 拉力
				}
			).start()
		})
	}

	/**
	 * 退出动画
	 */
	outAnimate (complete) {
		this.animatedValue.setValue(0);
		Animated.spring(
			this.animatedValue,
			{
				toValue: -1, // 属性目标值
				friction: 17, // 摩擦力 （越小 振幅越大）
				tension: 80 // 拉力
			}
		).start();
		setTimeout(() => {
			this.setState({
				visible: false,
				passwordLength: 0,
				one: '',
				two: '',
				three: '',
				four: '',
				five: '',
				six: ''
			}, () => !!complete && complete())
		}, 350);
	}

	_payment (key) {
		const { payment } = this.props;
		switch (key) {
			case '回退': {
				// 删除
				if (this.state.passwordLength === 1 && this.state.one !== '') {
					this.setState({
						one: '',
						passwordLength: 0
					})
				} else if (this.state.passwordLength === 2 && this.state.two !== '') {
					this.setState({
						two: '',
						passwordLength: 1
					})
				} else if (this.state.passwordLength === 3 && this.state.three !== '') {
					this.setState({
						three: '',
						passwordLength: 2
					})
				} else if (this.state.passwordLength === 4 && this.state.four !== '') {
					this.setState({
						four: '',
						passwordLength: 3
					})
				} else if (this.state.passwordLength === 5 && this.state.five !== '') {
					this.setState({
						five: '',
						passwordLength: 4
					})
				} else if (this.state.passwordLength === 6 && this.state.six !== '') {
					this.setState({
						six: '',
						passwordLength: 5
					})
				}
				break;
			}
			case '完成': {
				// 完成
				let paymentCode = this.state.one + this.state.two + this.state.three + this.state.four + this.state.five + this.state.six;
				if (paymentCode.length === 6) {
					this.outAnimate(() => payment(paymentCode));
				} else {
					toastShort('请输入完整的支付密码');
				}
				break;
			}
			default: {
				if (this.state.passwordLength === 0 && this.state.one === '') {
					this.setState({
						one: key,
						passwordLength: 1
					})
				} else if (this.state.passwordLength === 1 && this.state.two === '') {
					this.setState({
						two: key,
						passwordLength: 2
					})
				} else if (this.state.passwordLength === 2 && this.state.three === '') {
					this.setState({
						three: key,
						passwordLength: 3
					})
				} else if (this.state.passwordLength === 3 && this.state.four === '') {
					this.setState({
						four: key,
						passwordLength: 4
					})
				} else if (this.state.passwordLength === 4 && this.state.five === '') {
					this.setState({
						five: key,
						passwordLength: 5
					})
				} else if (this.state.passwordLength === 5 && this.state.six === '') {
					this.setState({
						six: key,
						passwordLength: 6
					})
				}
				// 输入数字
				break;
			}
		}
	}

	forget = () => {
		!!this.props.close && this.props.close()
		Jump.go('ForgetPwd1')
	}

	render () {
		const { config, userInfo } = this.props;
		const marginBottom = this.animatedValue.interpolate({
			inputRange: [0, 1],
			outputRange: [0, 400]
		});
		let content = <Animated.View
			style={[Styles.GlobalView, { marginBottom: marginBottom }]}>
			<TouchableOpacity activeOpacity={1} style={Styles.HeaderView}>
				<TouchableOpacity activeOpacity={1} style={Styles.PasswordHeaderView}>
					<TouchableOpacity style={Styles.LeftView} onPress={() => this.outAnimate(this.props.close)}>
						<Image
							style={{ resizeMode: 'stretch', marginLeft: RatiocalWidth(30) }}
							source={backImage}/>
					</TouchableOpacity>
					<Text style={{ color: AppColors.lightBlackColor, fontSize: RatiocalFontSize(30) }}>请输入支付密码</Text>
					<TouchableOpacity style={Styles.RightView} onPress={() => this.forget()}>
						<Text style={{ color: AppColors.mainColor, fontSize: RatiocalFontSize(30) }}>忘记密码</Text>
					</TouchableOpacity>
				</TouchableOpacity>
				<View style={Styles.PasswordContianerView}>
					<View style={Styles.PasswordView}>
						<CodeView value={this.state.one}/>
						<View style={Styles.CodeVerticalLineView}/>
						<CodeView value={this.state.two}/>
						<View style={Styles.CodeVerticalLineView}/>
						<CodeView value={this.state.three}/>
						<View style={Styles.CodeVerticalLineView}/>
						<CodeView value={this.state.four}/>
						<View style={Styles.CodeVerticalLineView}/>
						<CodeView value={this.state.five}/>
						<View style={Styles.CodeVerticalLineView}/>
						<CodeView value={this.state.six}/>
					</View>
				</View>

			</TouchableOpacity>
			<Keyboard
				onPress={key => this._payment(key)}/>

		</Animated.View>
		if (this.state.visible) {
			if (this.props.showModal) {
				return (
					<TouchableOpacity
						activeOpacity={1} style={Styles.Container}
						onPress={() => this.outAnimate(this.props.close)}>
						{content}
					</TouchableOpacity>
				)
			} else {
				return content
			}
		} else {
			return null
		}
	}
}
class CodeView extends Component {
	render () {
		const { value, dot } = this.props;
		return (
			<View style={Styles.PasswordItem}>
				<Text>{value !== '' && blackDot}</Text>
			</View>
		)
	}
}

const Styles = StyleSheet.create({
	Container: {
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height,
		width: AppSizes.width,
		position: 'absolute',
		bottom: 0,
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		flexDirection: 'column',
		alignItems: 'center',
		justifyContent: 'flex-end'
	},
	GlobalView: {
		width: AppSizes.width,
		alignItems: 'center',
		justifyContent: 'center',
		backgroundColor: AppColors.whiteBg
	},
	HeaderView: {
		height: RatiocalHeight(310),
		width: AppSizes.width,
		alignItems: 'center'
	},
	PasswordHeaderView: {
		height: RatiocalHeight(100),
		width: AppSizes.width,
		alignItems: 'center',
		justifyContent: 'center',
		flexDirection: 'row',
		borderBottomWidth: AppSizes.pixelRatioWidth,
		borderColor: AppColors.grayBorder
	},
	PasswordContianerView: {
		flex: 1,
		alignItems: 'center',
		justifyContent: 'center'
	},
	LeftView: {
		position: 'absolute',
		left: 0
	},
	RightView: {
		position: 'absolute',
		right: RatiocalWidth(30)
	},
	PasswordView: {
		alignItems: 'center',
		justifyContent: 'center',
		flexDirection: 'row',
		borderWidth: AppSizes.pixelRatioWidth,
		borderColor: AppColors.grayBorder,
		borderRadius: RatiocalWidth(10)
	},
	PasswordItem: {
		height: RatiocalHeight(100),
		width: RatiocalWidth(100),
		alignItems: 'center',
		justifyContent: 'center'
	},
	CodeVerticalLineView: {
		width: AppSizes.pixelRatioWidth,
		height: RatiocalHeight(100),
		backgroundColor: AppColors.grayBorder
	}
});