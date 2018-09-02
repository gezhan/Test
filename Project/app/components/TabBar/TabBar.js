/**
 *  TabBar
 */
'use strict';

import {
	StyleSheet,
	View,
	Image,
	Text,
	Dimensions,
	DeviceEventEmitter,
	TouchableHighlight
} from 'react-native';
import React, { Component } from 'react';

import TabBarItem from './TabBarItem';
import { AppSizes, RatiocalHeight, RatiocalFontSize } from '../../style';

export default class TabBar extends Component {
	static Item = TabBarItem;

	static defaultProps = {
		defaultPage: 0,
		navFontSize: RatiocalFontSize(20),
		navTextColor: 'black',
		navTextColorSelected: '#FF9100'
	};

	static propTypes = {
		...View.propTypes,
		style: View.propTypes.style,
		defaultPage: React.PropTypes.number,
		navFontSize: React.PropTypes.number,
		navTextColor: React.PropTypes.string,
		navTextColorSelected: React.PropTypes.string,
		onItemSelected: React.PropTypes.func
	};

	constructor (props) {
		super(props);
		this.visibles = [];
		this.state = {
			selectedIndex: 0,
			loaded: false
		};
	}

	componentWillUnmount () {
		!!this.loadFinishListener && this.loadFinishListener.remove();
		this.loadFinishListener = null;
	}

	componentWillReceiveProps (nextProps) {
		console.log('componentWillReceiveProps');
		if (nextProps.defaultPage !== this.state.selectedIndex) {
			if (this.props.isReal === false && nextProps.defaultPage === 2) {
				this.update(1);
			} else {
				this.update(nextProps.defaultPage);
			}
		}
	}

	getBadge (child) {
		let value = 0;
		if (typeof child.props.badge === 'number') {
			value = child.props.badge;
		}

		if (child.props.badge || value !== 0) {
			const _badgeStyle = (typeof child.props.badge === 'number') ? styles.badgeWithNumber : styles.badgeNoNumber;

			let valueStr = '';
			if (value > 99) {
				valueStr = 99;
			} else {
				valueStr = child.props.badge;
			}

			return (
				<View style={[_badgeStyle, this.props.badgeStyle]}>
					<Text style={styles.badgeText}>{valueStr}</Text>
				</View>
			);
		}
	}

	// 放大按钮
	_stressPoint (child) {
		return child.props.point;
	}

	render () {
		let children = this.props.children;
		if (!children.length) {
			throw new Error('at least two child component are needed.');
		}

		// 底部tab按钮组
		let navs = [];

		const contentViews = children.map(
			(child, i) => {
				if (child) {
					const imgSrc = this.state.selectedIndex === i ? child.props.selectedIcon : child.props.icon;
					const color = this.state.selectedIndex === i ? this.props.navTextColorSelected : this.props.navTextColor;

					navs[i] = (
						<TouchableHighlight
							key={i}
							underlayColor={'transparent'}
							style={styles.navItem}
							onPress={() => {
								if (child.props.onPress) {
									child.props.onPress(this.update);
								} else {
									this.update(i);
								}
							}}>
							<View style={{ alignItems: 'center' }}>
								<Image
									style={[styles.navImage, this._stressPoint(child) ? styles.navImageChange : undefined]}
									resizeMode="contain" source={imgSrc}/>
								<Text style={[styles.navText, {
									color: color,
									fontSize: this.props.navFontSize
								}, this._stressPoint(child) ? styles.navTextChange : '']}>
									{child.props.title}
								</Text>
								{this.getBadge(child)}
							</View>
						</TouchableHighlight>
					);

					if (!this.visibles[i]) {
						return null;
					} else {
						const style = this.state.selectedIndex === i ? styles.base : [styles.base, styles.gone];
						return (
							<View
								key={'view_' + i}
								style={style}>
								{child}
							</View>
						);
					}
				} else {
					return null;
				}
			}
		);

		return (
			<View
				style={[styles.container, AppSizes.height === 812 && { marginBottom: 34 }, this.props.style]}
				onStartShouldSetResponderCapture={evt => this.state.loaded}>
				<View style={styles.content}>
					{contentViews}
				</View>

				<View style={styles.horizonLine}/>

				<View style={styles.nav}>
					{navs}
				</View>
			</View>
		);
	}

	componentDidMount () {
		let page = this.props.defaultPage;

		if (page >= this.props.children.length || page < 0) {
			page = 0;
		}

		this.update(page);
	}

	update = index => {
		this.visibles[index] = true;
		this.setState({
			selectedIndex: index
		});

		if (this.props.onItemSelected) {
			this.props.onItemSelected(index);
		}
	};
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		width: Dimensions.get('window').width,
		overflow: 'hidden',
		height: RatiocalHeight(98)
	},
	content: {
		flex: 1
	},
	base: {
		position: 'absolute',
		overflow: 'hidden',
		left: 0,
		right: 0,
		top: 0,
		bottom: 0
	},
	gone: {
		top: Dimensions.get('window').height,
		bottom: -Dimensions.get('window').height
	},
	nav: {
		flexDirection: 'row',
		width: Dimensions.get('window').width,
		backgroundColor: '#fff'
	},
	navItem: {
		flex: 1,
		height: RatiocalHeight(98),
		alignItems: 'center',
		justifyContent: 'center'
	},
	center: {
		alignItems: 'center',
		justifyContent: 'center'
	},
	navImage: {
		width: RatiocalHeight(40),
		height: RatiocalHeight(40),
		marginTop: RatiocalHeight(18)
	},
	navImageChange: {
		top: -28,
		width: 49,
		height: 49,
		marginBottom: 2,
		position: 'absolute',
		borderRadius: 28,
		borderWidth: 3,
		borderColor: '#fff',
		alignSelf: 'center'
	},
	navTextChange: {
		marginTop: 30,
		fontSize: 11,
		alignSelf: 'center'
	},
	navText: {
		alignSelf: 'center',
		marginTop: RatiocalHeight(6),
		marginBottom: RatiocalHeight(6),
		includeFontPadding: false,
		height: RatiocalHeight(28)
		// lineHeight: parseInt(RatiocalHeight(24)),
		// textAlignVertical: 'center',
	},
	horizonLine: {
		backgroundColor: '#e5e5e5',
		height: 1,
		width: Dimensions.get('window').width
	},
	badgeNoNumber: {
		flexDirection: 'row',
		justifyContent: 'center',
		top: -2,
		left: 36,
		position: 'absolute',
		width: 10,
		height: 10,
		borderRadius: 10,
		borderWidth: 1,
		alignItems: 'center',
		borderColor: '#ffffff',
		backgroundColor: '#ff0000'
	},
	badgeWithNumber: {
		flexDirection: 'row',
		justifyContent: 'center',
		top: -4,
		left: 36,
		position: 'absolute',
		width: 20,
		height: 20,
		borderRadius: 10,
		borderWidth: 1,
		borderColor: '#ffffff',
		backgroundColor: '#ff0000'
	},
	badgeText: {
		alignSelf: 'center',
		fontSize: 4,
		color: '#ffffff',
		backgroundColor: 'transparent'
	}
});