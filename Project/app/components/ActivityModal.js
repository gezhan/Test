'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Image,
	StyleSheet,
	TouchableOpacity
} from 'react-native';
import Jump from '../utils/Jump'
import { RatiocalWidth, RatiocalHeight, AppSizes } from '../style';

export default class ActivityModal extends Component {
	constructor (props) {
		super(props);
		this.state = {};
	}

	_go = () => {
		const { isVisible, imgSrc, url, closeAction } = this.props;
		if (url) {
			closeAction && closeAction();
			Jump.go('JSWebView', {
				url: this.props.url,
				title: this.props.activityTitle,
				isEncrypt: true,
				isPopTop: true
				// rightTitle: '联系客服'
			})
		}
	};

	render () {
		const { isVisible, imgSrc, url, closeAction } = this.props;
		return (
			isVisible &&
			<View style={styles.Model}>
				<View>
					<TouchableOpacity activeOpacity={1} onPress={this._go}>
						<Image style={styles.wrapper} resizeMode={'cover'} source={{ uri: imgSrc }}/>
					</TouchableOpacity>
					<TouchableOpacity style={styles.close} onPress={() => { !!closeAction && closeAction() }}>
						<Image source={require('../images/notice_close.png')} resizeMode={'contain'} style={styles.closeImg}/>
					</TouchableOpacity>
				</View>
			</View>
		)
	}
}

const styles = StyleSheet.create({
	Model: {
		position: 'absolute',
		width: AppSizes.width,
		height: AppSizes.height,
		top: 0,
		left: 0,
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		overflow: 'hidden',
		justifyContent: 'center',
		alignItems: 'center'
	},
	close: {
		position: 'absolute',
		right: RatiocalWidth(-25),
		top: RatiocalWidth(-25),
		width: RatiocalWidth(50),
		height: RatiocalWidth(50)
	},
	wrapper: {
		width: RatiocalWidth(530),
		height: RatiocalHeight(700)
	},
	contentImg: {
		width: RatiocalWidth(530),
		height: RatiocalHeight(700)
	},
	closeImg: {
		width: RatiocalWidth(50),
		height: RatiocalWidth(50)
	}
});