'use strict';
import { Types } from '../config';
export const initialState = {
	BannerActivity: null, // Banner
	FloatActivity: null, // 浮动窗口
	HomeActivity: null, // 首页活动弹窗
	HomeImg: '', // 首页表盘
	Loan: null,	// 最近一笔待还款的租机订单
	CreditValue: 0, // 认证状态  1.授信审核中，2.用户授信通过，3.用户授信未通过，4.用户第一笔取现还清之后，5.跳信用详情页面
	CreditAllow: false, // 是否允许借款
	Skip: false, // 全局开关，true打开，false关闭
	CreditScore: 0, // 风险分数
	CreditDate: '', // 评估时间
	CreditDesc: '', // 提示语句
	UserInfo: null, // 用户基本信息
	Home: {
		MobileUrl: '',
		RentProcess: ''
	},
	InformBar: {
		CreateTime: '',
		BeginTime: '',
		EndTime: '',
		Content: '',
		Description: '',
		IsDisplay: false,
		SkipUrl: '',
		Title: ''
	}
};
export function HomeReducer (state = initialState, action) {
	switch (action.type) {
		case Types.SAVE_HOME:
			return {
				...state,
				BannerActivity: (action.home.BannerActivity !== undefined) ? action.home.BannerActivity : state.BannerActivity,
				FloatActivity: (action.home.FloatActivity !== undefined) ? action.home.FloatActivity : state.FloatActivity,
				HomeActivity: (action.home.HomeActivity !== undefined) ? action.home.HomeActivity : state.HomeActivity,
				HomeImg: (action.home.Home.IndexUrl !== undefined) ? action.home.Home.IndexUrl : state.IndexUrl,
				Loan: (action.home.Loan !== undefined) ? action.home.Loan : state.Loan,
				Home: (action.home.Home !== undefined) ? action.home.Home : state.Home,
				InformBar: (action.home.InformBar !== undefined) ? action.home.InformBar : state.InformBar,
				CreditValue: (action.home.CreditValue !== undefined) ? action.home.CreditValue : state.CreditValue,
				CreditAllow: (action.home.CreditAllow) ? action.home.CreditAllow : state.CreditAllow,
				Skip: (action.home.Skip) ? action.home.Skip : state.Skip,
				CreditScore: (action.home.CreditScore !== undefined) ? action.home.CreditScore : state.CreditScore,
				CreditDate: (action.home.CreditDate !== undefined) ? action.home.CreditDate : state.CreditDate,
				CreditDesc: (action.home.CreditDesc !== undefined) ? action.home.CreditDesc : state.CreditDesc,
				UserInfo: (action.home.UserInfo !== undefined) ? action.home.UserInfo : state.UserInfo
			};
		default:
			return state;
	}
}