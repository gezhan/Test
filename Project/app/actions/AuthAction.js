import { Types, HttpRequest, Url } from '../config';
import { toastShort } from '../utils/ToastUtil';
import FunctionUtils from '../utils/FunctionUtils';

export function GetAuth (pointer) {
	return dispatch => {
		!!pointer && !!pointer.loading && pointer.loading.show()
		HttpRequest.request(Types.POST, Url.AUTH)
			.then(responseData => {
				!!pointer && !!pointer.loading && pointer.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200: {
							let RemainDays = 0
							if (responseData.InitAudit === 7) {
								let closeTime = Date.parse(responseData.CloseTime) + responseData.CreditCloseDay * 24 * 60 * 60 * 1000
								closeTime = (closeTime - new Date(responseData.Currtime)) / 1000 / 60 / 60 / 24
								RemainDays = Math.ceil(closeTime)
							}
							dispatch(UpdateAuth({
								VerifyRealName: responseData.VerifyRealName,
								IdCard: responseData.IdCard,
								IsOcr: responseData.IsOcr,
								IsRealName: responseData.IsRealName,
								IsLiving: responseData.IsLiving,
								FailTime: responseData.FailTime,

								BaseInfo: responseData.BaseInfo,
								IsBaseInfo: responseData.IsBaseInfo,
								IsMobileAuth: responseData.IsMobileAuth,
								IsBindCard: responseData.IsBindCard,
								BankInfo: responseData.BankInfo,

								InitAudit: responseData.InitAudit,
								IsLinkMan: responseData.IsLinkMan,
								MobileTag: responseData.MobileTag,
								IsZmAuth: responseData.IsZmAuth,
								ZmxyTag: responseData.ZmxyTag,

								RemainDays: RemainDays,
								CloseTime: responseData.CloseTime,
								CreditCloseDay: responseData.CreditCloseDay,
								Currtime: responseData.Currtime,

								OperateProtocol: responseData.OperateProtocol,

								IsPop: responseData.IsPop,
								PopUrl: responseData.PopUrl
							}))
							break
						}
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
				!!pointer && !!pointer.loading && pointer.loading.hide()
				console.log('error', error)
			})
	}
}

export function UpdateAuth (params) {
	return {
		'type': Types.UPDATE_AUTH,
		'data': params
	}
}

export function UpdateRecord (params) {
	return {
		'type': Types.UPDATE_RECORD,
		'data': params
	}
}
