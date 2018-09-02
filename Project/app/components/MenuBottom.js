'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	Dimensions,
	TouchableWithoutFeedback,
	TouchableOpacity,
	ListView,
	StyleSheet,
	Platform
} from 'react-native';
import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, General } from '../style/Style';

const {
	width,
	height
} = Dimensions.get('window')

export default class MenuBottom extends Component {
	constructor (props) {
		super(props);
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2
		});
		this.state = {
			dataSource: ds,
			data: this.props.data || []
		};
	}

	componentWillMount () {
		this.setState({
			data: this.props.data
		})
	}

	_renderRow = (rowData, sectionID, rowID) => {
		console.log(rowData)
		return (
			<TouchableOpacity
				onPress={rowData.clickFun}
				style={[General.center, rowID !== parseInt(this.props.data.length - 1) && General.borderBottom,
					{ width: width, height: RatiocalHeight(100) }]}>
				<Text
					style={[rowData.titleStyle, General.smallText, rowID === parseInt(this.props.data.length - 1) && General.biggerText]}>{rowData.title}</Text>
			</TouchableOpacity>
		)
	}

	render () {
		const {
			// RepaymentScheduleId, 借款单号
			// close,		//关闭方法
			// toPay,		//支付方法
			visible,
			close,
			data
		} = this.props
		console.log('visible:' + visible)
		return (
			<TouchableWithoutFeedback onPress={ close }>
				<View style={ visible && Model.model }>
					<ListView
						dataSource={this.state.dataSource.cloneWithRows(data)}
						renderRow={this._renderRow}
						enableEmptySections={true}
						contentContainerStyle={[content.listContainer, { height: RatiocalHeight(100 * data.length) }]}
					/>
				</View>
			</TouchableWithoutFeedback>

		)
	}
}

export const Model = StyleSheet.create({
	model: {
		backgroundColor: 'rgba(0, 0, 0, 0.3)',
		position: 'absolute',
		top: 0,
		left: 0,
		width: width,
		height: height
	}
})
export const content = StyleSheet.create({
	listContainer: {
		position: 'absolute',
		bottom: Platform.OS === 'ios' ? 0 : 30,
		left: 0,
		height: RatiocalHeight(500),
		backgroundColor: '#FFF',
		width: width

	}
})