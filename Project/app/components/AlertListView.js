'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	ListView,
	Modal,
	StyleSheet
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, AppColors, AppFonts, AppSizes, General } from '../style';

export default class AlertListView extends Component {
	constructor (props) {
		super(props);
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2
		});
		this.state = {
			dataSource: ds
		};
	}

	_renderRow = (rowData, sectionID, rowID) => {
		return (
			<View style={ styles.cellWrap }>
				<Text style={ styles.cellText }>{rowData.split('#')[0]}</Text>
				<Text style={ styles.cellText }>{rowData.split('#')[1]}</Text>
			</View>
		)
	};

	render () {
		const { visible, title, listData, footer, animationType, cancelText, cancelTextStyle, cancelAction, containerStyle, backgroudStyle } = this.props;
		let animationType1 = animationType && animationType !== '' ? animationType : 'fade';
		let data = listData || [];
		let top = title || '';
		let bottom = footer || '';
		return (
			<Modal
				animationType={animationType1}
				visible={visible}
				transparent
				onRequestClose={() => { }}
			>
				<View style={ [styles.container, containerStyle] }>
					<View style={ [styles.backgroud, backgroudStyle] }>
						<View style={ styles.topView }>
							<View style={ styles.topWrap }>
								<Text style={ styles.topText }>{top}</Text>
							</View>
							<ListView
								enableEmptySections={true}
								dataSource={this.state.dataSource.cloneWithRows(data)}
								renderRow={this._renderRow}
								contentContainerStyle={ styles.listStyle }

							/>
							<View style={ styles.bottomWrap }>
								<Text style={ styles.bottomText }>{bottom}</Text>
							</View>
						</View>

						<View style={ styles.bottomView }>
							<Text
								style={ [styles.cancelTextStyle, cancelTextStyle] }
								onPress={() => cancelAction()}
								suppressHighlighting={true}>{cancelText} </Text>
						</View>
					</View>
				</View>
			</Modal>
		)
	}
}
const styles = StyleSheet.create({
	container: {
		flexGrow: 1,
		height: AppSizes.height,
		justifyContent: 'center',
		alignItems: 'center',
		paddingHorizontal: AppSizes.width / 4,
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		flexDirection: 'column'
	},
	backgroud: {
		minHeight: RatiocalHeight(234),
		width: RatiocalWidth(500),
		borderRadius: 5,
		backgroundColor: '#F1F1F1',
		flexDirection: 'column',
		marginTop: RatiocalHeight(-200)
	},
	topView: {
		flexGrow: 1,
		flexDirection: 'column',
		justifyContent: 'center',
		alignItems: 'center',
		padding: RatiocalHeight(30),
		paddingBottom: RatiocalHeight(20),
		minHeight: RatiocalHeight(154),
		...General.borderBottom
	},
	topText: {
		color: AppColors.lightBlackColor,
		fontSize: RatiocalFontSize(33)
	},
	listStyle: {
		width: RatiocalWidth(430)
	},
	topWrap: {
		marginBottom: RatiocalHeight(30),
		...General.center
	},
	bottomWrap: {
		width: RatiocalWidth(430),
		marginTop: RatiocalHeight(10)
	},
	bottomText: {
		color: AppColors.grayColor,
		fontSize: AppFonts.text_size_26
	},
	cellWrap: {
		flexDirection: 'row',
		justifyContent: 'space-between',
		alignItems: 'center'
	},
	cellText: {
		color: AppColors.lightBlackColor,
		fontSize: AppFonts.text_size_26
	},
	cancelTextStyle: {
		flex: 1,
		textAlign: 'center',
		fontSize: RatiocalFontSize(33),
		color: AppColors.mainColor
	},
	bottomView: {
		flexGrow: 1,
		height: RatiocalHeight(80),
		width: RatiocalWidth(500),
		flexDirection: 'row',
		...General.center
	}
});