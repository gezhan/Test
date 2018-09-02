'use strict';
import React, {
	Component
} from 'react';
import {
	View,
	Text,
	ListView,
	Platform
} from 'react-native';
// redux
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
// actions
import { FetchCenter } from '../../actions/BaseAction';
// views
import Loading from '../../components/Loading';
// styles
import MessageCenterStyle from './style/MessageCenterStyle';
import { General } from '../../style';
import NavBarCommon from '../../components/NavBarCommon'
// utils
import {
	Types,
	HttpRequest,
	Url,
	FunctionUtils,
	Jump,
	toastShort
} from '../../config';

@connect(
	null,
	dispatch => ({
		dispatch,
		...bindActionCreators({ FetchCenter }, dispatch)
	})
)
export default class MessageCenter extends Component {
	constructor (props) {
		super(props);
		let ds = new ListView.DataSource({
			rowHasChanged: (r1, r2) => r1 !== r2
		});
		this.state = {
			dataSource: ds,
			data: []
		};
	}

	componentDidMount () {
		this.loading && this.loading.show();
		HttpRequest.request(Types.POST, Url.POST_MESSAGE)
			.then(responseData => {
				this.loading && this.loading.hide();
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.setState({ data: responseData.MessageList });
							break;
						case 408:
							FunctionUtils.loginOut(responseData.Msg);
							break;
						default:
							responseData.Msg && toastShort(responseData.Msg);
							break;
					}
				}
			})
			.catch(error => {
				this.loading && this.loading.hide();
				console.log('error', error);
			});
	}

	componentWillUnmount () {
		this.props.FetchCenter();
	}

	_renderRow = (rowData, sectionID, rowID) => {
		return (
			<View style={ MessageCenterStyle.card }>
				<View style={ MessageCenterStyle.cardHeader }>
					<Text style={ MessageCenterStyle.title }>{rowData.Title}</Text>
					<Text style={ MessageCenterStyle.createTime }>{rowData.CreateTime}</Text>
				</View>
				<View style={ MessageCenterStyle.desWrap }>
					<Text
						style={ [MessageCenterStyle.des, Platform.OS === 'ios' && MessageCenterStyle.isIosLineHeight]}>{rowData.Content}</Text>
				</View>
			</View>
		);
	};

	render () {
		return (
			<View style={General.wrapViewGray}>
				<NavBarCommon
					title={'消息中心'}
					leftAction={() => Jump.back()}
				/>
				<ListView
					style={{ flex: 1 }}
					dataSource={this.state.dataSource.cloneWithRows(this.state.data)}
					renderRow={this._renderRow}
					enableEmptySections={true}
				/>
				<Loading ref={ref => { this.loading = ref; }}/>
			</View>
		);
	}
}