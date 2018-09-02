import React, { Component } from 'react';
import {
	CameraRoll,
	Platform,
	StyleSheet,
	View,
	Text,
	ListView,
	ActivityIndicator,
	NativeModules
} from 'react-native';
import ImageItem from './ImageItem';
import Alert from '../../components/Alert';
import { RatiocalWidth, RatiocalHeight, AppSizes, General, AppColors } from './../../style';
const MyImageModule = Platform.OS === 'android' ? NativeModules.MyImageModule : null;
class CameraRollPicker extends Component {
	constructor (props) {
		super(props);

		this.state = {
			maxNum: 0,
			images: [],
			selected: this.props.selected,
			lastCursor: null,
			loadingMore: false,
			noMore: false,
			dataSource: new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 !== r2 })
		};
	}

	componentWillMount () {
		this.fetch();
	}

	componentWillReceiveProps (nextProps) {
		this.setState({
			selected: nextProps.selected
		});
	}

	fetch () {
		if (!this.state.loadingMore) {
			this.setState({ loadingMore: true }, () => { this._fetch(); });
		}
	}

	_fetch () {
		let { groupTypes, assetType } = this.props;

		let fetchParams = {
			first: 2 * 10, // 每页加载30张
			groupTypes: groupTypes,
			assetType: assetType
		};

		if (Platform.OS === 'android') {
			// not supported in android
			delete fetchParams.groupTypes;
		}

		if (this.state.lastCursor) {
			fetchParams.after = this.state.lastCursor;
		}

		CameraRoll.getPhotos(fetchParams)
			.then(data => this._appendImages(data));
	}

	_appendImages (data) {
		let assets = data.edges;
		let newState = {
			loadingMore: false
		};

		if (!data.page_info.has_next_page) {
			newState.noMore = true;
		}

		if (assets.length > 0) {
			// 安卓目录下的照片,进行地址替换
			if (Platform.OS === 'android') {
				assets.map((val, i) => {
					if (assets[i].node.image.uri.indexOf('file://') < 0) {
						MyImageModule.getRealPathFromUri(assets[i].node.image.uri,
							(result, state) => {
								if (state === 'true') {
									assets[i].node.image.uri = result;
								}
							}, errorResult => {

							});
					}
				});
			}
			newState.lastCursor = data.page_info.end_cursor;
			newState.images = this.state.images.concat(assets);
			newState.dataSource = this.state.dataSource.cloneWithRows(
				this._nEveryRow(newState.images, this.props.imagesPerRow)
			);
		}

		this.fetchTimer = setTimeout(() => {
			this.setState(newState);
		}, 500);
	}

	render () {
		let { dataSource } = this.state;
		let {
			scrollRenderAheadDistance,
			initialListSize,
			pageSize,
			removeClippedSubviews,
			imageMargin,
			backgroundColor,
			emptyText,
			emptyTextStyle
		} = this.props;

		let listViewOrEmptyText = dataSource.getRowCount() > 0 ? (
			<ListView
				style={{ flex: 1 }}
				scrollRenderAheadDistance={scrollRenderAheadDistance}
				initialListSize={initialListSize}
				pageSize={pageSize}
				removeClippedSubviews={removeClippedSubviews}
				renderFooter={this._renderFooterSpinner.bind(this)}
				onEndReached={this._onEndReached.bind(this)}
				dataSource={dataSource}
				renderRow={rowData => this._renderRow(rowData)}/>
		) : (
			<Text style={[{ textAlign: 'center' }, emptyTextStyle]}>{emptyText}</Text>
		);

		return (
			<View
				style={[styles.wrapper, { padding: imageMargin, paddingRight: 0, backgroundColor: backgroundColor }]}>
				{listViewOrEmptyText}
				<Alert
					ref={ref => { this.Alert = ref; }}
					msg={'您最多只能选择' + this.state.maxNum + '张照片'}
					btnTextStyle={{ color: AppColors.mainColor }}
				/>
			</View>
		);
	}

	_renderImage (item) {
		let { selected } = this.state;
		let {
			imageMargin,
			selectedMarker,
			defaultMarker,
			imagesPerRow,
			containerWidth
		} = this.props;

		let uri = item.node.image.uri;
		let isSelected = (this._arrayObjectIndexOf(selected, 'uri', uri) >= 0);

		return (
			<ImageItem
				key={uri}
				item={item}
				selected={isSelected}
				imageMargin={imageMargin}
				selectedMarker={selectedMarker}
				defaultMarker={defaultMarker}
				imagesPerRow={imagesPerRow}
				containerWidth={containerWidth}
				onClick={this._selectImage.bind(this)}
				clickItem={this._previewImage.bind(this)}
			/>
		);
	}

	_renderRow (rowData) {
		let items = rowData.map(item => {
			if (item === null) {
				return null;
			}
			return this._renderImage(item);
		});

		return (
			<View style={styles.row}>
				{items}
			</View>
		);
	}

	_renderFooterSpinner () {
		if (!this.state.noMore) {
			return <ActivityIndicator size={'large'} color={'#FF783B'}/>;
		}
		return null;
	}

	_onEndReached () {
		if (!this.state.noMore) {
			this.fetch();
		}
	}

	_selectImage (image) {
		let { maximum, imagesPerRow, callback } = this.props;
		let selected = this.state.selected;
		let index = this._arrayObjectIndexOf(selected, 'uri', image.uri);
		if (index >= 0) {
			selected.splice(index, 1);
		} else {
			if (selected.length < maximum) {
				selected.push(image);
			} else {
				this.setState({
					maxNum: maximum
				})
				this.Alert.show();
			}
		}
		this.setState({
			selected: selected,
			dataSource: this.state.dataSource.cloneWithRows(
				this._nEveryRow(this.state.images, imagesPerRow)
			)
		});

		callback(this.state.selected, image);
	}

	_previewImage (image) {
		let { callbackPreview } = this.props;
		callbackPreview(image.uri);
	}

	_nEveryRow (data, n) {
		let result = [],
			temp = [];

		for (let i = 0; i < data.length; ++i) {
			if (i > 0 && i % n === 0) {
				result.push(temp);
				temp = [];
			}
			temp.push(data[i]);
		}

		if (temp.length > 0) {
			while (temp.length !== n) {
				temp.push(null);
			}
			result.push(temp);
		}

		return result;
	}

	_arrayObjectIndexOf (array, property, value) {
		return array.map(o => { return o[property]; }).indexOf(value);
	}
}

const styles = StyleSheet.create({
	wrapper: {
		height: AppSizes.height - RatiocalHeight(228)
	},
	row: {
		flexDirection: 'row',
		flex: 1
	},
	marker: {
		position: 'absolute',
		top: 5,
		backgroundColor: 'transparent'
	}
})

CameraRollPicker.propTypes = {
	scrollRenderAheadDistance: React.PropTypes.number,
	initialListSize: React.PropTypes.number,
	pageSize: React.PropTypes.number,
	removeClippedSubviews: React.PropTypes.bool,
	groupTypes: React.PropTypes.oneOf([
		'Album',
		'All',
		'Event',
		'Faces',
		'Library',
		'PhotoStream',
		'SavedPhotos'
	]),
	maximum: React.PropTypes.number,
	assetType: React.PropTypes.oneOf([
		'Photos',
		'Videos',
		'All'
	]),
	imagesPerRow: React.PropTypes.number,
	imageMargin: React.PropTypes.number,
	containerWidth: React.PropTypes.number,
	callback: React.PropTypes.func,
	selected: React.PropTypes.array,
	selectedMarker: React.PropTypes.any,
	defaultMarker: React.PropTypes.any,
	backgroundColor: React.PropTypes.string,
	emptyText: React.PropTypes.string,
	emptyTextStyle: Text.propTypes.style,
	callbackPreview: React.PropTypes.func
}

CameraRollPicker.defaultProps = {
	scrollRenderAheadDistance: 500,
	initialListSize: 0,
	pageSize: 3,
	removeClippedSubviews: true,
	groupTypes: 'SavedPhotos',
	maximum: 15,
	imagesPerRow: 3,
	imageMargin: 5,
	assetType: 'Photos',
	backgroundColor: 'white',
	selected: [],
	callback: function (selectedImages, currentImage) {
	},
	callbackPreview: function (uri) {
	},
	emptyText: '暂无照片..'
};

export default CameraRollPicker;