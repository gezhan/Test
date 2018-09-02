'use strict';
import React from 'react';
import {
	DeviceEventEmitter,
	InteractionManager
} from 'react-native';
import { Navigator } from 'react-native-deprecated-custom-components';

export default class Jump {
	constructor (props) {
		console.log(props);
		this.navigator = null;
	}

	static setNavigator (navigator) {
		this.navigator = navigator;
	}

	// 页面前进
	static go (path, params, guestures = Navigator.SceneConfigs.FloatFromRight.gestures) {
		console.log(`path: ${path}`);
		console.log(params);
		// InteractionManager.runAfterInteractions(() => {
		this.navigator.push({
			name: path,
			guestures: guestures,
			params: params
		});
		// });
	}

	// 页面后退
	static back (path) {
		if (path) {
			let destinationRoute = this.findRoute(path);
			InteractionManager.runAfterInteractions(() => {
				if (destinationRoute) {
					this.navigator.popToRoute(destinationRoute);
				} else {
					this.navigator.pop();
				}
			});
		} else {
			InteractionManager.runAfterInteractions(() => {
				this.navigator.pop();
			});
		}
	}

	// 页面后退
	static backToTop (path, params) {
		if (params) {
			params['path'] = path;
		} else {
			params = path;
		}
		DeviceEventEmitter.emit('changTab', params);
		InteractionManager.runAfterInteractions(() => {
			this.navigator.popToTop();
		});
	}

	// 获取想要的route
	static findRoute (routeName) {
		let routes = this.navigator.state.routeStack;
		let destinationRoute = '';
		for (let i = routes.length - 1; i >= 0; i--) {
			if (routes[i].name === routeName) {
				destinationRoute = this.navigator.getCurrentRoutes()[i];
				return destinationRoute;
			}
		}
		return destinationRoute;
	}

	static getRoutes () {
		return this.navigator.state.routeStack;
	}
}