'use strict';
import React from 'react';
import {
	Platform,
	InteractionManager,
	NativeModules,
	DeviceEventEmitter,
	Linking
} from 'react-native';

import {
	Types,
	HttpRequest,
	Url,
	Jump,
	toastShort,
	DeviceInfo,
	DataAlgorithm
} from '../config';
// action
import { SaveLocate, LogOut } from '../actions/BaseAction';

// 高德定位
const AmapLocation = Platform.OS === 'ios' ? NativeModules.GaodeModules : NativeModules.AMapLocation;

// ios权限检测
const PermissionsDetect = Platform.OS === 'ios' ? NativeModules.PermissionsDetect : NativeModules.BqsDeviceModule
// 获取通话和短信记录
const PhoneInfo = NativeModules.PhoneInfoModule;
// 获取联系人信息
const Contacts = Platform.OS === 'ios' ? NativeModules.GetContact : NativeModules.ContactsModule
const AddressBook = Platform.OS === 'ios' ? NativeModules.AddressBookModule : NativeModules.ContactsModule

const SmAntiFraud = NativeModules.SmAntiFraud
const Alipay = Platform.OS === 'ios' ? NativeModules.AlipayVC : NativeModules.PhoneInfoModule;

export default class FunctionUtils {
	static setStore (store) {
		FunctionUtils.mStore = store;
	}

	static isLogin (baseInfo) {
		return baseInfo.loginState && baseInfo.uid !== 0 && baseInfo.account !== ''
	}

	// 退出登录
	static loginOut (err) {
		InteractionManager.runAfterInteractions(() => {
			FunctionUtils.mStore.dispatch(LogOut())
			err && toastShort(err);
			Jump.backToTop(0)
		});
	}

	// 是否认证完毕
	static isFinishAuth (authInfo) {
		return (authInfo.IsZmAuth === 1 || authInfo.ZmxyTag === '2') &&
			authInfo.IsBindCard === 1 &&
			authInfo.IsMobileAuth === 1 &&
			authInfo.IsLinkMan === 1 &&
			authInfo.IsBaseInfo === 1;
	}

	/**
	 * 保护用户身份证,参数必须传入身份证号
	 * @param {*身份证号} str
	 */
	static ensureIDNumber (str) {
		let result = ''
		if (str && str.length === 18) {
			result = str.substr(0, 4) + '************' + str.substr(14)
		}
		return result
	}

	static isEmail (str) {
		let regExp = new RegExp('\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*');
		return regExp.test(str);
	}

	// 验证是否是数字
	static isNumberNo (number) {
		let regExp = new RegExp('^[0-9]*$');
		return regExp.test(number);
	}

	// 验证是否是有数字和大小写字母组成的密码
	static isNumberOrLetter (number) {
		let regExp = new RegExp('^[0-9a-zA-Z]*$');
		return regExp.test(number);
	}

	// 使用正则表达式判断手机号是否符合规则
	static isMobileNo (account) {
		let isChinaMobile = new RegExp('(^1(3[4-9]|4[78]|5[0-27-9]|7[28]|8[2-478]|98)\\d{8}$)');// 中国移动
		// 手机段：134,135,136,137,138,139,147,148[卫星通信],150,151,152,157,158,159,172,178,182,183,184,187,188,198
		let isChinaUnicom = new RegExp('(^1(3[0-2]|4[56]|5[56]|66|7[156]|8[56])\\d{8}$)');// 中国联通
		// 手机段：130,131,132,145,146[卫星通信],155,156,166,171,175,176,185,186
		let isChinaTelcom = new RegExp('(^1(33|49|53|7[347]|8[019]|99)\\d{8}$)');// 中国电信
		// 手机段：133,149,153,173,174,177,180,181,189,199
		let isOtherTelphone = new RegExp('(^170\\d{8}$)');
		// 虚拟运营商170号段
		if (isChinaMobile.test(account)) {
			return true;
		} else if (isChinaUnicom.test(account)) {
			return true;
		} else if (isChinaTelcom.test(account)) {
			return true;
		} else return isOtherTelphone.test(account);
	}

	// 字符串首字母大写
	static upFirstChar = string => {
		return string.substring(0, 1).toUpperCase() + string.substring(1);
	};

	// 时间格式化
	static format (format, date) {
		let o = {
			'M+': date.getMonth() + 1, // month
			'd+': date.getDate(), // day
			'h+': date.getHours(), // hour
			'm+': date.getMinutes(), // minute
			's+': date.getSeconds(), // second
			'q+': Math.floor((date.getMonth() + 3) / 3), // quarter
			'S': date.getMilliseconds() // millisecond
		};

		if (/(y+)/.test(format)) {
			format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
		}

		for (let k in o) {
			if (new RegExp('(' + k + ')').test(format)) {
				format = format.replace(RegExp.$1, RegExp.$1.length === 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length));
			}
		}
		return format;
	}

	// 得到经纬度请求高德的第三方api 获取具体的位置
	static getLocation = (isNeedLocation, callBack) => {
		if (isNeedLocation) {
			if (Platform.OS === 'ios') {
				PermissionsDetect.Detection('location', state => {
					if (state === 'true') {
						AmapLocation.SetLocation(lastPosition => {
							if (lastPosition.status === '1') {
								let longitude = Number(lastPosition.longitude)
								let latitude = Number(lastPosition.latitude)
								if (longitude && latitude) {
									FunctionUtils.mStore.dispatch(SaveLocate({
										LongitudeAndLatitude: `${longitude},${latitude}`,
										Location: lastPosition.city,
										LocationDetail: lastPosition.province + lastPosition.city + lastPosition.district + lastPosition.street
									}))
									callBack(true, true, {
										msg: '',
										locate: lastPosition
									});
								} else {
									callBack(true, false, {
										msg: '未获取到位置信息，请稍后再试',
										locate: null
									});
								}
							} else {
								callBack(true, false, {
									msg: '未获取到位置信息，请稍后再试',
									locate: null
								});
								console.log(lastPosition.msg);
							}
						})
					} else {
						callBack(false, false, {
							msg: '"位置"访问权限已关闭，请前往设置开启权限',
							locate: null
						});
					}
				})
			} else {
				PermissionsDetect.isGPSOpen(status => {
					if (status) {
						let LocationListen = DeviceEventEmitter.addListener('onAmapLocationChanged', lastPosition => {
							if (lastPosition.isSucceed) {
								let longitude = Number(lastPosition.longitude).toFixed(6);
								let latitude = Number(lastPosition.latitude).toFixed(6);
								console.log(`经度${longitude},纬度${latitude}`);
								if (longitude && latitude) {
									FunctionUtils.mStore.dispatch(SaveLocate({
										LongitudeAndLatitude: `${longitude},${latitude}`,
										Location: lastPosition.city,
										LocationDetail: lastPosition.province + lastPosition.city + lastPosition.district + lastPosition.street
									}));
									callBack(true, true, {
										msg: '',
										locate: lastPosition
									});
								}
							} else {
								callBack(true, false, {
									msg: '未获取到位置信息，请稍后再试',
									locate: null
								});
								console.log('定位错误：', '错误码：' + lastPosition.errorCode + ' 错误信息：' + lastPosition.errorInfo);
							}
							AmapLocation.stopLocation();
							LocationListen.remove();
						});
						let options = { needDetail: true, accuracy: 'HighAccuracy', onceLocation: true };
						AmapLocation.startLocation(options);
					} else {
						callBack(false, false, {
							msg: 'GPS定位权限已关闭，请前往设置开启权限',
							locate: null
						});
					}
				})
			}
		} else {
			callBack(true, true, {
				msg: '',
				locate: null
			});
		}
	};

	// 静默登录
	static silentLogin (baseInfo, callBack) {
		if (this.isLogin(baseInfo)) {
			HttpRequest.request(Types.POST, Url.LOGIN, {
				Account: baseInfo.account,
				Location: baseInfo.location,
				Address: baseInfo.locationDetail,
				JpushId: baseInfo.jPushId,
				IpLocation: baseInfo.ipCity,
				IpAddress: baseInfo.ipDetailLocation,
				LongitudeLatitude: baseInfo.longitudeAndLatitude,
				SilentLogin: 1
			})
				.then(responseData => {
					console.log(`-------->,登录返回的数据` + JSON.stringify(responseData));
					callBack(responseData);
				})
				.catch(error => {
					console.log('error', error);
				});
		}
	}

	// 去更新
	static goUpdate (url) {
		console.log('去更新');
		Linking.canOpenURL(url).then(supported => {
			if (!supported) {
				console.log('Can\'t handle url: ' + url);
			} else {
				return Linking.openURL(url);
			}
		}).catch(err => console.error('An error occurred', err));
	}

	// 筛选通讯录 - 超过10个的部分砍掉
	static filterContacts (contacts) {
		let array = false
		if (contacts.length > 0) {
			array = contacts
			let indexArray = []
			for (let i = 0; i < contacts.length; i++) {
				if (contacts[i].contactPhoneNumber.length >= 10) {
					indexArray.push(i)
				}
			}
			if (indexArray.length > 0) {
				for (let j = 0; j < indexArray.length; j++) {
					array.splice(indexArray[j] - j, 1)
				}
			}
		}
		return array
	}

	// 获取通讯录
	static getContacts (getListCb, getLinkmanCb, type, isJumpNative = true) {
		if (Platform.OS === 'ios') {
			let data = {
				Ret: 0,
				Msg: '',
				Data: null
			}
			// 获取 啥权限的
			PermissionsDetect.AskPermission('contact', state => {
				if (state === 'true') {
					// 再获取 啥权限的
					PermissionsDetect.Detection('contact', state => {
						if (state === 'true') {
							// 获取联系人信息
							Contacts.GetContacts(contacts => {
								console.log('获取ios联系人的信息：', contacts)
								let arr = this.filterContacts(contacts)
								data = { Ret: 200, Msg: '', Data: arr }
								getListCb(data)
								if (isJumpNative) {
									// 跳转通讯录
									AddressBook.OpenAddressBook((name, phoneValue) => getLinkmanCb(name, phoneValue, type))
								}
							})
						} else {
							data = { Ret: 304, Msg: '通讯录"访问权限已关闭，请前往设置开启权限', Data: null }
							getListCb(data)
						}
					})
				} else {
					data = { Ret: 304, Msg: '通讯录"访问权限已关闭，请前往设置开启权限', Data: null }
					getListCb(data)
				}
			})
		} else {
			// 获取联系人信息
			Contacts.getContacts((state, results) => {
				let data = { Ret: 0, Msg: '', Data: null }
				if (state) {
					let contacts = JSON.parse(results);
					console.log('获取android联系人的信息：', contacts)
					let arr = this.filterContacts(contacts)
					data = { Ret: 200, Msg: '', Data: arr }
					getListCb(data)
					if (isJumpNative) {
						// 跳转通讯录
						AddressBook.toContact((name, phoneValue) => getLinkmanCb(name, phoneValue, type))
					}
				} else {
					data = { Ret: 304, Msg: '通讯录"访问权限已关闭，请前往设置开启权限', Data: null }
					getListCb(data)
				}
			})
		}
	}

	// 获取安卓手机通话记录跟短信记录
	static getPhoneInfo (callBack) {
		if (Platform.OS === 'android') {
			PhoneInfo.getCalls((state, callList) => {
				console.log('通话记录获取状态:' + state + '通话记录参数：' + callList);
				if (state) {
					PhoneInfo.getSms((state, smsList) => {
						console.log('短信记录获取状态:' + state + '短信记录参数：' + smsList);
						if (state) {
							callBack(true, 'callList&smsList', JSON.parse(callList), JSON.parse(smsList));
						} else {
							callBack(false, 'smsList', null, null);
						}
					});
				} else {
					callBack(false, 'callList', null, null);
				}
			});
		} else {
			callBack(true, '', null, null);
		}
	}

	static getDeviceSingle () {
		let deviceId = Platform.OS === 'ios' ? DeviceInfo.getIdfa() : DeviceInfo.getImei();
		if (deviceId === '' || deviceId === '00000000-0000-0000-0000-000000000000') {
			deviceId = 'A0C6AB8E-0EC9-4014-86BE-B307E6212DAE'
		}
		return deviceId;
	}

	static ShuMeiInit () {
		SmAntiFraud.init({
			organization: 'AKxaahKHsU9IlGPKJmyx',
			channel: Platform.OS === 'ios' ? 'AppStore' : DeviceInfo.getChannel()
		})
	}

	// 数媒获取DeviceId方法
	static ShuMeiGetDeviceId (callBack) {
		SmAntiFraud.getSMFingerToken(callback => {
			console.log('数美获取DeviceId：' + callback);
			callBack(callback);
		})
	}

	static isAlipayInstall (callBack) {
		if (Platform.OS === 'ios') {
			Alipay.AlipayModules(isInstall => {
				callBack(isInstall)
			});
		} else {
			Alipay.isAliInstalled(isInstall => {
				callBack(isInstall)
			});
		}
	}

	// 拨打电话
	static callPhone (serviceTelephone) {
		Linking.canOpenURL('tel:' + String(serviceTelephone).replace('-', '')).then(supported => {
			if (!supported) {
				console.log('Can\'t handle url: ' + serviceTelephone);
			} else {
				return Linking.openURL('tel:' + String(serviceTelephone).replace('-', ''));
			}
		}).catch(err => console.error('An error occurred', err));
	}

	/**
	 * 保护用户姓名,参数必须传入手机号
	 * @param {*手机号} str
	 */
	static ensureName (str) {
		return '*' + str.substr(1);
	}

	/**
	 * 保护用户手机号,参数必须传入手机号
	 * @param {*手机号} str
	 */
	static ensurePhone (str) {
		return str.substr(0, 3) + '****' + str.substr(7);
	}

	// 判断是否是连续顺序或者连续倒序的数字
	static isContinueNum (numStr) {
		if (!FunctionUtils.isNumberNo(numStr)) {
			return null;
		}
		let is = true;
		for (let i = 0; i < numStr.length; i++) {
			if (i > 0) { // 判断如123456
				let num = parseInt(numStr.charAt(i) + '');
				let num_ = parseInt(numStr.charAt(i - 1) + '') + 1;
				if (num !== num_) {
					is = false;
					break;
				}
			}
		}
		if (!is) {
			for (let i = 0; i < numStr.length; i++) {
				if (i > 0) { // 判断如654321
					let num = parseInt(numStr.charAt(i) + '');
					let num_ = parseInt(numStr.charAt(i - 1) + '') - 1;
					if (num !== num_) {
						is = false;
						break;
					}
				}
			}
		}
		return is;
	}

	// 是否是重复的数字
	static isRepeat (numStr) {
		if (!FunctionUtils.isNumberNo(numStr)) {
			return null;
		}
		let is = true;
		for (let i = 0; i < numStr.length; i++) {
			if (i > 0) { // 判断如111111
				if (parseInt(numStr.charAt(0) + '') !== parseInt(numStr.charAt(i) + '')) {
					is = false;
					break;
				}
			}
		}
		return is;
	}

	static getAddParamsUrl (baseInfo, url) {
		let result = '';
		if (url) {
			let charStr = String(url).indexOf('?') < 0 ? '?' : '&';
			result = url + charStr + 'uid=' + DataAlgorithm.Des3Encrypt(baseInfo.uid) + '&account=' + DataAlgorithm.Des3Encrypt(baseInfo.account) + '&app=' + (Platform.OS === 'ios' ? 1 : 2) + '&appVersion=' + DeviceInfo.getVersion() + '&complentHotVer=' + HttpRequest.getComplentHotVer();
		}
		return result;
	}
}
