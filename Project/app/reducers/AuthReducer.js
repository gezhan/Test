'use strict';
import { Types } from '../config';
export const initialState = {
	BaseInfo: {
		Education: '',
		Email: '',
		LiveAddress: '',
		LiveDetailAddress: '',
		LiveTime: '',
		Marriage: ''
	},
	Sm: {
		IsRZ: 0,
		VerifyRealName: '',
		Sex: '',
		IdCard: '',
		IsOcr: 0,
		IsRealName: 0,
		IsLiving: 0,
		FailTime: 0
	},
	IsBaseInfo: 0,
	IsLinkMan: 0,				// 0:未认证; 1:认证成功
	IsMobileAuth: 0,		// 0:未认证; 1:认证成功; 3:认证中; 4:认证失败
	IsBindCard: 0,			// 0:未认证; 1:认证成功
	BankInfo: {
		BankCard: '',
		BankName: ''
	},
	MobileTag: '', // 运营商认证 采用方案 1: moxie; 2: tianji
	ZmxyTag: '', // 运营商认证 采用方案 1: 启用芝麻信用; 2: 弃用芝麻信用
	IsZmAuth: 0,

	RemainDays: 0,
	CloseTime: '',
	CreditCloseDay: 0,
	Currtime: '',
	InitAudit: 0, // 1、等待系统审核 3、等待人工信审 4、授信通过 5、系统拒绝(永久关闭) 6、等待系统出额 9已推送等待授信
	OperateProtocol: '',

	// 认证或租机订单提交的限制
	UpdateContactsTime: '0', // 通讯录更新时间
	UpdateRecordsTime: '0', // 提交通讯录、短信记录时间

	// 热更新1要求加的引流相关字段
	IsPop: false,
	PopUrl: ''
};
export function AuthReducer (state = initialState, action) {
	switch (action.type) {
		case Types.UPDATE_AUTH:
			return {
				...state,
				Sm: {
					VerifyRealName: (action.data.VerifyRealName !== undefined) ? action.data.VerifyRealName : state.Sm.VerifyRealName,
					IdCard: (action.data.IdCard !== undefined) ? action.data.IdCard : state.Sm.IdCard,
					IsRZ: (action.data.IsOcr === undefined && action.data.IsRealName === undefined && action.data.IsLiving === undefined) ? state.Sm.IsRZ : ((action.data.IsOcr === 1 && action.data.IsRealName === 1 && action.data.IsLiving === 1) ? 1 : 0),
					IsOcr: (action.data.IsOcr !== undefined) ? action.data.IsOcr : state.Sm.IsOcr,
					IsRealName: (action.data.IsRealName !== undefined) ? action.data.IsRealName : state.Sm.IsRealName,
					IsLiving: (action.data.IsLiving !== undefined) ? action.data.IsLiving : state.Sm.IsLiving,
					FailTime: (action.data.FailTime !== undefined) ? action.data.FailTime : state.Sm.FailTime,
					Sex: (action.data.Sex !== undefined) ? action.data.Sex : state.Sm.Sex
				},
				BaseInfo: (action.data.BaseInfo !== undefined) ? action.data.BaseInfo : state.BaseInfo,
				IsBaseInfo: (action.data.IsBaseInfo !== undefined) ? action.data.IsBaseInfo : state.IsBaseInfo,
				IsMobileAuth: (action.data.IsMobileAuth !== undefined) ? action.data.IsMobileAuth : state.IsMobileAuth,
				IsBindCard: (action.data.IsBindCard !== undefined) ? action.data.IsBindCard : state.IsBindCard,
				BankInfo: (action.data.BankInfo !== undefined) ? action.data.BankInfo : state.BankInfo,
				IsLinkMan: (action.data.IsLinkMan !== undefined) ? action.data.IsLinkMan : state.IsLinkMan,
				MobileTag: (action.data.MobileTag !== undefined) ? action.data.MobileTag : state.MobileTag,
				ZmxyTag: (action.data.ZmxyTag !== undefined) ? action.data.ZmxyTag : state.ZmxyTag,
				IsZmAuth: (action.data.IsZmAuth !== undefined) ? action.data.IsZmAuth : state.IsZmAuth,

				RemainDays: (action.data.RemainDays !== undefined) ? action.data.RemainDays : state.RemainDays,
				CloseTime: (action.data.CloseTime !== undefined) ? action.data.CloseTime : state.CloseTime,
				CreditCloseDay: (action.data.CreditCloseDay !== undefined) ? action.data.CreditCloseDay : state.CreditCloseDay,
				Currtime: (action.data.Currtime !== undefined) ? action.data.Currtime : state.Currtime,
				InitAudit: (action.data.InitAudit !== undefined) ? action.data.InitAudit : state.InitAudit,
				OperateProtocol: (action.data.OperateProtocol !== undefined) ? action.data.OperateProtocol : state.OperateProtocol,

				IsPop: (action.data.IsPop !== undefined) ? action.data.IsPop : state.IsPop,
				PopUrl: (action.data.PopUrl !== undefined) ? action.data.PopUrl : state.PopUrl
			}
		case Types.LOGOUT:
			return {
				BaseInfo: {
					Education: '',
					Email: '',
					LiveAddress: '',
					LiveDetailAddress: '',
					LiveTime: '',
					Marriage: ''
				},
				Sm: {
					IsRZ: 0,
					VerifyRealName: '',
					IdCard: '',
					IsOcr: 0,
					IsRealName: 0,
					IsLiving: 0,
					FailTime: 0
				},
				IsBaseInfo: 0,
				IsLinkMan: 0,
				IsMobileAuth: 0,
				IsBindCard: 0,
				BankInfo: {
					BankCard: '',
					BankName: ''
				},
				MobileTag: '',
				ZmxyTag: '',
				IsZmAuth: 0,

				RemainDays: 0,
				CloseTime: '',
				CreditCloseDay: 0,
				Currtime: '',
				InitAudit: 0,

				// 认证或租机订单提交的限制
				UpdateContactsTime: '0', // 通讯录更新时间
				UpdateRecordsTime: '0' // 提交通讯录、短信记录时间
			}
		case Types.UPDATE_RECORD:
			return {
				...state,
				UpdateContactsTime: (action.data.UpdateContactsTime !== undefined) ? action.data.UpdateContactsTime : state.UpdateContactsTime,
				UpdateRecordsTime: (action.data.UpdateRecordsTime !== undefined) ? action.data.UpdateRecordsTime : state.UpdateRecordsTime
			}
		default:
			return state;
	}
}