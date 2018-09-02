'use strict';
import * as WeChat from 'react-native-wechat';
import { toastShort } from './ToastUtil';
// APPID
export const APPID = 'wxeefd81ce69c97b9f';

// 注册方法
export function registerWechat () {
	WeChat.registerApp(APPID).then().catch(error => {
		console.log('error=' + error);
	});
}

// 是否安装微信
export function isInstalled (cBack) {
	WeChat.isWXAppInstalled()
		.then(isInstalled => {
			if (isInstalled) {
				cBack(true);
			} else {
				toastShort('检测到您没有安装微信');
			}
		}).catch(error => { console.log('error=' + error); });
}
// 打开微信
export function openWX () {
	console.log('99999999');
	WeChat.openWXApp();
}

// 微信好友分享-链接
export function shareWechatUrl (shareTitle, shareContent, shareUrl, cBack, thumbImage) {
	WeChat.isWXAppInstalled()
		.then(isInstalled => {
			if (isInstalled) {
				WeChat.shareToSession({
					title: shareTitle,
					description: shareContent,
					thumbImage: thumbImage,
					type: 'news',
					webpageUrl: shareUrl
				}).then(result => {
					if (result === true) {
						cBack(true, '分享成功');
					} else {
						cBack(false, '分享失败');
					}
				}).catch(error => {
					console.log(error);
					cBack(false, '分享失败');
				});
			} else {
				toastShort('检测到您没有安装微信');
			}
		}).catch(error => { console.log('error=' + error); });
}

// 微信朋友圈分享-文本
export function shareWechatMonentUrl (shareTitle, shareContent, shareUrl, cBack, thumbImage) {
	WeChat.isWXAppInstalled()
		.then(isInstalled => {
			if (isInstalled) {
				WeChat.shareToTimeline({
					title: shareTitle,
					description: shareContent,
					thumbImage: thumbImage,
					type: 'news',
					webpageUrl: shareUrl
				}).then(result => {
					if (result === true) {
						cBack(true, '分享成功');
					} else {
						cBack(false, '分享失败');
					}
				}).catch(error => {
					console.log(error);
					cBack(false, '分享失败');
				});
			} else {
				toastShort('检测到您没有安装微信');
			}
		}).catch(error => { console.log('error=' + error); });
}

// 微信好友分享-图片
export function shareWechatImageFile (shareTitle, shareContent, shareImageUrl, cBack) {
	WeChat.isWXAppInstalled()
		.then(isInstalled => {
			if (isInstalled) {
				WeChat.shareToSession({
					type: 'imageUrl',
					title: shareTitle,
					description: shareContent,
					mediaTagName: '',
					messageAction: undefined,
					messageExt: undefined,
					imageUrl: shareImageUrl
				}).then(result => {
					if (result === true) {
						cBack(true, '分享成功');
					} else {
						cBack(false, '分享失败');
					}
				}).catch(error => {
					console.log('error=' + error);
					cBack(false, '分享失败');
				});
			} else {
				toastShort('检测到您没有安装微信');
			}
		}).catch(error => { console.log('error=' + error); });
}

// 微信朋友圈分享-图片
export function shareWechatMonentImageFile (shareTitle, shareContent, shareImageUrl, cBack) {
	WeChat.isWXAppInstalled()
		.then(isInstalled => {
			if (isInstalled) {
				WeChat.shareToTimeline({
					type: 'imageUrl',
					title: shareTitle,
					description: shareContent,
					mediaTagName: '',
					messageAction: undefined,
					messageExt: undefined,
					imageUrl: shareImageUrl
				}).then(result => {
					if (result === true) {
						cBack(true, '分享成功');
					} else {
						cBack(false, '分享失败');
					}
				}).catch(error => {
					console.log('error=' + error);
					cBack(false, '分享失败');
				});
			} else {
				toastShort('检测到您没有安装微信');
			}
		}).catch(error => { console.log('error=' + error); });
}