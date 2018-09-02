import { Types, HttpRequest, Url } from '../config';
import { toastShort } from '../utils/ToastUtil';
import FunctionUtils from '../utils/FunctionUtils';

export function GetLoan (pointer) {
	return dispatch => {
		!!pointer && !!pointer.loading && pointer.loading.show()
		HttpRequest.request(Types.POST, Url.LOAN_CENTER)
			.then(responseData => {
				!!pointer && !!pointer.loading && pointer.loading.hide()
				if (responseData.Ret) {
					switch (responseData.Ret) {
						case 200:
						case 202:
							dispatch(UpdateLoan(responseData));
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
				!!pointer && !!pointer.loading && pointer.loading.hide()
				console.log('error', error)
			})
	}
}
export function UpdateLoan (params) {
	return {
		'type': Types.UPDATE_LOAN,
		'data': params
	}
}