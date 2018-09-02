import React, { Component } from 'react';
import {
	StyleSheet,
	View,
	Image,
	Animated,
	TextInput,
	Text,
	TouchableOpacity,
	Keyboard,
	Platform,
	InteractionManager
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../style';
const dismissKeyboard = require('dismissKeyboard');
export default class FloatCommentView extends Component {
	constructor (props) {
		super(props);
		this.animatedValue = new Animated.Value(-1);
		this.state = {
			showInput: false,
			inputTxt: '',
			bottomHeight: 0
		}
	}

	componentDidMount () {
		this.keyboardWillShowSubscription1 = Keyboard.addListener('keyboardWillShow', this._willShowChangeKeyboardHeight1.bind(this));
		this.keyboardWillHideSubscription1 = Keyboard.addListener('keyboardWillHide', this._willHideChangeKeyboardHeight1.bind(this));
		this.keyboardDidShowSubscription1 = Keyboard.addListener('keyboardDidShow', this._didShowChangeKeyboardHeight1.bind(this));
		this.keyboardDidHideSubscription1 = Keyboard.addListener('keyboardDidHide', this._didHideChangeKeyboardHeight1.bind(this));
	}

	componentWillUnmount () {
		this.keyboardWillShowSubscription1 && this.keyboardWillShowSubscription1.remove();
		this.keyboardWillHideSubscription1 && this.keyboardWillHideSubscription1.remove();
		this.keyboardDidShowSubscription1 && this.keyboardDidShowSubscription1.remove();
		this.keyboardDidHideSubscription1 && this.keyboardDidHideSubscription1.remove();
	}

	_willShowChangeKeyboardHeight1 (frames) {
		const keyboardSpace = frames.endCoordinates.height;// 获取键盘高度
		if (Platform.OS === 'ios') {
			this.setState({
				bottomHeight: RatiocalHeight(338) + keyboardSpace + 5
			})
		}
	}

	_willHideChangeKeyboardHeight1 () {
		if (Platform.OS === 'ios') {
			this.hide();
		}
	}

	_didShowChangeKeyboardHeight1 (frames) {
		const keyboardSpace = frames.endCoordinates.height;// 获取键盘高度
		if (Platform.OS === 'android') {
			this.setState({
				bottomHeight: RatiocalHeight(338) + keyboardSpace + 30
			})
		}
	}

	_didHideChangeKeyboardHeight1 () {
		if (Platform.OS === 'android') {
			dismissKeyboard();
			this.hide();
		}
	}

	showInput () {
		this.setState({
			showInput: true,
			inputTxt: ''
		}, () => {
			this.textInput.focus();
			this.animatedValue.setValue(0);
			Animated.spring(
				this.animatedValue,
				{
					duration: 300,
					toValue: 1, // 属性目标值
					friction: 15, // 摩擦力 （越小 振幅越大）
					tension: 90 // 拉力
				}
			).start()
		})
	}

	hide () {
		InteractionManager.runAfterInteractions(() => {
			this.setState({
				showInput: false,
				bottomHeight: 0
			}, () => {
				if (this.isNeedSend === true) {
					this.isNeedSend = false;
					!!this.props.sendComment && this.props.sendComment(this.state.inputTxt);
				}
			});
		});
	}

	send () {
		if (this.state.inputTxt === '') {
			!!this.props.toastTip && this.props.toastTip();
		} else {
			this.isNeedSend = true;
			dismissKeyboard();
		}
	}

	setInputTxt = txt => {
		this.setState({
			inputTxt: txt
		});
	};

	render () {
		const { clickCommentList, sendComment } = this.props;
		let marginBottom = this.animatedValue.interpolate({
			inputRange: [0, 1],
			outputRange: [0, this.state.bottomHeight]
		});
		return (
			this.state.showInput === false ? (
				<View style={[General.borderTop, styles.parent]}>
					<View style={[styles.wrap, General.center]}>
						<TouchableOpacity
							activeOpacity={1}
							onPress={() => { this.showInput() }}
							style={styles.txtParent}>
							<Text style={styles.txt}>在这里说点什么</Text>
						</TouchableOpacity>
						{!!clickCommentList &&
						<TouchableOpacity activeOpacity={1} onPress={() => {
							!!this.props.clickCommentList && this.props.clickCommentList()
						}}>
							<Image
								style={styles.img}
								source={require('../images/DetailComment.png')}/>
						</TouchableOpacity>
						}
					</View>
				</View>
			) : (
				<View style={styles.parent2}>
					<Animated.View style={{ height: marginBottom, backgroundColor: AppColors.lightGrayBg }}>
						<View style={[styles.parent2Sub]}>
							<View style={styles.inputHead}>
								<Text style={styles.cancelTxt} onPress={() => {
									this.hide()
								}}>取消</Text>
								<Text style={styles.writeTxt}>写评论</Text>
								<Text style={styles.sendTxt} onPress={() => {
									this.send()
								}}>发送</Text>
							</View>
							<View style={styles.inputLine}>
								<TextInput
									style={styles.input}
									ref={ref => {
										this.textInput = ref
									}}
									maxLength={200}
									multiline={true}
									value={this.state.inputTxt}
									onChangeText={text => this.setInputTxt(text)}
									keyboardType={'default'}
									underlineColorAndroid={'transparent'}/>
							</View>
						</View>
					</Animated.View>
				</View>
			)
		)
	}
}

const styles = StyleSheet.create({
	parent2: {
		height: AppSizes.height,
		width: AppSizes.width,
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		position: 'absolute',
		flexDirection: 'column',
		alignItems: 'center',
		justifyContent: 'flex-end'
	},
	parent2Sub: {
		backgroundColor: AppColors.lightGrayBg,
		width: AppSizes.width,
		paddingLeft: RatiocalWidth(10),
		paddingRight: RatiocalWidth(10)
	},
	parent: {
		position: 'absolute',
		left: 0,
		bottom: 0,
		width: AppSizes.width,
		height: RatiocalHeight(88)
	},
	wrap: {
		flex: 1,
		flexDirection: 'row',
		width: AppSizes.width,
		justifyContent: 'space-between',
		paddingLeft: RatiocalWidth(20),
		paddingRight: RatiocalWidth(20)
	},
	txtParent: {
		flex: 1,
		paddingLeft: RatiocalWidth(20),
		height: RatiocalHeight(60),
		borderRadius: RatiocalHeight(60) / 2,
		borderWidth: AppSizes.pixelRatioWidth,
		borderColor: AppColors.ironBorder,
		justifyContent: 'center'
	},
	txt: {
		fontSize: AppFonts.text_size_24,
		color: AppColors.grayColor,
		marginRight: RatiocalWidth(20)
	},
	img: {
		marginLeft: RatiocalWidth(20)
	},
	cancelTxt: {
		padding: RatiocalWidth(10),
		fontSize: AppFonts.text_size_26,
		color: AppColors.grayColor
	},
	sendTxt: {
		padding: RatiocalWidth(10),
		fontSize: AppFonts.text_size_26,
		color: AppColors.lightBlackColor
	},
	writeTxt: {
		fontSize: AppFonts.text_size_32,
		color: AppColors.lightBlackColor
	},
	inputHead: {
		height: RatiocalHeight(88),
		width: AppSizes.width - RatiocalWidth(20),
		paddingLeft: RatiocalWidth(10),
		paddingRight: RatiocalWidth(10),
		flexDirection: 'row',
		justifyContent: 'space-between',
		alignItems: 'center'
	},
	inputLine: {
		height: RatiocalHeight(200),
		width: AppSizes.width - RatiocalWidth(40),
		marginLeft: RatiocalWidth(10),
		marginRight: RatiocalWidth(10),
		marginBottom: RatiocalHeight(50),
		borderRadius: RatiocalHeight(60) / 2,
		borderWidth: AppSizes.pixelRatioWidth,
		borderColor: AppColors.ironBorder,
		...General.container
	},
	input: {
		flexGrow: 1,
		textAlignVertical: 'top',
		fontSize: AppFonts.text_size_28
	}
});