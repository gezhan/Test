'use strict';

import React, { Component } from 'react';

import {
	View,
	Text,
	Modal,
	Image,
	Platform,
	ScrollView,
	StyleSheet,
	TouchableOpacity
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, AppColors, AppFonts, AppSizes, General } from '../style';

class SelectBottom extends Component {
	constructor (props) {
		super(props);
		this.state = {
			visible: false,
			firstIndex: 0,
			secondIndex: 0
		};
	}

	show = () => {
		this.setState({
			visible: true
		})
	}

	hide = () => {
		this.setState({
			visible: false
		})
	}

	checkList = (type, index) => {
		if (type === 1) {
			this.setState({
				firstIndex: index,
				secondIndex: 0
			})
		} else {
			this.setState({
				secondIndex: index
			})
		}
	}

	finish = () => {

	}

	render () {
		let {
			Title, SubTitle,
			data,
			Key1, Value1,
			SubListType, SubList, Key2, Value2
		} = this.props
		Key2 = Key2 || Key1
		Value2 = Value2 || Value1
		return (
			<Modal animationType={'fade'} transparent={true} visible={this.state.visible} onRequestClose={() => this.hide()}>
				<TouchableOpacity style={styles.Wrap} activeOpacity={1} onPress={ () => this.hide()}>
					<TouchableOpacity style={[styles.Main]} activeOpacity={1}>
						<View style={styles.Header}>
							<TouchableOpacity style={styles.CloseIcon} onPress={ () => this.hide()}>
								<Image source={require('../images/HomeBalanceAlert_close.png')} resizeMode="contain"/>
							</TouchableOpacity>
							<View style={styles.Title}>
								{ !!Title && <Text style={styles.title}>{Title}</Text> }
								{ !!SubTitle && <Text style={styles.subTitle}>{SubTitle}</Text> }
							</View>
							<TouchableOpacity
								style={styles.FinishBtn}
								onPress={ () => this.props.finish(data[this.state.firstIndex], data[this.state.firstIndex][SubList][this.state.secondIndex])}>
								<Text style={styles.OkBtn}>完成</Text>
							</TouchableOpacity>
						</View>

						<View style={styles.Contant}>
							<View style={styles.ContantLeft}>
								<ScrollView style={{ flex: 1 }}>
									{
										data &&
										data.map((item, index) => {
											return (
												<View style={[styles.Option1, index === 0 && {
													paddingTop: RatiocalHeight(4),
													height: RatiocalHeight(80)
												}]} key={index}>
													<TouchableOpacity
														style={[styles.Option11, this.state.firstIndex === index && styles.Option1Active]}
														onPress={() => this.checkList(1, index)}>
														<Text
															style={[styles.OptionText1, this.state.firstIndex === index && styles.OptionText1Active]}>{item[Key1]}</Text>
													</TouchableOpacity>
												</View>
											)
										})
									}
								</ScrollView>
							</View>

							<View style={styles.ContantRight}>
								<ScrollView style={{ flex: 1 }}>
									{
										data && data[this.state.firstIndex] && data[this.state.firstIndex][SubList] &&
										data[this.state.firstIndex][SubList].map((item, index) => {
											return (
												<TouchableOpacity
													style={[styles.Option2, index === data[this.state.firstIndex][SubList].length - 1 && { marginBottom: Platform.OS === 'ios' ? RatiocalHeight(10) : RatiocalHeight(20) }, this.state.secondIndex === index && styles.Option2Active]}
													key={index} onPress={() => this.checkList(2, index)}>
													<Text
														style={[styles.OptionText1, this.state.secondIndex === index && styles.OptionText1Active]}>{SubListType === 'none' ? item : item[Key1]}</Text>
												</TouchableOpacity>
											)
										})
									}
								</ScrollView>
							</View>
						</View>
					</TouchableOpacity>
				</TouchableOpacity>
			</Modal>

		);
	}
}

const styles = StyleSheet.create({
	Wrap: {
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		position: 'absolute',
		top: 0,
		left: 0,
		width: AppSizes.width,
		height: AppSizes.height

	},
	// Main------------------------------
	Main: {
		height: RatiocalHeight(120) + RatiocalHeight(80) * 5 + RatiocalHeight(10) * 7,
		width: AppSizes.width,
		position: 'absolute',
		bottom: Platform.OS === 'ios' ? 0 : 20,
		left: 0,
		zIndex: 9999,
		backgroundColor: AppColors.whiteBg
	},
	Header: {
		backgroundColor: AppColors.whiteBg,
		width: AppSizes.width,
		height: RatiocalHeight(120),
		flexDirection: 'row',
		justifyContent: 'space-between',
		alignItems: 'center',
		...General.container,
		...General.borderBottom
	},
	CloseIcon: {
		padding: RatiocalWidth(20),
		width: RatiocalWidth(62),
		height: RatiocalWidth(62),
		...General.center
	},
	FinishBtn: {
		padding: RatiocalWidth(20)
	},
	Title: {
		alignItems: 'center'
	},
	title: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor,
		marginBottom: RatiocalHeight(10)
	},
	subTitle: {
		fontSize: AppFonts.text_size_24,
		color: AppColors.grayColor
	},

	OkBtn: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.mainColor
	},

	// Contant------------------------------
	Contant: {
		paddingLeft: RatiocalHeight(10),
		paddingRight: RatiocalHeight(10),
		paddingBottom: RatiocalHeight(10),
		paddingTop: RatiocalHeight(0),
		flexDirection: 'row'
	},
	ContantLeft: {
		backgroundColor: AppColors.lightGrayBg,
		marginRight: RatiocalWidth(5),
		width: RatiocalWidth(310),
		height: RatiocalHeight(80) * 5 + RatiocalHeight(10) * 7
	},
	ContantRight: {
		width: RatiocalWidth(410),
		marginLeft: RatiocalWidth(5),
		height: RatiocalHeight(80) * 5 + RatiocalHeight(10) * 7
		// paddingBottom: Platform.OS === 'ios' ? RatiocalHeight(20) : RatiocalHeight(10),
	},
	Option1: {
		height: RatiocalHeight(76),
		width: RatiocalWidth(310),
		backgroundColor: AppColors.whiteBg,
		justifyContent: 'flex-end'
	},
	Option11: {
		backgroundColor: '#eeeeee',
		height: RatiocalHeight(70),
		width: RatiocalWidth(310),
		borderRadius: RatiocalHeight(10),
		...General.center
	},
	Option1Active: {
		backgroundColor: AppColors.whiteBg
	},
	OptionText1: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor
	},
	OptionText1Active: {
		color: AppColors.mainColor
	},
	Option2: {
		borderRadius: RatiocalHeight(10),
		height: RatiocalHeight(80),
		width: RatiocalWidth(410),
		marginTop: RatiocalHeight(10),
		backgroundColor: AppColors.lightGrayBg,
		...General.center
	},
	Option2Active: {
		backgroundColor: '#fdd4cc'
	}
});

export default SelectBottom;