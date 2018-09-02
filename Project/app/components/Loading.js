'use strict';
/**
 * 公用组件Loading(给用户好提示，显示加载中)
 */

import React, { Component } from 'react';
import {
	StyleSheet,
	Dimensions,
	View,
	Text,
	ActivityIndicator
} from 'react-native';

export default class Loading extends Component {
	static defaultProps = {
		showText: true,
		loadingText: '加载中请稍后...'
	};

	constructor (props) {
		super(props);
		this.state = {
			visibly: false
		}
	}

	show () {
		this.setState({ visibly: true });
	}

	hide () {
		this.setState({ visibly: false })
	}

	render () {
		const { containerStyle, backgroudStyle, indicatorColor, showText, loadingTextStyle, loadingText, loadingStyle } = this.props;
		let initColor = '#ffffff'
		if (indicatorColor) {
			initColor = indicatorColor
		}
		let contentView = this.state.visibly === true ? (
			<View style={[styles.container, containerStyle, loadingStyle]}>
				<View style={[styles.backgroud, backgroudStyle]}>
					<ActivityIndicator
						size={'large'}
						color={initColor}
					/>
					{
						showText ? <Text style={[styles.loadingText, loadingTextStyle]}>{loadingText}</Text> : null
					}
				</View>
			</View>
		) : (
			null
		)
		return contentView
	}
}

const styles = StyleSheet.create({
	container: {
		width: Dimensions.get('window').width,
		height: Dimensions.get('window').height,
		justifyContent: 'center',
		paddingLeft: Dimensions.get('window').width / 4,
		paddingRight: Dimensions.get('window').width / 4,
		// backgroundColor: 'rgba(0, 0, 0, 0.5)',
		backgroundColor: 'transparent',
		flexDirection: 'column',
		position: 'absolute',
		top: 0,
		right: 0,
		left: 0,
		bottom: 0
	},
	backgroud: {
		height: Dimensions.get('window').height / 6,
		borderRadius: 5,
		flexDirection: 'column',
		justifyContent: 'center',
		backgroundColor: 'rgba(0, 0, 0, 0.8)'

	},
	loadingText: {
		marginTop: 10,
		textAlign: 'center',
		color: '#ffffff'
	}
});