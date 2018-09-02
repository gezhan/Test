'use strict';
import React, { Component } from 'react';
import {
	Platform
} from 'react-native';
import { Types, DataAlgorithm, DeviceInfo, toastShort, FunctionUtils } from '../config'
import { GetUserInformation } from './Storage';
import axios from 'axios';

// let isTestServer = false
// '0' --- 测试服务器
// '1' --- 过度服务器
// '2' --- 正式服务器
let isFormalServer = '2';
// 开发默认接口   正式服接口		http://d3e12907.ngrok.io / http://192.168.1.233:8588
const BASEURL = isFormalServer === '2' ? 'https://rrapi.5ujr.cn/v1/' : 'http://192.168.1.233:8688/v1/';

export default class HttpRequest extends Component {
	static getBASEURL = () => {
		return BASEURL;
	};

	static isFormalServer = () => {
		return isFormalServer === '2';
	};

	// 热更新的版本号
	static getComplentHotVer = () => {
		// 热更新1 修复iOS芝麻闪退，常见问题做活
		// 热更新2 修改提交设备指纹判断逻辑
		return 2;
	};

	// 调取单个接口
	static async request (method, url, params = {}, isEncrypt = true, isReal = true) {
		let self = this;
		switch (method) {
			case Types.GET: {
				// Get请求
				console.log('%c%s', 'color:blue;font-size:13px;font-weight:bold', `Get请求的url:${url}`);
				let result = await axios.get(url, {
					baseURL: BASEURL,
					params: params,
					transformResponse: data => this.transformResponse(data, url, isEncrypt, method, isReal),
					timeout: 30000
				}).catch(error => {
					return self.checkError(error, url, method, isReal);
				});
				return result.data;
			}
			case Types.POST: {
				console.log(`Post请求的参数:${JSON.stringify(params)}`);
				let result = await axios.post(url, params, {
					baseURL: BASEURL,
					transformRequest: data => this.transformRequest(data, url, isEncrypt),
					transformResponse: data => this.transformResponse(data, url, isEncrypt, method),
					headers: {
						'Accept': 'application/x-www-form-urlencoded',
						'Content-Type': 'application/json',
						'Authorization': 'APPCODE ' + 'a3126a886bd44511bebb623fb0c857ed'
					},
					timeout: 30000
				}).catch(error => {
					return self.checkError(error, url, method, isReal);
				})
				return result.data;
			}
			default:
				console.log('既不是get，也不是post');
		}
	}

	// `transformRequest`选项允许我们在请求发送到服务器之前对请求的数据做出一些改动
	// 插入基础参数-----Post
	static transformRequest (data, url, isEncrypt) {
		let body = {}, params = data;
		// Account:	string
		params.Account = params.Account ? params.Account : GetUserInformation.account;
		// App:	integer ($int64)
		params.App = Platform.OS === 'ios' ? 1 : 2;
		// AppVersion:	string
		params.AppVersion = DeviceInfo.getVersion();			// app版本号
		// DeviceSingle:	string  //安卓的imei码  ios的idfa
		params.DeviceSingle = FunctionUtils.getDeviceSingle();
		// DeviceUniqueID:	string
		params.DeviceUniqueID = DeviceInfo.getUniqueID();		// 设备唯一标识
		// FingerKey:	string
		params.FingerKey = params.FingerKey ? params.FingerKey : GetUserInformation.fingerKey;
		// IsEmulator:	boolean
		params.IsEmulator = DeviceInfo.isEmulator();			// 是否使用模拟器
		// MobileType:	string
		params.MobileType = FunctionUtils.upFirstChar(DeviceInfo.getModel());				// 手机类型
		// MobileVersion:	string
		params.MobileVersion = DeviceInfo.getSystemVersion();	// 手机系统版本号
		// Brand: string
		params.Brand = DeviceInfo.getBrand();
		// PkgType:	integer ($int64)
		params.PkgType = 0;
		// Token:	string
		params.Token = params.Token ? params.Token : GetUserInformation.token;
		// Uid:	integer ($int64)
		params.Uid = params.Uid ? params.Uid : GetUserInformation.uid;
		params.JPushId = params.JPushId ? params.JPushId : GetUserInformation.jPushId;
		params.Platform = Platform.OS === 'ios' ? 'AppStore' : DeviceInfo.getChannel();
		// 热更新版本号
		params.ComplentHotVer = this.getComplentHotVer();
		if (isEncrypt === true) {
			console.log(`${BASEURL + url} 加密Post请求上传的参数：${JSON.stringify(params)}`);
			let postData = DataAlgorithm.Des3Encrypt(JSON.stringify(params));
			console.log(`${BASEURL + url} 加密Post请求上传的加密参数 ${postData}`);
			if (postData) {
				body = postData;
			}
		} else {
			console.log(`${BASEURL + url} 未加密Post请求上传的参数：${JSON.stringify(params)}`);
			let postDataStr = JSON.stringify(params);
			if (postDataStr) {
				body = postDataStr;
			}
		}
		return body;
	}

	// `transformResponse`选项允许我们在数据传送到`then/catch`方法之前对数据进行改动
	static transformResponse (data, url, isEncrypt, method, isReal = true) {
		// console.warn('这里是： transformResponse');
		if (!data) {
			// console.log("失败原因大概是： 返回为null")
			toastShort('请求失败');
			return false;
		}
		return this.encrypt(data, url, isEncrypt, method, isReal);
	}

	// 解密
	static encrypt (jsonData, url, isEncrypt, method, isReal) {
		if (isReal) {
			if (isEncrypt === true) {
				let jsDataStr = DataAlgorithm.Des3Decrypt(jsonData);
				if (jsDataStr === 'null') {
					console.log(`${BASEURL + url} ${method}返回null`);
					toastShort('网络请求异常')
					return false;
				}
				let jsdata = JSON.parse(jsDataStr);
				if (jsdata) {
					console.log('%c%s', 'color:red;font-size:15px;font-weight:bold', `${BASEURL + url} 成功返回加密的${method} json数据:`);
					console.log(jsdata);
					return jsdata;
				} else {
					console.log(`${BASEURL + url} ${method}请求转化失败`);
					return false;
				}
			} else {
				console.log('%c%s', 'color:red', `${BASEURL + url} 成功返回的未加密${method} json数据:`);
				console.log(JSON.parse(jsonData));
				return JSON.parse(jsonData);
			}
		} else {
			console.log(`${url} 成功返回的${method} json数据:`);
			let jsonObj = JSON.parse(jsonData);
			console.log(JSON.stringify(jsonObj));
			return JSON.parse(jsonData);
		}
	}

	// 解析错误
	static checkError (err, url, method, isReal) {
		if (err === 'URIError: URI malformed') {
			toastShort('数据异常，请稍后再试');// 一般是接口没加密
		} else if (err === 'SyntaxError: Unexpected token < in JSON at position 1') {
			toastShort('请求失败，请稍后再试');// 接口路由地址错误
		} else if (err.message.indexOf('timeout of') !== -1) {
			toastShort('请求超时');
		} else {
			toastShort('网络不给力，请稍后再试');
		}
		console.log(`${isReal ? BASEURL + url : url} ${method} 出现错误：${err}`);
		return false
	}

	static transformFakeRequest (data, url, isEncrypt) {
		let body = '';
		console.log(`${url} 伪装接口请求上传的参数：${JSON.stringify(data)}`);
		for (let [key, value] of Object.entries(data)) {
			if (body === '') {
				body = key + '=' + value;
			} else {
				body += '&' + key + '=' + value;
			}
		}
		return body;
	}

	// 并发多个接口
	static concurrency (funArray, callBack) {
		axios.all(funArray)
			.then(axios.spread((...arg) => {
				// let obj = {
				// 	Ret: 200,
				// 	msg: ''
				// }
				// for (let i = 0; i < arg.length; i++) {
				// 	if (arg[i].Ret !== 200) {
				// 		obj.Ret = arg[i].Ret
				// 		obj.msg = arg[i].msg
				// 		break
				// 	}
				// }
				callBack(arg)
			}))
	}
}