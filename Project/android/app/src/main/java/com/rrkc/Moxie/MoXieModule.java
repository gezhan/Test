package com.rrkc.Moxie;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.util.Log;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.google.gson.GsonBuilder;
import com.moxie.client.exception.MoxieException;
import com.moxie.client.manager.MoxieCallBack;
import com.moxie.client.manager.MoxieCallBackData;
import com.moxie.client.manager.MoxieContext;
import com.moxie.client.manager.MoxieSDK;
import com.moxie.client.model.MxLoginCustom;
import com.moxie.client.model.MxParam;
import com.moxie.client.model.TitleParams;
import com.rrkc.R;

import java.util.HashMap;
import java.util.Map;

public class MoXieModule extends ReactContextBaseJavaModule implements ActivityEventListener {
    private static final String TAG = "MoXieModule";
    private Callback mCallBack;

    private String mThemeColor = "#4e89eb"; //页面主色调
    private String mBannerTxtContent = "";  //标题栏的文字描述
    private ReactApplicationContext mContext;

    public MoXieModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.mContext = reactContext;
        this.mContext.addActivityEventListener(this);
    }

    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {

    }

    @Override
    public void onNewIntent(Intent intent) {

    }

    @Override
    public String getName() {
        return "MoXieModule";
    }

    @ReactMethod
    public void MoxieAuth(final ReadableMap readableMap, final Callback callback) {
        getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                mCallBack = callback;
                MxParam mxParam = new MxParam();
                if (readableMap.hasKey("key")) {
                    mxParam.setApiKey(readableMap.getString("key"));
                }
                if (readableMap.hasKey("uid")) {
                    mxParam.setUserId(readableMap.getString("uid"));
                }
//        mxParam.setBannerBgColor(mBannerBgColor);   // SDK里Banner的背景色
//        mxParam.setBannerTxtColor(mBannerTxtColor); // SDK里Banner的字体颜色
//        mxParam.setBannerTxtContent(mBannerTxtContent); // SDK里Banner的文字描述
                mxParam.setThemeColor(mThemeColor);      // SDK里页面主色调
                mxParam.setCallbackTaskInfo(true);
                if (readableMap.hasKey("agreementUrl")) {
                    mxParam.setAgreementUrl(readableMap.getString("agreementUrl"));    // SDK里显示的用户使用协议
                }
                if (readableMap.hasKey("type")) {
                    switch (readableMap.getString("type")) {
                        case "carrier":
                            mBannerTxtContent = "运营商认证";
                            mxParam.setTaskType(MxParam.PARAM_TASK_CARRIER); // 功能名
                            mxParam.setAgreementEntryText("同意《人人好信手机运营商授权协议》"); // SDK里显示的同意协议描述语
                            break;
                        case "fund":
                            mBannerTxtContent = "公积金认证";
                            mxParam.setTaskType(MxParam.PARAM_TASK_FUND); // 功能名
                            mxParam.setAgreementEntryText("同意《人人好信公积金授权协议》"); // SDK里显示的同意协议描述语
                            break;
                        case "alipay":
                            mBannerTxtContent = "支付宝认证";
                            mxParam.setTaskType(MxParam.PARAM_TASK_ALIPAY); // 功能名
                            mxParam.setAgreementEntryText("同意《有个金窝支付宝授权协议》"); // SDK里显示的同意协议描述语
                            break;
                    }
                }
                TitleParams titleParams = new TitleParams.Builder()
                        .title(mBannerTxtContent)
                        .titleColor(Color.parseColor("#ffffff"))
                        .backgroundColor(getCurrentActivity().getResources().getColor(R.color.main_color))
                        .build();
                mxParam.setTitleParams(titleParams);
                mxParam.setQuitOnFail(MxParam.PARAM_COMMON_NO);  // 爬取失败时是否退出SDK(登录阶段之后)
                mxParam.setCacheDisable(MxParam.PARAM_COMMON_YES);  //是否使用缓存。默认账号会记住，密码不会记住。如果设置YES，则不会有任何缓存
                mxParam.setLoadingViewText("验证过程中不会浪费您任何流量\n请稍等片刻"); //设置采集进度页面加载商户自定义文字
//        mxParam.setQuitDisable(true);//设置导入过程中，触发返回键或者点击actionbar的返回按钮的时候，不执行魔蝎的默认行为。
//        mxParam.setQuitLoginDone(MxParam.PARAM_COMMON_YES); //登录成功后可以提前退出
                //手机号、身份信息预填
                MxLoginCustom loginCustom = new MxLoginCustom();
                Map<String, Object> loginParam = new HashMap<>();
                if (readableMap.hasKey("name")) {
                    loginParam.put("name", readableMap.getString("name"));               // 姓名
                }
                if (readableMap.hasKey("idcard")) {
                    loginParam.put("idcard", readableMap.getString("idcard"));  // 身份证
                }
                if (readableMap.hasKey("phone")) {
                    loginParam.put("phone", readableMap.getString("phone"));          // 手机号
                }
                loginCustom.setEditable(MxParam.PARAM_COMMON_NO);
                loginCustom.setLoginParams(loginParam);
                mxParam.setLoginCustom(loginCustom);
                MoxieSDK.getInstance().start(getCurrentActivity(), mxParam, new MoxieCallBack() {
                    /**
                     *
                     *  物理返回键和左上角返回按钮的back事件以及sdk退出后任务的状态都通过这个函数来回调
                     *
                     * @param moxieContext       可以用这个来实现在魔蝎的页面弹框或者关闭魔蝎的界面
                     * @param moxieCallBackData  我们可以根据 MoxieCallBackData 的code来判断目前处于哪个状态，以此来实现自定义的行为
                     * @return 返回true表示这个事件由自己全权处理，返回false会接着执行魔蝎的默认行为(比如退出sdk)
                     *
                     *   # 注意，假如设置了MxParam.setQuitOnLoginDone(MxParam.PARAM_COMMON_YES);
                     *   登录成功后，返回的code是MxParam.ResultCode.IMPORTING，不是MxParam.ResultCode.IMPORT_SUCCESS
                     */
                    @Override
                    public boolean callback(MoxieContext moxieContext, MoxieCallBackData moxieCallBackData) {
                        /**
                         *  # MoxieCallBackData的格式如下：
                         *  1.1.没有进行账单导入，未开始！(后台没有通知)
                         *      "code" : MxParam.ResultCode.IMPORT_UNSTART, "taskType" : "mail", "taskId" : "", "message" : "", "account" : "", "loginDone": false, "businessUserId": ""
                         *  1.2.平台方服务问题(后台没有通知)
                         *      "code" : MxParam.ResultCode.THIRD_PARTY_SERVER_ERROR, "taskType" : "mail", "taskId" : "", "message" : "", "account" : "xxx", "loginDone": false, "businessUserId": ""
                         *  1.3.魔蝎数据服务异常(后台没有通知)
                         *      "code" : MxParam.ResultCode.MOXIE_SERVER_ERROR, "taskType" : "mail", "taskId" : "", "message" : "", "account" : "xxx", "loginDone": false, "businessUserId": ""
                         *  1.4.用户输入出错（密码、验证码等输错且未继续输入）
                         *      "code" : MxParam.ResultCode.USER_INPUT_ERROR, "taskType" : "mail", "taskId" : "", "message" : "密码错误", "account" : "xxx", "loginDone": false, "businessUserId": ""
                         *  2.账单导入失败(后台有通知)
                         *      "code" : MxParam.ResultCode.IMPORT_FAIL, "taskType" : "mail",  "taskId" : "ce6b3806-57a2-4466-90bd-670389b1a112", "account" : "xxx", "loginDone": false, "businessUserId": ""
                         *  3.账单导入成功(后台有通知)
                         *      "code" : MxParam.ResultCode.IMPORT_SUCCESS, "taskType" : "mail",  "taskId" : "ce6b3806-57a2-4466-90bd-670389b1a112", "account" : "xxx", "loginDone": true, "businessUserId": "xxxx"
                         *  4.账单导入中(后台有通知)
                         *      "code" : MxParam.ResultCode.IMPORTING, "taskType" : "mail",  "taskId" : "ce6b3806-57a2-4466-90bd-670389b1a112", "account" : "xxx", "loginDone": true, "businessUserId": "xxxx"
                         *
                         *  code           :  表示当前导入的状态
                         *  taskType       :  导入的业务类型，与MxParam.setTaskType()传入的一致
                         *  taskId         :  每个导入任务的唯一标识，在登录成功后才会创建
                         *  message        :  提示信息
                         *  account        :  用户输入的账号
                         *  loginDone      :  表示登录是否完成，假如是true，表示已经登录成功，接入方可以根据此标识判断是否可以提前退出
                         *  businessUserId :  第三方被爬取平台本身的userId，非商户传入，例如支付宝的UserId
                         */
                        if (moxieCallBackData != null) {
                            Log.d("BigdataFragment", "MoxieSDK Callback Data : " + moxieCallBackData.toString());
                            WritableMap map = Arguments.createMap();
                            map.putString("code", moxieCallBackData.getCode() + "");
                            map.putString("taskType", moxieCallBackData.getTaskType());
                            map.putString("taskId", moxieCallBackData.getTaskId());
                            map.putString("message", moxieCallBackData.getMessage());
                            map.putString("account", moxieCallBackData.getAccount());
                            map.putString("result", moxieCallBackData.getResult());
                            map.putString("businessUserId", moxieCallBackData.getBusinessUserId());
                            map.putString("appendResult", moxieCallBackData.getAppendResult());
                            map.putBoolean("loginDone", moxieCallBackData.isLoginDone());
                            switch (moxieCallBackData.getCode()) {
                                /**
                                 * 账单导入中
                                 *
                                 * 如果用户正在导入魔蝎SDK会出现这个情况，如需获取最终状态请轮询贵方后台接口
                                 * 魔蝎后台会向贵方后台推送Task通知和Bill通知
                                 * Task通知：登录成功/登录失败
                                 * Bill通知：账单通知
                                 */
                                case MxParam.ResultCode.IMPORTING:
                                    if (moxieCallBackData.isLoginDone()) {
                                        //状态为IMPORTING, 且loginDone为true，说明这个时候已经在采集中，已经登录成功
//                                Log.d(TAG, "任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
                                    } else {
                                        //状态为IMPORTING, 且loginDone为false，说明这个时候正在登录中
//                                Log.d(TAG, "任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
                                    }
                                    if (mCallBack != null) {
                                        mCallBack.invoke(MxParam.ResultCode.IMPORTING, map);
                                        mCallBack = null;
                                    }
                                    moxieContext.finish();
                                    break;
                                /**
                                 * 任务还未开始
                                 *
                                 * 假如有弹框需求，可以参考 {@link BigdataFragment#showDialog(MoxieContext)}
                                 *
                                 * example:
                                 *  case MxParam.ResultCode.IMPORT_UNSTART:
                                 *      showDialog(moxieContext);
                                 *      return true;
                                 * */
                                case MxParam.ResultCode.IMPORT_UNSTART:
                                    if (mCallBack != null) {
                                        mCallBack.invoke(MxParam.ResultCode.IMPORT_UNSTART, map);
                                        mCallBack = null;
                                    }
                                    moxieContext.finish();
                                    //任务未开始;
                                    break;
                                case MxParam.ResultCode.THIRD_PARTY_SERVER_ERROR:
                                    //导入失败(平台方服务问题)
                                    if (mCallBack != null) {
                                        mCallBack.invoke(MxParam.ResultCode.THIRD_PARTY_SERVER_ERROR, map);
                                        mCallBack = null;
                                    }
                                    break;
                                case MxParam.ResultCode.MOXIE_SERVER_ERROR:
                                    if (mCallBack != null) {
                                        mCallBack.invoke(MxParam.ResultCode.MOXIE_SERVER_ERROR, map);
                                        mCallBack = null;
                                    }
                                    //导入失败(魔蝎数据服务异常)
                                    break;
                                case MxParam.ResultCode.USER_INPUT_ERROR:
                                    //导入失败 + moxieCallBackData.getMessage()
                                    if (mCallBack != null) {
                                        mCallBack.invoke(MxParam.ResultCode.USER_INPUT_ERROR, map);
                                        mCallBack = null;
                                    }
                                    break;
                                case MxParam.ResultCode.IMPORT_FAIL:
                                    //导入失败
                                    if (mCallBack != null) {
                                        mCallBack.invoke(MxParam.ResultCode.IMPORT_FAIL, map);
                                        mCallBack = null;
                                    }
                                    break;
                                case MxParam.ResultCode.IMPORT_SUCCESS:
                                    //任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态
                                    //导入成功
                                    if (mCallBack != null) {
                                        mCallBack.invoke(MxParam.ResultCode.IMPORT_SUCCESS, map);
                                        mCallBack = null;
                                    }
                                    moxieContext.finish();
                                    return true;
                            }
                        }
                        return false;
                    }

                    /**
                     * @param moxieContext    可能为null，说明还没有打开魔蝎页面，使用前要判断一下
                     * @param moxieException  通过exception.getExceptionType();来获取ExceptionType来判断目前是哪个错误
                     */
                    @Override
                    public void onError(MoxieContext moxieContext, MoxieException moxieException) {
                        super.onError(moxieContext, moxieException);
                        if (mCallBack != null) {
                            mCallBack.invoke(1000000, moxieException.getExceptionType(), moxieException.getMessage());
                            mCallBack = null;
                        }
                    }
                });
            }
        });
    }

    private void showDialog(final MoxieContext context, final String moxieCallBackData) {
        //Dialog等引用了MoxieContext.getContext的组件，要及时解除引用，不然容易发生内存泄露
        DialogInterface.OnClickListener okListenr = new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                if (mCallBack != null) {
                    mCallBack.invoke(-1, moxieCallBackData);
                    mCallBack = null;
                }
                dialog.dismiss();
                dialog.cancel();
                dialog = null;
                context.finish();
            }
        };
        AlertDialog mDialog = new AlertDialog.Builder(context.getContext()).setMessage("确定要返回？").setPositiveButton("确定", okListenr).setNegativeButton("取消", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {

            }
        }).show();
    }
}