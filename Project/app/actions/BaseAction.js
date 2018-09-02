import { DeviceEventEmitter } from 'react-native'
import { Types, HttpRequest, Url, JPush, toastShort } from '../config';
import FunctionUtils from '../utils/FunctionUtils';
import DeviceInfo from '../utils/DeviceInfo'
import { UpdateAuth } from './AuthAction'

/* -------------------↓↓↓↓↓↓↓↓ 公共参数配置以及初始化 ↓↓↓↓↓↓↓↓------------------- */

export function InitJpush () {
	return (dispatch, getState) => {
		JPush.init(dispatch);
	}
}

export function InitHome (obj, isShowLoading = true) {
	return (dispatch, getState) => {
		let requestList = [
			FetchHome(dispatch),
			FetchConfig(dispatch),
			FetchUpdate(dispatch, obj)
		]
		isShowLoading && !!obj && obj.pointer && obj.pointer.loading.show()
		HttpRequest.concurrency(requestList, (...dataArray) => {
			if (obj.pointer) {
				obj.pointer.loading.hide();
				obj.pointer.isInit = true;
				obj.pointer.cbRefresh && obj.pointer.cbRefresh()
			}
		})
	}
}

export function FetchConfig (dispatch) {
	return HttpRequest.request(Types.POST, Url.CONFIG)
		.then(responseData => {
			switch (responseData.Ret) {
				case 200:
					dispatch(SaveConfig(responseData));
					break;
				case 408:
					FunctionUtils.loginOut(responseData.Msg);
					break;
				default:
					responseData.Msg && toastShort(responseData.Msg);
					break;
			}
		})
		.catch(error => {
			console.log('error', error);
		})
}

export function FetchUpdate (dispatch) {
	return HttpRequest.request(Types.POST, Url.UPDATE)
		.then(responseData => {
			if (responseData.Ret === 200 && responseData.AppVersion) {
				console.log('弹出更新弹框更新');
				let version = String(DeviceInfo.getVersion()).split('.').join('');
				if (!!responseData.AppVersion.ShowVersion &&
					!!responseData.AppVersion.ConfigDesc &&
					!!responseData.AppVersion.Remark) {
					let serviceVersion = String(responseData.AppVersion.ShowVersion).split('.').join('');
					let versionInt = parseInt(version);
					let serviceVersionInt = parseInt(serviceVersion);
					dispatch(SaveConfig({
						ServerVersion: serviceVersionInt,
						IsNeedLocation: responseData.IsPosition
					}));
					if (serviceVersionInt > versionInt) {
						let closeAble = responseData.AppVersion.Remark !== '1';
						let param = {
							version: responseData.AppVersion.ShowVersion,
							desc: responseData.AppVersion.ConfigDesc,
							url: responseData.AppVersion.ConfigUrl,
							closeAble: closeAble
						}
						DeviceEventEmitter.emit('showUpdate', param);
					}
				}
			} else if (responseData.Ret === 408) {
				FunctionUtils.loginOut(responseData.Msg);
			} else {
				responseData.Msg && toastShort(responseData.Msg);
			}
		})
		.catch(error => {
			console.log('error', error);
		});
}

export function SaveConfig (parameter) {
	return {
		'type': Types.SAVE_CONFIG,
		'config': parameter
	}
}

export function SaveJpush (params) {
	return {
		'type': Types.INIT_JPUSH,
		'info': params
	}
}

/* -------------------↑↑↑↑↑↑↑↑ 其他配置 ↑↑↑↑↑↑↑↑------------------- */

/* -------------------↓↓↓↓↓↓↓↓ 首页相关 ↓↓↓↓↓↓↓↓------------------- */

export function FetchHome (dispatch, obj) {
	return HttpRequest.request(Types.POST, Url.INDEX)
		.then(responseData => {
			!!obj && !!obj.cbRefresh && obj.cbRefresh(responseData);
			if (responseData.Ret) {
				switch (responseData.Ret) {
					case 200:
						dispatch(SaveHome(responseData));
						dispatch(UpdateAuth({ InitAudit: responseData.Home.InitAudit }));
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
			!!obj && !!obj.cbRefresh && obj.cbRefresh({ Ret: 999 });
			console.log('error', error);
		});
}

export function SaveHome (parameter) {
	return {
		'type': Types.SAVE_HOME,
		'home': parameter
	}
}

/* -------------------↑↑↑↑↑↑↑↑ 首页相关 ↑↑↑↑↑↑↑↑------------------- */

/* -------------------↓↓↓↓↓↓↓↓ 登录相关 ↓↓↓↓↓↓↓↓------------------- */

export function LoginData (parameter) {
	return {
		'type': Types.LOGIN_DATA,
		'loginInfo': parameter
	}
}

export function LoginSuccess (parameter) {
	return {
		'type': Types.LOGIN_SUCCESS,
		'loginInfo': parameter
	}
}

export function LogOut () {
	return {
		'type': Types.LOGOUT
	}
}

/* -------------------↑↑↑↑↑↑↑↑ 登录相关 ↑↑↑↑↑↑↑↑------------------- */

/* -------------------↓↓↓↓↓↓↓↓ 定位信息 ↓↓↓↓↓↓↓↓------------------- */

export function GetIpLocate () {
	return (dispatch, getState) => {
		const params = {
			key: 'b5635eac6d4dd22a55174e67cc433c11'
		};
		HttpRequest.request(Types.GET, Url.IP_LOCATING, params, false)
			.then(responseData => {
				console.log('---------> ,IP定位成功加载', responseData);
				let data = responseData;
				let formattedAddress = '';
				let city = data.city;
				let province = data.province;
				if (data.status && data.status === '1') {
					if (data.province && data.city) {
						if (typeof (data.city) === 'string') {
							// city = data.city
						} else if (typeof (data.province) === 'string' && data.city instanceof Array) {
							// city = data.province
						}
						formattedAddress = ((typeof (data.province) === 'string') ? data.province : '') + ((typeof (data.city) === 'string') ? data.city : '');
					}
				}
				dispatch(SaveLocate({
					IpCity: city,
					IpProvince: province,
					IpDetailLocation: formattedAddress
				}));
			})
			.catch(error => {
				console.log('IP定位error', error);
			});
	}
}

export function SaveLocate (parameter) {
	return {
		'type': Types.SAVE_LOCATE,
		'address': parameter
	}
}

/* -------------------↑↑↑↑↑↑↑↑ 定位信息 ↑↑↑↑↑↑↑↑------------------- */

/* -------------------↓↓↓↓↓↓↓↓ 个人中心 ↓↓↓↓↓↓↓↓------------------- */

export function FetchCenter (pointer) {
	return (dispatch, getState) => {
		pointer && pointer.loading && pointer.loading.show()
		HttpRequest.request(Types.POST, Url.CENTER)
			.then(responseData => {
				pointer && pointer.loading && pointer.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							console.log(!!responseData.BankName && !!responseData.CardNumber)
							dispatch(UpdateCenter({
								HasBankCard: !!responseData.BankName && !!responseData.CardNumber,
								HasPayPwd: responseData.HasPayPwd,
								MessageCount: responseData.MessageCount,
								ProblemUrl: responseData.CommonUrl
							}))
							break
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							responseData.Msg && toastShort(responseData.Msg)
							break
					}
				}
			})
			.catch(error => {
				pointer && pointer.loading && pointer.loading.hide()
				console.log('error', error)
			})
	}
}

export function UpdateCenter (params) {
	return {
		'type': Types.UPDATE_CENTER,
		'data': params
	}
}
