'use strict';
import {
	AsyncStorage
} from 'react-native';
import React, {
	Component
} from 'react';
import { connect } from 'react-redux';
export let GetUserInformation = {
	account: '0',
	jPushId: '',
	uid: 0,
	token: '',
	fingerKey: '',
	loginState: false
};
const ACCOUNT = 'Account';
const JPUSH_ID = 'jPush_id';
const LOGIN_UID_KEY = 'login_uid';
const LOGIN_TOKEN_KEY = 'login_token';
const FINGER_KEY = 'finger_key';
const LOGIN_STATE = 'loginState';
const INIT = 'init_obj';

export class Storage extends Component {
	constructor (props) {
		super(props);
		const { userInfo } = this.props;
	}

	static getInit (callBack) {
		AsyncStorage.multiGet([ACCOUNT, LOGIN_UID_KEY, LOGIN_TOKEN_KEY, FINGER_KEY, LOGIN_STATE, JPUSH_ID], (errs, results) => {
			try {
				for (let i = 0; i < results.length; i++) {
					switch (results[i][0]) {
						case ACCOUNT:
							if (results[i][1] !== null) {
								GetUserInformation.account = results[i][1];
							} else {
								GetUserInformation.account = '0'
							}
							break;
						case LOGIN_UID_KEY:
							if (results[i][1] !== null && results[i][1] !== '') {
								GetUserInformation.uid = parseInt(results[i][1]);
							} else {
								GetUserInformation.uid = 0
							}
							break;
						case LOGIN_TOKEN_KEY:
							if (results[i][1] !== null) {
								GetUserInformation.token = results[i][1];
							} else {
								GetUserInformation.token = ''
							}
							break;
						case FINGER_KEY:
							if (results[i][1] !== null) {
								GetUserInformation.fingerKey = results[i][1];
							} else {
								GetUserInformation.fingerKey = ''
							}
							break;
						case LOGIN_STATE:
							if (results[i][1] !== null && results[i][0] !== '') {
								GetUserInformation.loginState = results[i][1] === 'true';
							}
							break;
						case JPUSH_ID:
							if (results[i][1] !== null) {
								GetUserInformation.jPushId = results[i][1];
							} else {
								GetUserInformation.jPushId = ''
							}
							break;
					}
				}
				callBack && callBack(true);
				console.log('get初始化对象：', results);
				console.log('初始化是否有错：', errs);
				console.log('最终初始化对象：', GetUserInformation);
			} catch (error) {
				callBack && callBack(false);
			}
		});
	}

	// 获取登录状态
	static getLoginState () {
		AsyncStorage.getItem(LOGIN_STATE, () => {
			console.log('trying to get value with key : loginState');
		}).then(value => {
			if (value !== '' && value !== null) {
				GetUserInformation.loginState = String(value);
				console.log('get用户账户：', GetUserInformation.loginState);
			}
		});
	}

	// 设置登录状态
	static setLoginState (loginState) {
		GetUserInformation.loginState = String(loginState);
		console.log('save用户账户：', GetUserInformation.loginState);
		this.saveWithKeyValue(LOGIN_STATE, String(loginState));
	}

	// 获取登录账号
	static getAccount () {
		AsyncStorage.getItem(ACCOUNT, () => {
			console.log('trying to get value with key : Account');
		}).then(value => {
			if (value !== '' && value !== null) {
				GetUserInformation.account = String(value);
				console.log('get用户账户：', GetUserInformation.account);
			}
		});
	}

	// 设置登录账号
	static setAccount (Account) {
		GetUserInformation.account = String(Account);
		console.log('save用户账户：', GetUserInformation.account);
		this.saveWithKeyValue(ACCOUNT, String(Account));
	}

	// 获取JPushId
	static getJPushId (callBack) {
		return AsyncStorage.getItem(JPUSH_ID, () => {
			console.log('trying to get value with key : jPushId', GetUserInformation.jPushId);
		}).then(value => {
			if (value !== '' && value !== null) {
				callBack(true, String(value));
			} else {
				callBack(false);
			}
		});
	}

	// 设置JPushId
	static setJPushId (jPushId) {
		GetUserInformation.jPushId = String(jPushId);
		console.log('save用户jPushId：', GetUserInformation.jPushId);
		this.saveWithKeyValue(JPUSH_ID, String(jPushId));
	}

	// 获取Uid
	static getUid () {
		return AsyncStorage.getItem(LOGIN_UID_KEY, () => {
			console.log('trying to get value with key : Uid');
		}).then(value => {
			if (value !== null) {
				GetUserInformation.uid = parseInt(value);
				console.log('get用户id：', GetUserInformation.uid);
			}
		});
	}

	// 设置Uid
	static setUid (Uid) {
		GetUserInformation.uid = parseInt(Uid);
		console.log('save用户id：', GetUserInformation.uid);
		this.saveWithKeyValue(LOGIN_UID_KEY, String(Uid));
	}

	// 获取Token
	static getToken () {
		return AsyncStorage.getItem(LOGIN_TOKEN_KEY, () => {
			console.log('trying to get value with key : userToken');
		}).then(value => {
			if (value !== null) {
				GetUserInformation.token = String(value);
				console.log('get用户登录token：', GetUserInformation.token);
			}
		});
	}

	// 设置Token
	static setToken (token) {
		GetUserInformation.token = String(token);
		console.log('save用户登录token：', GetUserInformation.token);
		this.saveWithKeyValue(LOGIN_TOKEN_KEY, String(token));
	}

	// 获取白骑士设备指纹
	static getFingerKey () {
		AsyncStorage.getItem(FINGER_KEY, () => {
			console.log('trying to get value with key : Account');
		}).then(value => {
			if (value !== null) {
				GetUserInformation.fingerKey = String(value);
				console.log('get用户账户：', GetUserInformation.fingerKey);
			}
		});
	}

	// 设置白骑士设备指纹
	static setFingerKey (fingerKey) {
		GetUserInformation.fingerKey = String(fingerKey);
		console.log('白骑士设备指纹：', GetUserInformation.fingerKey);
		this.saveWithKeyValue(FINGER_KEY, String(fingerKey));
	}

	// 增
	static saveWithKeyValue (key, value) {
		try {
			return AsyncStorage.setItem(key, value, () => {
				console.log('save success with key:value => ', key, value);
			});
		} catch (e) {
			console.log(e);
		}
	}

	// 查
	static getValueForKey (key) {
		try {
			return AsyncStorage.getItem(key, () => {
				console.log('trying to get value with key :', key);
			}).then(value => {
				return value;
			},
			e => {
				console.log('------eeeeeeeee', e);
			});
		} catch (e) {
			console.log(e);
		}
	}

	// 删
	static removeValueForKey (key) {
		try {
			return AsyncStorage.removeItem(key, () => {
				console.log('remove value for key: ', key);
			});
		} catch (e) {
			console.log(e);
		}
	}

	// merge
	static mergeArrayWithKeyValue (key, value) {
		try {
			return this.getValueForKey(key).then(val => {
				if (typeof val === 'undefined' || val === null) {
					this.saveWithKeyValue(key, [value]);
					console.log(`key: ${key} is undefined, save array`);
				} else {
					val.unshift(value);
					this.saveWithKeyValue(key, val);
				}
			});
		} catch (e) {
			console.log(e);
		}
	}
}