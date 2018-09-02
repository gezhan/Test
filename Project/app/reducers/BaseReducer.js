'use strict';
import { Types, Storage } from '../config';
export const initialState = {
	// 用户信息
	oldAccount: '',
	loginMode: null,
	account: '',
	jPushId: '',
	uid: 0,
	token: '',
	fingerKey: '',
	loginState: false,
	// 登录页面配置
	pswLoginX: 0,
	// 定位信息
	longitudeAndLatitude: '', // 地理位置 纬度,经度
	location: '',
	locationDetail: '',
	ipCity: '', // 所在城市
	ipProvince: '',
	ipDetailLocation: '', // 所在省份+城市
	// 基本配置
	IsShowLoanTab: null, // 是否显示账单Tab
	isNeedLocation: false,
	serverVersion: 0, // 服务器版本
	appVersion: 0, // 缓存的版本号
	serviceMobile: '',			// 客服电话 4008086993
	serviceTime: '',			// 客服工作时间 9:00--18:00
	zmxyUse: 1, // 是否使用芝麻信用 0，不用， 1，使用
	alipayUrl: '', // 支付宝转账
	BindCardProtocol: '',
	Agreement: {
		AgeementName: '',
		AgreementUrl: ''
	},
	CenterData: {
		HasBankCard: false,	// 个人中心 用户是否已绑卡
		HasPayPwd: false,		// 个人中心 用户是否已设置交易密码
		MessageCount: 0			// 个人中心 消息数量
	}
};
export function BaseReducer (state = initialState, action) {
	switch (action.type) {
		case Types.INIT_JPUSH:
			if (action.info) {
				Storage.setJPushId((action.info.jPushId !== undefined) ? String(action.info.jPushId) : state.jPushId);
			}
			return {
				...state,
				jPushId: (action.info.jPushId !== undefined) ? action.info.jPushId : state.jPushId
			};
		case Types.LOGIN_SUCCESS:
			if (action.loginInfo) {
				Storage.setAccount((action.loginInfo.account !== undefined) ? String(action.loginInfo.account) : state.account);
				Storage.setUid((action.loginInfo.uid !== undefined) ? String(action.loginInfo.uid) : state.uid);
				Storage.setToken((action.loginInfo.token !== undefined) ? String(action.loginInfo.token) : state.token);
				Storage.setFingerKey((action.loginInfo.fingerKey !== undefined) ? String(action.loginInfo.fingerKey) : state.fingerKey);
				Storage.setLoginState((action.loginInfo.loginState !== undefined) ? String(action.loginInfo.loginState) : state.loginState);
			}
			return {
				...state,
				oldAccount: (action.loginInfo.oldAccount !== undefined) ? action.loginInfo.oldAccount : state.oldAccount,
				loginMode: (action.loginInfo.loginMode !== undefined) ? action.loginInfo.loginMode : state.loginMode,
				account: (action.loginInfo.account !== undefined) ? action.loginInfo.account : state.account,
				uid: (action.loginInfo.uid !== undefined) ? action.loginInfo.uid : state.uid,
				token: (action.loginInfo.token !== undefined) ? action.loginInfo.token : state.token,
				fingerKey: (action.loginInfo.fingerKey !== undefined) ? action.loginInfo.fingerKey : state.fingerKey,
				loginState: (action.loginInfo.loginState !== undefined) ? action.loginInfo.loginState : state.loginState
			};
		case Types.LOGOUT:
			Storage.setAccount('');
			Storage.setUid(0);
			Storage.setToken('');
			Storage.setFingerKey('');
			Storage.setLoginState(false);
			return {
				...state,
				account: '',
				uid: 0,
				token: '',
				fingerKey: '',
				loginState: false,
				CenterData: {
					HasBankCard: false,	// 个人中心 用户是否已绑卡
					HasPayPwd: false,		// 个人中心 用户是否已设置交易密码
					MessageCount: 0,		// 个人中心 消息数量
					ProblemUrl: ''
				}
			};
		case Types.SAVE_LOCATE:
			return {
				...state,
				longitudeAndLatitude: (action.address.LongitudeAndLatitude !== undefined) ? action.address.LongitudeAndLatitude : state.longitudeAndLatitude,
				location: (action.address.Location !== undefined) ? action.address.Location : state.location,
				locationDetail: (action.address.LocationDetail !== undefined) ? action.address.LocationDetail : state.locationDetail,
				ipCity: (action.address.IpCity !== undefined) ? action.address.IpCity : state.ipCity,
				ipProvince: (action.address.IpProvince !== undefined) ? action.address.IpProvince : state.ipProvince,
				ipDetailLocation: (action.address.IpDetailLocation !== undefined) ? action.address.IpDetailLocation : state.ipDetailLocation
			};
		case Types.SAVE_CONFIG:
			return {
				...state,
				appVersion: (action.config.AppVersion !== undefined) ? action.config.AppVersion : state.appVersion,
				serverVersion: (action.config.ServerVersion !== undefined) ? action.config.ServerVersion : state.serverVersion,
				isNeedLocation: (action.config.IsNeedLocation !== undefined) ? action.config.IsNeedLocation : state.isNeedLocation,
				serviceMobile: (action.config.ServiceMobile !== undefined) ? action.config.ServiceMobile : state.serviceMobile,
				serviceTime: (action.config.ServiceTime !== undefined) ? action.config.ServiceTime : state.serviceTime,
				zmxyUse: (action.config.ZmxyUse !== undefined) ? action.config.ZmxyUse : state.zmxyUse,
				alipayUrl: (action.config.AlipayUrl !== undefined) ? action.config.AlipayUrl : state.alipayUrl,
				BindCardProtocol: (action.config.BindCardProtocol !== undefined) ? action.config.BindCardProtocol : state.BindCardProtocol,
				Agreement: (action.config.Agreement !== undefined) ? action.config.Agreement : state.Agreement,
				IsShowLoanTab: (action.config.IsLoanTabShow !== undefined) ? action.config.IsLoanTabShow : state.IsShowLoanTab
			};
		case Types.UPDATE_CENTER:
			return {
				...state,
				CenterData: {
					HasBankCard: (action.data.HasBankCard !== undefined) ? action.data.HasBankCard : state.CenterData.HasBankCard,
					HasPayPwd: (action.data.HasPayPwd !== undefined) ? action.data.HasPayPwd : state.CenterData.HasPayPwd,
					MessageCount: (action.data.MessageCount !== undefined) ? action.data.MessageCount : state.CenterData.MessageCount,
					ProblemUrl: (action.data.ProblemUrl !== undefined) ? action.data.ProblemUrl : state.CenterData.ProblemUrl
				}
			};
		default:
			return state;
	}
}