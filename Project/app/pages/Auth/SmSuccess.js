'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Image,
	StatusBar,
	Platform,
	StyleSheet
} from 'react-native';
import { connect } from 'react-redux';
import {
	Types,
	Jump
} from '../../config'
import NavigationBar from '../../components/NavBarCommon';
import { RatiocalWidth, RatiocalHeight, AppColors, General, AppFonts, AppSizes } from '../../style';

@connect(
	state => ({
		Sm: state.authInfo.Sm
	})
)
export default class SmSuccess extends Component {
	constructor (props) {
		super(props);
		this.state = {};
	}

	render () {
		const { Sm } = this.props;
		let cdCard = (Sm.IdCard.substring(0, 3) + '************' + Sm.IdCard.substring(Sm.IdCard.length - 4, Sm.IdCard.length));
		return (
			<View style={General.wrapViewGray}>
				<StatusBar barStyle={'default'}/>
				<NavigationBar
					title={'实名认证'}
					leftAction={() => { Jump.back(); }}
				/>
				<View style={styles.parent}>
					<View style={styles.topView}>
						<Image source={require('../../images/SM_Success.png')} style={styles.topViewImg}/>
						<Text style={styles.imgText}>您的身份证认证成功</Text>
					</View>
					<View style={{
						backgroundColor: AppColors.grayBorder,
						height: AppSizes.pixelRatioWidth,
						marginHorizontal: RatiocalWidth(60)
					}}/>
					<View style={[styles.cellView, { marginTop: RatiocalHeight(54) }]}>
						<Text style={styles.cellText}>{'姓        名:'}</Text>
						<Text style={styles.cellTextValue}>{Sm.VerifyRealName}</Text>
					</View>
					<View style={[styles.cellView, { marginTop: RatiocalHeight(26), marginBottom: RatiocalHeight(60) }]}>
						<Text style={styles.cellText}>身份证号:</Text>
						<Text style={styles.cellTextValue}>{cdCard}</Text>
					</View>
				</View>
			</View>
		);
	}
}
export const styles = StyleSheet.create({
	parent: {
		backgroundColor: 'white',
		marginTop: RatiocalHeight(30)
	},
	topView: {
		alignItems: 'center',
		justifyContent: 'center',
		marginTop: RatiocalHeight(160),
		marginBottom: RatiocalHeight(50)
	},
	topViewImg: {
		width: RatiocalWidth(200),
		height: RatiocalHeight(140),
		resizeMode: 'contain'
	},
	imgText: {
		height: RatiocalHeight(50),
		marginTop: RatiocalHeight(26),
		fontWeight: 'bold',
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_32,
		textAlign: 'center',
		textAlignVertical: 'center'
	},
	cellView: {
		flexDirection: 'row',
		alignItems: 'center',
		marginLeft: RatiocalWidth(143),
		marginRight: RatiocalWidth(99)
	},
	cellText: {
		width: RatiocalWidth(146),
		fontSize: AppFonts.text_size_28,
		color: AppColors.lightBlackColor
	},
	cellTextValue: {
		fontSize: AppFonts.text_size_28,
		color: AppColors.grayColor,
		marginLeft: RatiocalWidth(22)
	}
})