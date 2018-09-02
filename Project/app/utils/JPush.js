'use strict';
import React from 'react';
import {
	Platform,
	DeviceEventEmitter
} from 'react-native';

import { SaveJpush } from '../actions/BaseAction';
import JPushModule from 'jpush-react-native';

export default class JPush {
	// 初始化
	static init (dispatch) {
		if (Platform.OS === 'android') {
			// 安卓初始化
			JPushModule.initPush();

			JPushModule.notifyJSDidLoad(() => {
				// 接受到推送消息
				JPushModule.addReceiveNotificationListener(message => {
					console.log('receive notification: ' + JSON.stringify(message));
				});
				// 点击通知栏消息
				JPushModule.addReceiveOpenNotificationListener(msg => {
					// 自定义点击通知后打开某个 Activity，比如跳转到 pushActivity
					// 测试跳转到登录页面
					// 要跳到指定界面的话，要改一下 Android 的代码，在 JPushModule 中去掉 258行到271行的代码，也就是去掉点击通知时，默认跳转到启动 App 部分的代码。
					// let extra = msg['cn.jpush.android.EXTRA'];
					// let message = JSON.parse(extra);
					// console.log("Opening notification extra: " + JSON.stringify(message));
					// if (message.name === 'login') {
					//     this._openLogin(message.name);
					// }
					console.log('Opening notification!', msg);
					console.log('Opening notification!', JSON.stringify(msg));
					let ExtraData = JSON.parse(msg.extras);
					console.log('%o', ExtraData);
					console.log('o%', ExtraData);
					if (ExtraData) {
						if (ExtraData.ExtraData) {
							DeviceEventEmitter.emit('JPush', JSON.parse(ExtraData.ExtraData))
						}
					}
				});
			});

			// 得到安卓的推送id
			JPushModule.getRegistrationID(registrationid => {
				console.log(registrationid);
				dispatch(SaveJpush({ jPushId: registrationid }))
			});
			// 设置推送的事件监听
			JPushModule.addReceiveCustomMsgListener(message => {
				console.log('pushMsg: ' + JSON.stringify(message));
			});
		} else {
			// 初始化推送
			JPushModule.getRegistrationID(registrationid => {
				console.log(registrationid);
				dispatch(SaveJpush({ jPushId: registrationid }))
			});
			// 接受到推送消息
			JPushModule.addReceiveNotificationListener(message => {
				console.log('receive notification: ' + JSON.stringify(message));
			});
			// 点击通知栏消息
			JPushModule.addReceiveOpenNotificationListener(msg => {
				console.log('Opening notification!' + msg);
				console.log('Opening notification!' + JSON.stringify(msg));
				if (msg.ExtraData) {
					if (msg.ExtraData) {
						DeviceEventEmitter.emit('JPush', JSON.parse(msg.ExtraData))
					}
				}
			});
		}
	}

	static remove () {
		JPushModule.removeReceiveCustomMsgListener();
		JPushModule.removeReceiveNotificationListener();
	}
}