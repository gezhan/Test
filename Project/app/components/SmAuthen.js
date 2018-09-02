'use strict'
import {
	Platform,
	NativeModules
} from 'react-native'
// import { RatiocalWidth, RatiocalHeight, RatiocalFontSize, General, CellStyle} from '../style/Style'
import FunctionUtils from '../utils/FunctionUtils'
import { HttpRequest, Types, Url, toastShort } from '../config'
const YouDunModule = NativeModules.YouDunModule

let _idCard2// Request 传入的身份证

let _IPCity, _IPProvince

// let Baseurl = Url.AUTH_STATE // 基础参数接口
let CallBackUrl = Url.NOTIFICATIONURL

export default class SmAuthen {
	// 第一步 => 一开始进来---------------------------------------
	static Request (pointer, callBack) {
		console.log('Request+++++++++++++++++++++=')

		this.baseParams = {
			sign: '',								// 签名
			signTime: '',						// 签名时间
			InfOrder: '',			// 订单号
			notifyUrl: '',
			pubKey: ''		// 公钥
		}
		this.OCRCallback = ''					// ocr回调地址
		this.AuthNameCallback = ''			// 实名回调地址
		this.LivingsCallback = ''			// 活体回调地址
		// 指针
		this.pointer = pointer
		// '1' 全流程  '0'不是(跳过实名)
		// this.isGridPhoto = '1'
		// OCR/实名认证返回的session_id，需要用这个去进行活体对比
		this.sessionId = ''
		// 活体次数
		this.Count = 0

		this.Name = ''
		this.IdCard = ''
		// _IPCity = params.IPCity
		// _IPProvince = params.IPProvince

		// 底层回调----固定回调参数，ErrCode:0(失败),1(成功)，dic:失败(有盾提示语),成功(返回有盾回调结果)
		this.CallBack = callBack
		this.getAuthInfo()
	}

	// 第二步 => 获取实名基本信息
	static getAuthInfo () {
		console.log('getAuthInfo（获取实名信息）111+++++++++++++++++++++=')
		this.pointer.loading.show()
		HttpRequest.request(Types.POST, Url.AUTH)
			.then(responseData => {
				console.log('getAuthInfo（获取实名信息）222+++++++++++++++++++++=')
				this.pointer.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							if (responseData.FailTime === 2) {
								this.CallBack({ ErrCode: 310, Msg: '实名次数已用完' })
								return
							}
							// this.Count = responseData.Count
							this.Name = responseData.VerifyRealName
							this.IdCard = responseData.IdCard
							this.sessionId = responseData.YdSessionId
							this.OCRCallback = responseData.OCRCallback || ''
							this.AuthNameCallback = responseData.AuthNameCallback || ''
							this.LivingsCallback = responseData.LivingsCallback || ''
							// this.isGridPhoto = responseData.IsGridPhoto
							// toastShort('获取实名信息成功')
							this.beginAuth(responseData)
							break
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							this.CallBack({ ErrCode: 0, Msg: responseData.Msg })
							break
					}
				}
			})
			.catch(error => {
				this.pointer.loading.hide()
				this.CallBack({ ErrCode: 0, Msg: error })
				console.log('error', error)
			})
	}

	// 第三步 => 正式开始实名，判断走哪步
	static beginAuth (callBack) {
		if (callBack.Ret === 200) {
			let step = ''
			if (callBack.IsOcr !== 1) {
				console.log('前往ocr')
				step = 'ocr'
			} else if (callBack.IsRealName !== 1) {
				console.log('前往实名')
				step = 'sm'
			} else if (callBack.IsLiving !== 1) {
				console.log('前往活体')
				step = 'ht'
			}
			!!step && this.getSign(step)
		}
	}

	// 第四步 => 每步流程前 获取签名
	static getSign (step) {
		console.log('getSign（获取签名信息）111+++++++++++++++++++++=')
		this.pointer.loading.show()
		HttpRequest.request(Types.POST, Url.AUTH_SIGN)
			.then(responseData => {
				console.log('getSign222（获取签名信息）+++++++++++++++++++++=')
				this.pointer.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.baseParams.sign = responseData.Sign
							this.baseParams.signTime = responseData.Time
							this.baseParams.InfOrder = responseData.PartnerOrderId
							this.baseParams.pubKey = responseData.PublicKey
							// toastShort('获取签名成功')
							if (step === 'ocr') {
								this.Ocr()
							} else if (step === 'sm') {
								this.SM()
							} else if (step === 'ht') {
								this.HTdb()
							}
							break
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							// responseData.Msg && toastShort(responseData.Msg)
							this.CallBack({ ErrCode: 0, Msg: responseData.Msg })
							break
					}
				}
			})
			.catch(error => {
				this.pointer.loading.hide()
				this.CallBack({ ErrCode: 0, Msg: error })
				console.log('error', error)
			})
	}

	// OCR
	static Ocr () {
		this.pointer.loading.show()
		console.log('调OCR SDK 111+++++++++++++++++++++=')
		let data = { ...this.baseParams, notifyUrl: this.OCRCallback }
		console.log(data)
		if (Platform.OS === 'ios') {
			YouDunModule.OpenOCRSM(data, callBack => {
				this.pointer.loading.hide()
				console.log('调OCR SDK 222+++++++++++++++++++++=')
				console.log(callBack)
				if (callBack) {
					if (callBack === '请求处理失败，请联系客服') {
						this.CallBack({ ErrCode: 0, Msg: '请求处理失败，请联系客服' })
					} else {
						if (callBack.success) {
							// 成功后调用接口，把OCR数据上传
							callBack.success = !(callBack.success === '0' || callBack.success === false)
							this.ORCRequest(callBack)
						} else {
							this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
						}
					}
				}
			})
			setTimeout(() => {
				this.pointer.loading.hide()
			}, 1500)
		} else {
			// 安卓orc
			YouDunModule.getORCandroid(JSON.stringify(data), callback => {
				this.pointer.loading.hide()
				console.log('android ORC____________回调_____________:' + callback)
				if (callback) {
					if (callback === '请求处理失败，请联系客服') {
						this.CallBack({ ErrCode: 0, Msg: '请求处理失败，请联系客服' })
					} else {
						let a = JSON.parse(callback)
						if (a.success === 'true') {
							a.success = !(a.success === '0' || a.success === false)
							this.sessionId = a.session_id
							// 成功后调用接口，把OCR数据上传
							this.ORCRequest(a)
						} else {
							this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
						}
					}
				}
			})
		}
	}

	// ocr请求
	static ORCRequest (params) {
		this.pointer.loading.show()
		params.IdCard = _idCard2
		console.log('上传 OCR111+++++++++++++++++++++=')
		HttpRequest.request(Types.POST, Url.AUTH_ORC, params)
			.then(responseData => {
				console.log('上传 OCR222+++++++++++++++++++++=')
				this.pointer.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							this.sessionId = params.session_id
							// 上传成功后进行下一步实名操作
							this.Name = responseData.RealName
							this.IdCard = responseData.IdCard
							// this.isGridPhoto = '1'
							!!responseData && this.getSign('sm')
							break
						case 311:
							this.CallBack({ ErrCode: 311, Msg: responseData.Msg })
							break
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							this.CallBack({ ErrCode: 0, Msg: responseData.Msg })
							break
					}
				}
			})
			.catch(error => {
				this.pointer.loading.hide()

				this.CallBack({ ErrCode: 0, Msg: error })
				console.log('error', error)
			})
	}

	// 实名认证
	static SM () {
		this.pointer.loading.show()
		console.log('调实名SDK 111+++++++++++++++++++++=')
		console.log(this.baseParams)
		let data = {
			...this.baseParams,
			notifyUrl: this.AuthNameCallback,
			userName: this.Name,
			card: this.IdCard
		}
		console.log(data)
		if (Platform.OS === 'ios') {
			YouDunModule.OpenSm(data, callBack => {
				this.pointer.loading.hide()
				console.log('调实名SDK 222+++++++++++++++++++++= ios')
				console.log(callBack)
				if (callBack) {
					if (callBack.success) {
						callBack.success = !(callBack.success === '0' || callBack.success === false)
						this.SMRequest(callBack)
					} else {
						this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
					}
				} else {
					this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
				}
			})
			setTimeout(() => {
				this.pointer.loading.hide()
			}, 1500)
		} else {
			// 安卓实名认证
			YouDunModule.getTrueNameAndroid(JSON.stringify(data), callBack => {
				console.log('调实名SDK 222+++++++++++++++++++++= android')
				console.log(callBack)
				if (callBack) {
					let a = JSON.parse(callBack)
					if (a.success === 'true') {
						a.success = !(a.success === '0' || a.success === false)
						this.SMRequest(a)
					} else {
						this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
					}
				} else {
					this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
				}
			})
		}
	}

	// 实名请求
	static SMRequest (responseData) {
		this.pointer.loading.show()
		console.log('上传 实名111+++++++++++++++++++++=')
		let params = {
			...responseData,
			IDName: this.Name,
			Idcard: this.IdCard
		}
		HttpRequest.request(Types.POST, Url.AUTH_SM, params)
			.then(responseData => {
				console.log('上传 实名222+++++++++++++++++++++=')
				this.pointer.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
							// 上传成功后进行下一步活体+对比
							this.sessionId = responseData.SessionId
							this.getSign('ht')
							break
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							// responseData.Msg && toastShort(responseData.Msg)

							this.CallBack({ ErrCode: 0, Msg: responseData.Msg })
							break
					}
				}
			})
			.catch(error => {
				this.pointer.loading.hide()

				this.CallBack({ ErrCode: 0, Msg: error })
				console.log('error', error)
			})
	}

	// 活体认证+对比
	static HTdb () {
		this.pointer.loading.show()
		console.log('调活体SDK 111+++++++++++++++++++++=')
		let data = {
			...this.baseParams,
			notifyUrl: this.LivingsCallback,
			session_id: this.sessionId
			// isGridPhoto: this.isGridPhoto
		}
		console.log(data)
		if (Platform.OS === 'ios') {
			YouDunModule.OpenHTFace(data, callBack => {
				console.log('调活体SDK 222+++++++++++++++++++++= ios')
				console.log(callBack)
				this.pointer.loading.hide()
				if (callBack) {
					if (callBack.Face && callBack.Living) {
						if (callBack.Face.success && callBack.Living.success) {
							// callBack.Face.success = callBack.Face.success ? true : false
							// callBack.Living.success = callBack.Living.success ? true : false
							this.getLocation(callBack)
						} else {
							this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
						}
					} else {
						this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
					}
				} else {
					this.CallBack({ ErrCode: -999, Msg: '' })// 用户取消操作
				}
			})
			setTimeout(() => {
				this.pointer.loading.hide()
			}, 1500)
		} else {
			// 安卓活体+对比
			YouDunModule.getLiveAndCompaierAndroid(JSON.stringify(data), callback => {
				console.log('调活体SDK 222+++++++++++++++++++++= android')
				this.pointer.loading.hide()
				if (callback) {
					let a = JSON.parse(callback)
					console.log(a)
					if (a.Face && a.Living) {
						if (a.Face.success === 'true' && a.Living.success === 'true') {
							a.Face.success = true
							a.Living.success = true
							this.getLocation(a)
						} else {
							this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
						}
					} else {
						this.CallBack({ ErrCode: 0, Msg: '认证失败,请重试' })
					}
				} else {
					this.CallBack({ ErrCode: -999, Msg: '' })// 用户取消操作
				}
			})
		}
	}

	static getLocation (authParams) {
		if (this.Count === 0) {
			this.pointer.loading.show()
			FunctionUtils.getLocation(true, (isOpenLocation, isGetLocation, locationObj) => {
				if (isOpenLocation && isGetLocation) {
					let params = {
						...authParams,
						IPCity: _IPCity,
						IPProvince: _IPProvince,
						Location: locationObj.locate.location,
						Address: locationObj.locate.locationDetail,
						LongitudeLatitude: locationObj.locate.longitudeAndLatitude
					}
					this.HTdbRequest(params)
				} else {
					toastShort('当前定位信号不稳定')
					this.pointer.loading.hide()
				}
			})
		} else {
			this.HTdbRequest(authParams)
		}
	}

	static HTdbRequest (params) {
		this.pointer.loading.show()
		console.log('上传 活体111+++++++++++++++++++++=')
		params.idcard = this.IdCard
		HttpRequest.request(Types.POST, Url.AUTH_HT, params)
			.then(responseData => {
				this.pointer.loading.hide()
				console.log('上传 活体222+++++++++++++++++++++=')
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200: {
							let dic = {
								RealName: this.Name, // 姓名
								IdCard: this.IdCard// 身份证号
							}
							this.CallBack({ ErrCode: 1, Msg: responseData.Msg, dic })
							break
						}
						case 408:
							FunctionUtils.loginOut(responseData.Msg)
							break
						default:
							this.CallBack({ ErrCode: 0, Msg: responseData.Msg })
							break
					}
				}
			})
			.catch(error => {
				this.pointer.loading.hide()
				this.CallBack({ ErrCode: 0, Msg: error })
			})
	}
}
