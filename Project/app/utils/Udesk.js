import { Platform, NativeModules } from 'react-native';

const Domain = '13757160670.udesk.cn';//
const AppKey = '1659705c197190824af5d09802336523';
const AppId = 'beda42cc7ee95aa1';

const Udesk = NativeModules.UdeskModule;
// 初始化
export function Initialize (baseInfo, authInfo) {
	if (Platform.OS === 'ios') {
		let config = {
			Domain: Domain,
			AppKey: AppKey,
			AppId: AppId
		};
		let nickName = '';
		if (authInfo.Sm.VerifyRealName && authInfo.Sm.VerifyRealName !== '' && authInfo.Sm.VerifyRealName.length > 1) {
			nickName = authInfo.Sm.VerifyRealName.substr(0, 1) + (authInfo.Sm.Sex === '' ? authInfo.Sm.VerifyRealName.substr(1) : authInfo.Sm.Sex === '男' ? '先生-' : '女士-') + baseInfo.account
		} else {
			nickName = '人人好信-' + baseInfo.account
		}

		let customer = {
			sdkToken: baseInfo.uid + '',
			nickName: nickName,
			cellphone: baseInfo.account,
			customerDescription: '人人好信用户' + baseInfo.uid
		};

		Udesk.Initialize(JSON.stringify(config), JSON.stringify(customer))
	} else {
		let nickName = '';
		if (authInfo.Sm.VerifyRealName && authInfo.Sm.VerifyRealName !== '' && authInfo.Sm.VerifyRealName.length > 1) {
			nickName = authInfo.Sm.VerifyRealName.substr(0, 1) + (authInfo.Sm.Sex === '' ? authInfo.Sm.VerifyRealName.substr(1) : authInfo.Sm.Sex === '男' ? '先生-' : '女士-') + baseInfo.account
		} else {
			nickName = '人人好信-' + baseInfo.account
		}

		Udesk.initialize(Domain, AppKey, AppId);
		Udesk.setUserInfo(baseInfo.uid, nickName, baseInfo.account, '人人好信用户' + baseInfo.uid)
	}
}

// 更新用户信息
export function UpdateCustomerInfo (baseInfo, authInfo) {
	if (Platform.OS === 'ios') {
		let nickName = '';
		if (authInfo.Sm.VerifyRealName && authInfo.Sm.VerifyRealName !== '' && authInfo.Sm.VerifyRealName.length > 1) {
			nickName = authInfo.Sm.VerifyRealName.substr(0, 1) + (authInfo.Sm.Sex === '' ? authInfo.Sm.VerifyRealName.substr(1) : authInfo.Sm.Sex === '男' ? '先生' : '女士')
		}

		let customer = {
			sdkToken: baseInfo.uid,
			nickName: nickName,
			cellphone: baseInfo.account,
			customerDescription: '人人好信用户' + baseInfo.uid
		};

		Udesk.UpdateCustomerInfo(JSON.stringify(customer))
	} else {
		let nickName = '';
		if (authInfo.Sm.VerifyRealName && authInfo.Sm.VerifyRealName !== '' && authInfo.Sm.VerifyRealName.length > 1) {
			nickName = authInfo.Sm.VerifyRealName.substr(0, 1) + (authInfo.Sm.Sex === '' ? authInfo.Sm.VerifyRealName.substr(1) : authInfo.Sm.Sex === '男' ? '先生' : '女士')
		}
		Udesk.logoutUdesk();
		Udesk.setUserInfo(baseInfo.uid, nickName, baseInfo.account, '人人好信用户' + baseInfo.uid)
	}
}
// 获取未读信息数量
export function GetUnreadeMessagesCount (callback) {
	if (Platform.OS === 'ios') {
		Udesk.GetUnreadeMessagesCount(count => {
			console.log('当前未读消息数:' + count);
			callback(count)
		})
	} else {
		Udesk.getUnreadeMessagesCount(count => {
			console.log('当前未读消息数:' + count);
			callback(count)
		})
	}
}

// 打开客服聊天
export function OpenChatView () {
	if (Platform.OS === 'ios') {
		Udesk.OpenChatView({ phone: '' })
	} else {
		Udesk.openChatView()
	}
}

// 打开客服聊天并指定咨询对象
export function OpenChatViewWithMessage (message) {
	if (Platform.OS === 'ios') {
		Udesk.OpenChatViewWithMessage(JSON.stringify(message))
	} else {
		Udesk.openChatViewWithMessage(JSON.stringify(message))
	}
}

// 设置客户的头像显示
export function SetCustomerUrl (url) {
	if (Platform.OS === 'android') {
		Udesk.setCustomerUrl(url)
	}
}

// 开启指定分配客服的会话
export function OpenChatViewByAgentId (url) {
	if (Platform.OS === 'ios') {
		Udesk.OpenChatViewWithAgentId(url)
	} else {
		Udesk.lanuchChatByAgentId(url)
	}
}

// 断开与Udesk服务器连接
export function DisConnectXmpp () {
	if (Platform.OS === 'ios') {
		Udesk.Logout()
	} else {
		Udesk.disConnectXmpp()
	}
}