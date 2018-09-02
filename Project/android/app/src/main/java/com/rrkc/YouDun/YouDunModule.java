package com.rrkc.YouDun;

import android.util.Log;

import com.authreal.api.AuthBuilder;
import com.authreal.api.FormatException;
import com.authreal.api.OnResultListener;
import com.authreal.component.AuthComponentFactory;
import com.authreal.component.CompareItemFactory;
import com.authreal.component.CompareItemSession;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.google.gson.GsonBuilder;
import com.rrkc.YouDun.bean.BeanLiveAndCompaireParams;
import com.rrkc.YouDun.bean.BeanORCCallBack;
import com.rrkc.YouDun.bean.BeanOrcParams;
import com.rrkc.YouDun.bean.BeanPlusCallback;
import com.rrkc.YouDun.bean.BeanResult;
import com.rrkc.YouDun.bean.BeanTrueNameParams;

import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;

public class YouDunModule extends ReactContextBaseJavaModule {
    private static final String TAG = "YouDunModule";
    private Callback mCallBack;
    private String mLivingResult;

    public YouDunModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "YouDunModule";
    }

    /**
     * 获取AuthBuilder。
     * 请在每次调用前获取新的AuthBuilder
     * 一个AuthBuilder 不要调用两次start()方法
     *
     * @return
     */
    private AuthBuilder getAuthBuilder(String publicKey, String signTime, String sign, String infOrder) {
        // 订单号商户自己生成：不超过36位，非空，不能重复
        String partner_order_id = infOrder;
        //商户pub_key ： 开户时通过邮件发送给商户
        String pubKey = publicKey;
//        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        //签名时间：有效期5分钟，请每次重新生成 :签名时间格式：yyyyMMddHHmmss
//        String sign_time = simpleDateFormat.format(new Date());
        // 商户 security_key  ：  开户时通过邮件发送给商户
//        String security_key = secretKey;
        // 签名规则
//        String singStr = "pub_key=" + pubKey + "|partner_order_id=" + partner_order_id + "|sign_time=" + sign_time + "|security_key=" + security_key;
        //生成 签名
//        String sign = Md5.encrypt(singStr);
        /** 以上签名 请在服务端生成，防止key泄露 */

        AuthBuilder authBuilder = new AuthBuilder(partner_order_id, pubKey, signTime, sign, new OnResultListener() {
            BeanResult beanResult = new BeanResult();

            @Override
            public void onResult(int op_type, String result) {
                Log.e("MainActivity:result", op_type + "//" + result);
                try {
                    JSONObject jsonObject = new JSONObject(result);

                    if (jsonObject.has("success") && jsonObject.getString("success").equals("true")) {
                        /** 业务处理成功 ，可以根据不同的模块 处理数据 */
                        switch (op_type) {
                            case AuthBuilder.OPTION_ERROR:
                                //// TODO:  error
                                break;
                            case AuthBuilder.OPTION_OCR:
                                //// TODO:  OCR扫描 回调
                                mCallBack.invoke(result);
                                break;
                            case AuthBuilder.OPTION_VERIFY:
                                //// TODO:  实名验证 回调
//                                beanResult = new GsonBuilder().create().fromJson(result,BeanResult.class);
//                                sID = beanResult.getSession_id();
                                mCallBack.invoke(result);
                                break;
                            case AuthBuilder.OPTION_LIVENESS:
                                //// TODO:  活体 回调
                                mLivingResult = result;
                                break;
                            case AuthBuilder.OPTION_COMPARE:
                                //// TODO:  人像比对 回调
                                BeanPlusCallback beanPlusCallback = new BeanPlusCallback();
                                beanPlusCallback.setLiving(mLivingResult);
                                beanPlusCallback.setFace(result);
                                JSONObject object = new JSONObject();
                                object.put("Face", new JSONObject(beanPlusCallback.getFace()));
                                object.put("Living", new JSONObject(beanPlusCallback.getLiving()));
                                mCallBack.invoke(object.toString());
                                break;
                            case AuthBuilder.OPTION_VIDEO:
                                //// TODO:  视频存证 回调
                                break;
                        }

                    } else {
                        BeanORCCallBack beanORCCallBack = new GsonBuilder().create().fromJson(result, BeanORCCallBack.class);
                        String message = jsonObject.getString("message");
                        String errorcode = jsonObject.getString("errorcode");
                        if (message.equals("用户取消验证!") || beanORCCallBack.getErrorcode().equals("900001")) {
                            mCallBack.invoke("");
                        } else {
                            mCallBack.invoke(result);
                        }

                        /** 打印错误日志，可根据文档定位问题 */
                        Log.d("MainActivity", errorcode + ":" + message);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });

        return authBuilder;
    }

    /**
     * 安卓ORC认证
     *
     * @param params
     * @param orcCallback
     */
    @ReactMethod
    public void getORCandroid(String params, Callback orcCallback) {
        mCallBack = orcCallback;
        BeanOrcParams beanOrcParams = new GsonBuilder().create().fromJson(params, BeanOrcParams.class);
        getAuthBuilder(beanOrcParams.getPubKey(), beanOrcParams.getSignTime(), beanOrcParams.getSign(), beanOrcParams.getInfOrder())
                /** 添加 身份证ocr识别 模块 */
                .addFollow(AuthComponentFactory.getOcrComponenet()
                                /**设置展示确认页面 ： 非必需 */
                                .showConfirm(true)
                                /**设置展示确认页面 ： 非必需 */
                                .mosaicIdName(false)
                                /**设置展示确认页面 ： 非必需 */
                                .mosaicIdNumber(false)
                                /**设置异步通知地址 ： 非必需 */
                                .setNotifyUrl(beanOrcParams.getNotifyUrl())
                        //更多设置项目参见文档：http://static.udcredit.com/doc/idsafe/android/V43/index.html
                ).start(getCurrentActivity());
    }

    /**
     * 安卓实名检测认证
     *
     * @param params
     * @param trueNameCallback
     */
    @ReactMethod
    public void getTrueNameAndroid(String params, Callback trueNameCallback) {
        mCallBack = trueNameCallback;
        BeanTrueNameParams beanTrueNameParams = new GsonBuilder().create().fromJson(params, BeanTrueNameParams.class);
        /** 获取AuthBuilder对象 请每次开始流程获取最新对象 */
        try {
            getAuthBuilder(beanTrueNameParams.getPubKey(), beanTrueNameParams.getSignTime(), beanTrueNameParams.getSign(), beanTrueNameParams.getInfOrder())
                    /** 添加 实名验证 模块 */
                    .addFollow(AuthComponentFactory.getVerifyComponent()
                            .setNameAndNumber(beanTrueNameParams.getUserName(), beanTrueNameParams.getCard())
                            /** true:人像验证(可作为比对源参与比对) false:简项验证 */
                            .needGridPhoto(true)
                            /**设置异步通知地址 ： 非必需 */
                            .setNotifyUrl(beanTrueNameParams.getNotifyUrl())).start(getCurrentActivity());
        } catch (FormatException e) {
            e.printStackTrace();
        }
    }

    /**
     * android活体检测 人脸对比
     *
     * @param params
     * @param liveCallback
     */
    @ReactMethod
    public void getLiveAndCompaierAndroid(String params, Callback liveCallback) {
        mCallBack = liveCallback;
        /** 获取AuthBuilder对象 请每次开始流程获取最新对象 */
        BeanLiveAndCompaireParams beanLiveAndCompaireParams = new GsonBuilder().create().fromJson(params, BeanLiveAndCompaireParams.class);
        getAuthBuilder(beanLiveAndCompaireParams.getPubKey(), beanLiveAndCompaireParams.getSignTime(), beanLiveAndCompaireParams.getSign(), beanLiveAndCompaireParams.getInfOrder())
                /** 添加 活体检测 模块 */
                .addFollow(AuthComponentFactory.getLivingComponent()
                                /** 声音开关 */
                                .setVoiceEnable(false)
                                /**设置异步通知地址 ： 非必需 */
                                .setNotifyUrl(beanLiveAndCompaireParams.getNotifyUrl())
                        //更多设置项目参见文档：http://static.udcredit.com/doc/idsafe/android/V43/index.html
                )

                /** 添加 人脸比对 模块 */
                .addFollow(AuthComponentFactory.getCompareComponent()
                        .setCompareItemA(CompareItemFactory.getCompareItemBySessioId(CompareItemSession.SessionType.PHOTO_LIVING))
                        .setCompareItemB(CompareItemFactory.getCompareItemBySessioId(beanLiveAndCompaireParams.getSession_id(), CompareItemSession.SessionType.PHOTO_IDENTIFICATION))
                        /**设置异步通知地址 ： 非必需 */
                        .isGrid(true)
                        .setNotifyUrl(beanLiveAndCompaireParams.getNotifyUrl()))
                /** 开始流程 */
                .start(getCurrentActivity());
    }
}