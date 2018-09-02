import React, { Component } from 'react';
import {
	Image,
	StyleSheet,
	Dimensions,
	TouchableOpacity
} from 'react-native';

class ImageItem extends Component {
	componentWillMount () {
		let { width } = Dimensions.get('window');
		let { imageMargin, imagesPerRow, containerWidth } = this.props;

		if (typeof containerWidth !== 'undefined') {
			width = containerWidth;
		}
		this._imageSize = (width - (imagesPerRow + 1) * imageMargin) / imagesPerRow;
	}

	_renderMarkView (res) {
		let { item } = this.props;
		let image = item.node.image;
		return (
			<TouchableOpacity style={styles.marker} onPress={() => this._handleClick(image)}>
				<Image
					style={{ width: 20, height: 20 }}
					source={res}
				/>
			</TouchableOpacity>
		);
	}

	render () {
		let { item, selected, selectedMarker, defaultMarker, imageMargin } = this.props;

		let marker = selectedMarker ? this._renderMarkView(selectedMarker) : this._renderMarkView(require('./circle-check.png'));
		let defaultmarker = defaultMarker ? this._renderMarkView(defaultMarker) : this._renderMarkView(require('./circle-check.png'));
		let image = item.node.image;

		return (
			<TouchableOpacity
				style={{ marginBottom: imageMargin, marginRight: imageMargin }}
				onPress={() => this._handleClick(image)}>
				<Image
					source={{ uri: image.uri }}
					style={{ height: this._imageSize, width: this._imageSize }} >
					{selected === true ? marker : defaultmarker}
				</Image>
			</TouchableOpacity>
		);
	}

	_handleClick (item) {
		this.props.onClick(item);
	}

	_handleClickItem (item) {
		this.props.clickItem(item);
	}
}

const styles = StyleSheet.create({
	marker: {
		backgroundColor: 'transparent',
		position: 'absolute',
		top: 0,
		right: 0,
		width: 40,
		height: 40,
		alignItems: 'flex-end'
	}
})

ImageItem.defaultProps = {
	item: {},
	selected: false
}

ImageItem.propTypes = {
	item: React.PropTypes.object,
	selected: React.PropTypes.bool,
	imageMargin: React.PropTypes.number,
	imagesPerRow: React.PropTypes.number,
	selectedMarker: React.PropTypes.any,
	defaultMarker: React.PropTypes.any,
	onClick: React.PropTypes.func
}

export default ImageItem;