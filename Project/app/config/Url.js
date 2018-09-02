'use strict';
/**
 * 初始化
 * */
// ip定位 请求地址
export const IP_LOCATING = 'https://restapi.amap.com/v3/ip';
// app更新接口
export const UPDATE = 'config';
// 配置参数
export const CONFIG = 'config/parameter';
/**
 * 登录
 * */
// 查询账号是否已注册
export const CHECK_REGISTE = 'users/isexist/account';
// 注册获取验证码接口
export const REGIST_VCODE = 'users/vcode/send';
// 注册接口
export const REGISTERED = 'users/register';
// 登录接口
export const LOGIN = 'users/login';
// 获取登录验证码
export const GET_LOGIN_CODE = 'users/login/vcode';
// 找回登录密码获取验证码接口
export const GET_FIND_VCODE = 'users/update/vcode';
// // 找回登录密码提交参数接口
// export const FIND_PASSWORD = 'users/update';
// 设置登录密码
export const SET_PASSWORD = 'users/set/loginpwd';
// 找回或者修改登录密码
export const UPDAGE_LOGINPWD = 'users/update/loginpwd';
/**
 * 首页
 * */
// 首页接口
export const INDEX = 'index/';
// 申请借款
export const PRODUCT = 'product/type';
/**
 * 借款
 * */
//
export const REPORT_DETAIL = 'creditinfo';
// 是否满足借款条件
export const LOAN_CONTROL = 'loan/control';
// 借款接口
export const SUBMIT_RENT = 'loan/request';
// 检查是否已经设置了交易密码
export const ISEXIST_PAYPWD = 'usersmetadata/issetpwd';
// 检查是否已经设置了交易密码
export const SET_PAYPWD = 'usersmetadata/setpwd/';
// 判断用户手机通话记录、短信记录
export const SUBMIT_CALLSMS = 'linkman/callsms';
/**
 * 账单
 * */
// 查看用户订单列表或历史订单
export const LOAN_RECORD = 'loan/record';
// 账单中心接口
export const LOAN_CENTER = 'loan/situation';
// 借款详情接口
export const LOAN_DETAIL = 'loan/detail';
/**
 * 连连还款
 * */
// 生成还款对象--还款第一步
export const REPAYMENT_CREATE = 'loan/repayment';
// 连连正常还款-发送验证码
export const POST_SEND_LLCODE = 'repayment/llprerepayment';
// 连连第二次以后的验证码
export const POST_RESEND_LLCODE = 'repayment/sendvcode';
// 连连超过136%的走的还款接口
export const POST_LL_REPAYMENT = 'repayment/llrepayment';
/**
 * 认证中心
 * */
// zm
export const ZM = 'usersmetadata/zmauth'
// 获取 所属银行列表
export const BANKCARD_CONFIG = 'bankcard/config'
// 获取 所属银行列表
export const CHECKBANK = 'usersbkcard/checkbyapi'
// 提交绑卡
export const BINDCARD = 'usersbkcard/bindcardbyapi'
// 获取银行卡信息
export const BANKCARD = 'usersbkcard/bankcard'

// 上传/更新 通讯录
export const UPDATE_MAILLIST = 'linkman/maillist'
// 上传/更新 紧急联系人
export const UPDATE_LINKMAN = 'linkman/updatelinkman'
// 获取 紧急联系人
export const GET_LINKMAN = 'linkman/linkman'

// 运营商认证 - 获取魔蝎的key
export const GET_TJURL = 'tianji/authen'
// 运营商认证 - 获取魔蝎的key
export const GET_MXKEY = 'usersauth/mxkey'
// 上传运营商认证
export const UPLOAD_MXYYS = 'usersauth/yysauth'

// 保存个人信息
export const BASEINFO = 'usersbase/baseinfo'
// 获取基本认证信息
export const AUTH = 'usersauth/authstate'
// 获取 实名的 签名
export const AUTH_SIGN = 'ydindentify/sign'
// 上传ocr信息
export const AUTH_ORC = 'ydindentify/ocr'
// 上传实名信息
export const AUTH_SM = 'ydindentify/auth'
// 上传活体信息
export const AUTH_HT = 'ydindentify/livings'

// 手动授额接口
export const AUTH_SUBMIT = 'usersauth/submit'
/**
 * 个人中心
 * */
// 个人中心配置接口
export const CENTER = 'config/home';
// 意见反馈
export const FEED_BACK = 'advises';
// 消息中心
export const POST_MESSAGE = 'users/getmessag';
// 修改设置交易密码时候的验证码
export const MODIFY_TRADE_SEND_VCODE = 'usersmetadata/tradevcode';
// 校验交易密码的验证码
export const CHECK_VCODE = 'usersmetadata/tradepwd/verify';
// 征信报告列表接口
export const CREDIT_INFO_LIST = 'creditinfo/record';