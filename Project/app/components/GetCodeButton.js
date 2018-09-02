'use strict';
import React, {
	Component
} from 'react';
import {
	StyleSheet
} from 'react-native';
import { AppColors, RatiocalHeight, RatiocalWidth, RatiocalFontSize } from '../style';
import ButtonHighlight from '../components/ButtonHighlight';

export default class GetCodeButton extends Component {
	constructor (props) {
		super(props);
		const { title } = this.props;
		this.state = {
			title: title,
			disable: true
		}
	}

	countDown = () => {
		this.setState({
			title: '60S',
			disable: true
		});
		let timerCount = 60;
		this.interval = setInterval(() => {
			timerCount = timerCount - 1;
			if (timerCount === 0) {
				this.interval && clearInterval(this.interval);
				this.interval = null;
				this.setState({
					title: '重新获取',
					disable: false
				}, () => {
					this.btn.enable();
				})
			} else {
				this.setState({
					title: timerCount + 'S'
				})
			}
		}, 1000)
	};

	_reStart = () => {
		this.interval && clearInterval(this.interval);
		this.interval = null;
		this.setState({
			title: '重新获取',
			disable: false
		}, () => {
			this.btn.enable();
		})
	};

	// 可点击事件
	canClick () {
		console.log('可点击')
		this.setState({
			disable: false
		}, () => {
			this.btn.enable();
		})
	}

	// 不可点击事件
	unCanClick () {
		console.log('不可点击')
		this.setState({
			disable: true
		});
	}

	componentWillUnmount () {
		this.interval && clearInterval(this.interval);
		this.interval = null;
	}

	render () {
		return (
			<ButtonHighlight
				ref={ref => { this.btn = ref }}
				title={this.state.title}
				onPress={enable => this.props.onPress(enable)}
				buttonStyle={[styles.ContainerStyle, this.props.buttonStyle]}
				titleStyle={[styles.TitleStyle]}
				disabled={this.state.disable && this.props.disabled}
			/>
		)
	}
}

const styles = StyleSheet.create({
	ContainerStyle: {
		height: RatiocalHeight(54),
		width: RatiocalWidth(150)
	},
	TitleStyle: {
		fontSize: RatiocalFontSize(24)
	}
});