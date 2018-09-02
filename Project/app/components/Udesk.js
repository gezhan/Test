import { Platform, NativeModules } from 'react-native';

const Domain = '13757160670.udesk.cn';//
const AppKey = '84cf1b72d243d19999b9b6ad443fd739';
const AppId = 'd3f8f66b48bf52a1';

const Udesk = NativeModules.UdeskModule;
// 初始化
export function Initialize (userInfo) {
	if (Platform.OS === 'ios') {
		let config = {
			Domain: Domain,
			AppKey: AppKey,
			AppId: AppId
		};
		let nickName = '';
		if (userInfo.Name && userInfo.Name !== '' && userInfo.Name.length > 1) {
			nickName = userInfo.Name.substr(0, 1) + (userInfo.Sex === '' ? userInfo.Name.substr(1) : userInfo.Sex === '男' ? '先生-' : '女士-') + userInfo.account
		} else {
			nickName = '有个金窝-' + userInfo.account
		}

		let customer = {
			sdkToken: userInfo.uid + '',
			nickName: nickName,
			cellphone: userInfo.account,
			customerDescription: '有个金窝用户' + userInfo.uid
		};

		Udesk.Initialize(JSON.stringify(config), JSON.stringify(customer))
	} else {
		let nickName = '';
		if (userInfo.Name && userInfo.Name !== '' && userInfo.Name.length > 1) {
			nickName = userInfo.Name.substr(0, 1) + (userInfo.Sex === '' ? userInfo.Name.substr(1) : userInfo.Sex === '男' ? '先生-' : '女士-') + userInfo.account
		} else {
			nickName = '有个金窝-' + userInfo.account
		}

		Udesk.initialize(Domain, AppKey, AppId);
		Udesk.setUserInfo(userInfo.uid, nickName, userInfo.account, '有个金窝用户' + userInfo.uid)
	}
}
// 更新用户信息
export function UpdateCustomerInfo (userInfo) {
	if (Platform.OS === 'ios') {
		let nickName = '';
		if (userInfo.Name && userInfo.Name !== '' && userInfo.Name.length > 1) {
			nickName = userInfo.Name.substr(0, 1) + (userInfo.Sex === '' ? userInfo.Name.substr(1) : userInfo.Sex === '男' ? '先生' : '女士')
		}

		let customer = {
			sdkToken: userInfo.uid,
			nickName: nickName,
			cellphone: userInfo.account,
			customerDescription: '有个金窝用户' + userInfo.uid
		};

		Udesk.UpdateCustomerInfo(JSON.stringify(customer))
	} else {
		let nickName = '';
		if (userInfo.Name && userInfo.Name !== '' && userInfo.Name.length > 1) {
			nickName = userInfo.Name.substr(0, 1) + (userInfo.Sex === '' ? userInfo.Name.substr(1) : userInfo.Sex === '男' ? '先生' : '女士')
		}
		Udesk.logoutUdesk();
		Udesk.setUserInfo(userInfo.uid, nickName, userInfo.account, '有个金窝用户' + userInfo.uid)
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