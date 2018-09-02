'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	Linking,
	StyleSheet
} from 'react-native';
// redux
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Jump, FunctionUtils, toastShort } from '../../config';
import { UpdateAuth } from '../../actions/AuthAction'
import NavigationBar from '../../components/NavBarCommon';
import ButtonHighlight from '../../components/ButtonHighlight';
import Loading from '../../components/Loading'
import { RatiocalWidth, RatiocalHeight, AppColors, General, AppFonts } from '../../style';

@connect(
	null,
	dispatch => ({
		dispatch,
		...bindActionCreators({ UpdateAuth }, dispatch)
	})
)
export default class ZmAuth extends Component {
	constructor (props) {
		super(props);
		this.state = {
			isZmAuth: 0
		};
	}

	componentWillUnmount () {
		this.props.updateAuth();
	}

	auth = enable => {
		this.loading.show()
		FunctionUtils.isAlipayInstall(isAlipayInstall => {
			if (isAlipayInstall) {
				this.loading.hide();
				Linking.openURL(this.props.url).catch(err => {
					console.log('An error occurred', err);
				});
				this.props.UpdateAuth({
					IsZmAuth: 9
				});
				this.setState({
					isZmAuth: 1
				})
			} else {
				this.loading.hide();
				toastShort('请先安装支付宝App');
				enable();
			}
		})
	}

	render () {
		return (
			<View style={General.wrapViewWhite}>
				<NavigationBar
					title={'芝麻信用授权'}
					leftAction={() => { Jump.back(); }}
				/>
				<View style={styles.topView}>
					<Image
						source={require('../../images/Auth_Zhima.png')}
						style={{
							height: RatiocalHeight(100),
							width: RatiocalWidth(240),
							marginBottom: RatiocalHeight(80),
							resizeMode: 'contain'
						}}/>
					<Text
						style={styles.imgText}>
						请点击按钮授权您的芝麻信用
					</Text>
				</View>
				<View style={General.container}>
					<ButtonHighlight
						title={this.state.isZmAuth === 0 ? '未授权' : '认证中'}
						disabled={!(this.state.isZmAuth === 0)}
						onPress={enable => this.auth(enable)}
					/>
				</View>
				<View style={styles.buttonBottom}>
					<Image source={require('../../images/Common_Safe.png')}/>
					<Text style={styles.textContact}>银行级数据加密防护</Text>
				</View>
				<Loading ref={ref => { this.loading = ref }}/>
			</View>
		);
	}
}
export const styles = StyleSheet.create({
	textContact: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_26,
		textAlign: 'center',
		marginLeft: RatiocalWidth(20)
	},
	buttonBottom: {
		marginTop: RatiocalHeight(20),
		height: RatiocalHeight(40),
		flexDirection: 'row',
		alignItems: 'center',
		justifyContent: 'center'
	},
	topView: {
		alignItems: 'center',
		justifyContent: 'center',
		marginTop: RatiocalHeight(200),
		marginBottom: RatiocalHeight(90)
	},
	cellView1: {
		height: RatiocalHeight(100),
		alignItems: 'center',
		marginLeft: RatiocalWidth(30),
		flexDirection: 'row',
		justifyContent: 'space-between'
	},
	lineView: {
		height: RatiocalHeight(2),
		backgroundColor: AppColors.grayBg,
		marginLeft: RatiocalWidth(35)
	},
	imgText: {
		marginTop: RatiocalHeight(20),
		color: '#B3B2B3',
		fontSize: AppFonts.text_size_28
	}
});