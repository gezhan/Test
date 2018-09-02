import React, { Component, PropTypes } from 'react';
import { View, Animated, Easing, TouchableOpacity } from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, General, AppSizes } from '../style';
// 使用说明，因使用双层View嵌套布局
// 在 iOS 平台上，当使用 View 组件来包裹子组件的时候，如果没有显示设置父级 View 组件的宽度（width 样式）
// (比如用 flex 布局)，那么父级 View 组件的宽度会被自动设置成子组件的宽度。(至少当子组件比父组件宽度大时是这样的)

// 跑马灯组件中的问题在于，我用了一个子级 View 组件来包裹 Text 组件以保证文字是在一行全部显示。
// 通过将 text container 的宽度设置得比 Text 组件宽度大，保证了文字不会换行，也不会用省略号替换溢出文字。
// text container 默认宽度为 1000，这比一般的跑马灯标签实际宽度要大。而这也就导致了上述的问题，最外层的 View 的宽度也变成了 1000。
// 在 Android 平台上，通过 width 或者 flex 布局来设置最外层 View 的样式都没问题。
// 在 iOS 平台上，请使用并且只能使用 width 来设置样式。

// 使用例子：
// <MarqueeText text={'This is a Marquee Label.'}
// bgViewStyle={{backgroundColor:'black',height:80,width:width}}
// speed={150}
// clickEvent={this.onPress.bind(this)}
// textStyle={{ fontSize:20,color: 'white'}} />

export default class MarqueeText extends Component {
	static propTypes = {
		clickEvent: PropTypes.func
	};

	state = {
		started: false // use state for this variable to make sure that any change would affect UI
	};

	_clickEvent = e => {
		if (this.props.clickEvent) {
			this.props.clickEvent(e);
		}
	};

	componentWillMount () {
		this.animatedTransformX = new Animated.Value(0);
		this.animatedTransformX.addListener(cb => {
			this.continueX = cb.value;
			this.shouldFinish = false;
		});
		this.continueX = -50000;
		this.bgViewWidth = 0;
		this.textWidth = 0;
		this.duration = 0;
		this.initDuration = 0;
		this.endTime = false;
		this.shouldFinish = false;
	}

	componentWillUnmount () {
		this.shouldFinish = true;
	}

	textOnLayout (e) {
		this.textWidth = e.nativeEvent.layout.width;

		if (this.bgViewWidth !== 0) {
			this.prepareToAnimate();
		}
	}

	bgViewOnLayout (e) {
		this.bgViewWidth = e.nativeEvent.layout.width;

		if (this.textWidth !== 0) {
			this.prepareToAnimate();
		}
	}

	prepareToAnimate () {
		this.setState({ started: true });
		// Calculate this.duration by this.props.duration / this.props.speed
		// If this.props.duration is set, discard this.props.speed
		const { duration, speed } = this.props;
		if (duration !== undefined) {
			this.duration = duration;
			this.initDuration = duration;
		} else if (speed !== undefined) {
			this.duration = ((this.bgViewWidth + this.textWidth) / speed) * 10 * 10 * 10;
			this.initDuration = ((this.bgViewWidth + this.textWidth) / speed) * 10 * 10 * 10;
		}
		if (this.textWidth > this.bgViewWidth) {
			this.animate();
		}
	}

	animate = () => {
		console.log(this.continueX);
		console.log(this.continueX !== -50000);
		let dValue = this.endTime ? this.endTime - this.startTime : 0;
		this.startTime = new Date();
		this.duration -= this.endTime ? dValue : 0;
		this.endTime = false;
		this.duration = (this.continueX && this.continueX === -50000) ? this.initDuration : this.duration;
		this.animatedTransformX.setValue((this.continueX && this.continueX !== -50000) ? this.continueX : this.bgViewWidth);
		Animated.timing(this.animatedTransformX, {
			toValue: -this.textWidth,
			duration: Math.abs(this.duration !== this.initDuration ? this.duration : this.initDuration),
			useNativeDriver: true,
			easing: Easing.linear
		}).start(() => {
			if (!this.shouldFinish) {
				this.continueX = -50000;
				this.animate()
			}
		});
	};

	stop = () => {
		this.shouldFinish = true;
		this.endTime = new Date();
		this.animatedTransformX.stopAnimation(value => {

		});
	};

	render () {
		const {
			children,
			text,
			bgViewStyle, // Backgound View Custom Styles
			textStyle, // Text Custom Styles

			// Text Container Width:
			// to make the text shown in one line, this value should be larger than text width
			textContainerWidth = 10000,

			// Text Container Height:
			// to make the text shown in one line, this value should be larger than text height
			// usually increase this value when text has a large font size.
			textContainerHeight = 100,

			textContainerStyle // Text Container Custom Styles, not recommended to use
		} = this.props;
		let dynamicStyle;
		if (this.state.started) {
			dynamicStyle = {
				justifyContent: this.textWidth > this.bgViewWidth ? 'flex-start' : 'flex-start'
			}
		} else {
			dynamicStyle = {
				justifyContent: 'flex-start'
			}
		}
		return (
			<TouchableOpacity activeOpacity={1} onPress={this._clickEvent}>
				<View
					style={[{ ...styles.bgViewStyle }, bgViewStyle, dynamicStyle]}
					onLayout={event => this.bgViewOnLayout(event)}
				>
					<View
						style={[{
							...styles.textContainerStyle,
							width: textContainerWidth,
							height: textContainerHeight,
							opacity: 1,
							...textContainerStyle
						}, dynamicStyle]
						}
					>
						<Animated.Text
							style={[{
								fontSize: RatiocalFontSize(26),
								transform: [{ translateX: this.animatedTransformX }],
								opacity: this.state.started ? 1 : 0
							}, textStyle]}
							onLayout={event => this.textOnLayout(event)}
						>
							{children || text || ' '}
						</Animated.Text>
					</View>
				</View>
			</TouchableOpacity>
		);
	}
}

const styles = {
	bgViewStyle: {
		flexDirection: 'row',
		alignItems: 'center',
		overflow: 'scroll'
	},
	textContainerStyle: {
		flexDirection: 'row',
		alignItems: 'center'
	}
};