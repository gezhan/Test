'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	TouchableOpacity,
	Dimensions,
	TouchableWithoutFeedback,
	Platform,
	StyleSheet,
	StatusBar
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../style';
import ButtonHighlight from './ButtonHighlight';
import Cell from './Cell';
import MyKeyboard from './MyKeyboard';
import DeviceInfo from '../utils/DeviceInfo'

let closeIcon = require('../images/PayBox_Close.png');
let choseNotGou = require('../images/PayBox_Check.png');
let chooseGou = require('../images/PayBox_Check_Active.png');
let AliPay = require('../images/PayBox_Ali1.png');
let AliTransferImg = require('../images/PayBox_Ali2.png');

export default class PayBox extends Component {
	constructor (props) {
		super(props);
		this.state = {
			modelVisible: false, // 是否显示控件
			isChoosePayType: false, // 是否显示支付方式
			isSelect: 1
		};
	}

	show = isShowChoose => {
		this.setState({
			modelVisible: true,
			isChoosePayType: isShowChoose === '1'
		}, () => {
			if (!(isShowChoose === '1')) {
				this.MyKeyboard.enterAnimate();
			}
		});
	};

	hide = callback => {
		this.setState({
			modelVisible: false,
			isChoosePayType: false
		}, () => {
			!!callback && callback();
		});
	};

	// 点击叉叉
	_close = () => {
		this.hide();
		!!this.props.close && this.props.close();
	};

	bankLeft = () => {
		const {
			bankLogo, 		// 银行支付 的 银行logo
			BankName, 		// 银行支付 的 银行名称
			CardNumber,		// 银行支付 的 银行卡号
			isRecommendedBank // 是否显示 银行卡推荐
		} = this.props;
		return (
			<View style={{ flexDirection: 'row', alignItems: 'center' }}>
				<Text style={{
					fontSize: RatiocalFontSize(28),
					color: AppColors.lightBlackColor
				}}>{BankName + '(尾号' + CardNumber + ')'}</Text>
				{ isRecommendedBank &&
				<View style={[General.center, {
					width: RatiocalWidth(70),
					height: RatiocalHeight(30),
					backgroundColor: 'red',
					borderRadius: RatiocalWidth(12) * 1.5,
					marginLeft: RatiocalWidth(12)
				}]}>
					<Text style={{ fontSize: RatiocalFontSize(22), color: 'white', backgroundColor: AppColors.tranBg }}>推荐</Text>
				</View>
				}
			</View>
		);
	};

	aliPayLeft = () => {
		const {
			ChannelFee,
			haveAliPayTip
		} = this.props;
		return (
			<View style={{}}>
				<Text style={{
					fontSize: RatiocalFontSize(28),
					marginBottom: RatiocalWidth(4),
					color: AppColors.lightBlackColor
				}}>{'支付宝支付'}</Text>
				{haveAliPayTip && <Text
					style={{ fontSize: RatiocalFontSize(24), color: '#999999' }}>{'需要额外支付通道费' + ChannelFee + '元,由支付宝收取'}</Text>}
			</View>
		);
	};

	// 支付宝支付的选择方法
	_toAliPaySelect = () => {
		if (this.state.isSelect !== 2) {
			this.setState({ isSelect: 2 });
		}
	};

	// 银行卡支付的选择方法
	_toPayBankSelect = () => {
		if (this.state.isSelect !== 1) {
			this.setState({ isSelect: 1 });
		}
	};

	toPayBank = enable => {
		enable();
		this.props.toPayBank();
	};

	/*
	 * @param {boo} [modelVisible] 		- 是否显示 半透明模态框
	 * @param {fun} [modelClick] 		- 半透明模态框 的 点击事件

	 * @param {boo} [isChoosePayType]	- 是否显示 支付方式选择框
	 * @param {boo} [isRecommendedBank]	- 是否显示 银行卡推荐
	 * @param {boo} [showAliPay]			- 是否显示 支付宝付款
	 * @param {boo} [haveAliPayTip]		- 是否显示 支付宝支付提示
	 * @param {boo} [showAliTransfer]	- 是否显示 支付宝转账

	 * @param {img} [bankLogo]			- 银行支付 的 银行logo
	 * @param {string} [BankName]		- 银行支付 的 银行名称
	 * @param {str|num} [CardNumber]		- 银行支付 的 银行卡号
	 * @param {string} [AliTransferTime]	- 支付宝  的 转账时间
	 * @param {str|num} [ChannelFee]		- 通道费
	 * @param {str|num} [Total]			- 总费用
	 * @param {string} [ShowLimitText]	- 还款提醒文字

	 * @param {fun} [toPayBank]			- 确认支付按钮的方法(就是银行卡支付)
	 * @param {fun} [toAliPay]			- 支付宝付款	的方法
	 * @param {fun} [toAliTransfer]		- 支付宝转账	的方法
	 * @param {fun} [toPay]				- 最终调用	的支付方法
	 * @param {fun} [forget]		 		- 忘记密码	的方法
	 * @param {fun} [close]		 		- 关闭模态框	的方法

	 */
	render () {
		const {
			close,			 // 关闭方法
			toPay,			 // 支付方法(银行卡支付和支付宝支付的最终接口调用支付方法)
			isChoosePayType, 	// 是否显示 支付方式选择框
			showAliTransfer,	// 是否显示 支付宝转账
			showAliPay,			// 是否显示 支付包付款
			AliTransferTime,	// 支付宝   转账时间
			forget, 		 	// 忘记密码 的 方法
			bankLogo, 		 	// 银行支付 的 银行logo
			BankName, 		 	// 银行支付 的 银行名称
			CardNumber,		 	// 银行支付 的 银行卡号
			toPayBank,			// 确认支付按钮 的 方法(就是银行卡支付)
			toAliTransfer,		// 支付宝转账 的 点击方法	1.2.3
			isRecommendedBank,	// 特殊银行支付样式	1.2.2添加
			haveAliPayTip, 	// 特殊支付宝支付样式	1.2.3添加
			toAliPay,		 	// 支付宝支付方法
			Total,				// 增加上税率的总费用
			isTopPay			// 是否是在一级页面还款
		} = this.props;
		let content =
			<TouchableWithoutFeedback onPress={() => this.hide()}>
				<View style={Model.model}>
					{ this.state.isChoosePayType &&
					<View style={[General.whiteBg, isTopPay ? choosePayTypeStyle.wrapModelTop : choosePayTypeStyle.wrapModel]}>
						<View style={[General.whiteBg, General.center, choosePayTypeStyle.wrap]}>
							<Text style={choosePayTypeStyle.header}>支付方式</Text>
							<TouchableOpacity onPress={this._close} style={choosePayTypeStyle.closeBtn}>
								<Image source={closeIcon} style={choosePayTypeStyle.closeImage}/>
							</TouchableOpacity>
						</View>

						<Cell
							isFirst={true}
							wrapperBtnStyle={choosePayTypeStyle.wrapperBtnStyle}
							leftIcon1={{ uri: bankLogo }}
							leftIcon1Style={choosePayTypeStyle.cellLeftIcon}
							slotLeft={() => this.bankLeft()}
							rightIcon2={this.state.isSelect === 1 ? chooseGou : choseNotGou}
							rightIcon2Style={choosePayTypeStyle.rightIcon2}
							clickCell={this._toPayBankSelect}/>
						{
							showAliPay &&
							<Cell
								wrapperBtnStyle={choosePayTypeStyle.wrapperBtnStyle}
								leftIcon1={AliPay}
								leftIcon1Style={choosePayTypeStyle.cellLeftIcon}
								slotLeft={() => this.aliPayLeft()}
								rightIcon2={this.state.isSelect === 2 ? chooseGou : choseNotGou}
								rightIcon2Style={choosePayTypeStyle.rightIcon2}
								clickCell={this._toAliPaySelect}/>
						}
						{showAliTransfer &&
						<Cell
							wrapperBtnStyle={choosePayTypeStyle.wrapperBtnStyle}
							leftIcon1={AliTransferImg}
							title={AliTransferTime ? '支付宝转账(' + AliTransferTime + ')' : '支付宝转账'}
							leftIcon1Style={choosePayTypeStyle.cellLeftIcon}
							clickCell={toAliTransfer}/>
						}
						<View style={[General.whiteBg, General.container, { alignItems: 'center' }]}>
							<ButtonHighlight
								title={this.state.isSelect === 1 ? '确认支付' : '确认支付' + Total + '元' }
								onPress={enable => {
									this.state.isSelect === 1
										? this.toPayBank(enable)
										: toAliPay(enable)
								}}
								buttonStyle={choosePayTypeStyle.confirmToPay}
							/>
						</View>
					</View>
					}
					<View
						style={[General.whiteBg, isTopPay ? choosePayTypeStyle.wrapModelTop : choosePayTypeStyle.wrapModel]}>
						<MyKeyboard
							showModal={false} ref={ref => { this.MyKeyboard = ref; }}
							payment={value => toPay(value)}
							close={this.hide}/>
					</View>
				</View>
			</TouchableWithoutFeedback>
		return (
			this.state.modelVisible ? content : null
		);
	}
}
const Model = StyleSheet.create({
	model: {
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		position: 'absolute',
		top: 0,
		left: 0,
		width: AppSizes.width,
		height: DeviceInfo.getModel() === 'OS105' ? AppSizes.height + StatusBar.currentHeight : AppSizes.height
	}
});
const choosePayTypeStyle = StyleSheet.create({
	wrapModel: {
		position: 'absolute',
		bottom: Platform.OS === 'android' ? (DeviceInfo.getModel() === 'OS105' ? 0 : StatusBar.currentHeight) : (AppSizes.height === 812 ? 34 : 0),
		left: 0,
		width: AppSizes.width,
		backgroundColor: AppColors.whiteBg
	},
	wrapModelTop: {
		position: 'absolute',
		bottom: Platform.OS === 'android' ? (DeviceInfo.getModel() === 'OS105' ? RatiocalHeight(98) : StatusBar.currentHeight + RatiocalHeight(98)) : (AppSizes.height === 812 ? RatiocalHeight(98) + 34 : RatiocalHeight(98)),
		left: 0,
		width: AppSizes.width,
		backgroundColor: AppColors.whiteBg
	},
	wrap: {
		height: RatiocalHeight(100),
		width: AppSizes.width,
		backgroundColor: AppColors.whiteBg,
		...General.center
	},
	wrapperBtnStyle: {
		height: parseInt(RatiocalHeight(120))
	},
	header: {
		fontSize: RatiocalFontSize(32),
		color: '#1a1a1a'
	},
	closeBtn: {
		height: RatiocalHeight(100),
		width: RatiocalWidth(100),
		position: 'absolute',
		top: 0,
		right: 0,
		...General.center
	},
	closeImageWrap: {},
	closeImage: {
		width: RatiocalWidth(24),
		height: RatiocalHeight(24),
		resizeMode: 'contain'
	},
	cellLeftIcon: {
		width: RatiocalWidth(56),
		height: RatiocalWidth(56),
		marginRight: RatiocalWidth(20),
		resizeMode: 'contain'
	},
	confirmToPay: {
		marginTop: RatiocalHeight(50),
		marginBottom: RatiocalWidth(48)
	},
	confirmBtnWrap: {
		backgroundColor: AppColors.whiteBg
	},
	rightIcon2: {
		width: RatiocalWidth(34),
		height: RatiocalHeight(34),
		resizeMode: 'contain'
	}
});