package com.rrkc.UDesk;

import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.google.gson.GsonBuilder;
import com.rrkc.utils.SPUtils;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import cn.jpush.android.api.JPushInterface;
import cn.udesk.UdeskConst;
import cn.udesk.UdeskSDKManager;
import cn.udesk.model.UdeskCommodityItem;
import udesk.core.UdeskCallBack;

/**
 * Project Name:zcmjr
 * Package Name:com.xjkc.udesk
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/9/13 20:40
 */

public class UDeskModule extends ReactContextBaseJavaModule {
    private String TAG = "UdeskModule";
    private ReactApplicationContext reactApplicationContext;

    public UDeskModule(ReactApplicationContext reactContext) {
        super(reactContext);
        reactApplicationContext = reactContext;
    }

    @Override
    public String getName() {
        return "UdeskModule";
    }

    /**
     * 初始化UdeskSDK
     *
     * @param domain 域名     注意：域名不要带有http://部分
     * @param appKey 管理员后台创建应用时生成的对应app key
     * @param appId  管理员后台创建应用时生成的对应app id
     */
    @ReactMethod
    public void initialize(String domain,String appKey,String appId) {
        SPUtils.putValue(getCurrentActivity(), "domain", domain);
        SPUtils.putValue(getCurrentActivity(), "appKey", appKey);
        SPUtils.putValue(getCurrentActivity(), "appId", appId);
        UdeskSDKManager.getInstance().initApiKey(getCurrentActivity(), domain, appKey, appId);
        String registrationID = JPushInterface.getRegistrationID(getCurrentActivity());
        UdeskSDKManager.getInstance().setRegisterId(getCurrentActivity(), registrationID);
        setSdkPush("on", JPushInterface.getRegistrationID(getCurrentActivity()));
    }

    /**
     * 设置客户的信息
     *
     * @param sdkToken    识别客户的唯一标识
     * @param nickName    用户昵称
     * @param cellPhone   用户手机号
     * @param description 描述信息
     */
    @ReactMethod
    public void setUserInfo(int sdkToken, String nickName, String cellPhone, String description) {
        Log.i("设置客户的信息", sdkToken + "," + nickName + "," + cellPhone + "," + description);
        SPUtils.putValue(getCurrentActivity(), "sdkToken", sdkToken + "");
        Map<String, String> info = new HashMap<>();
        info.put(UdeskConst.UdeskUserInfo.USER_SDK_TOKEN, sdkToken + "");
        info.put(UdeskConst.UdeskUserInfo.NICK_NAME, TextUtils.isEmpty(nickName) ? "未知用户" : nickName);
        info.put(UdeskConst.UdeskUserInfo.CELLPHONE, cellPhone);
        info.put(UdeskConst.UdeskUserInfo.DESCRIPTION, description);
        UdeskSDKManager.getInstance().setUserInfo(getCurrentActivity(), sdkToken + "", info);
    }

    /**
     * 更新客户的信息
     *
     * @param nickName    用户昵称
     * @param cellPhone   用户手机号
     * @param description 描述信息
     */
    @ReactMethod
    public void updateUserInfo(String nickName, String cellPhone, String description) {
        Log.i("更新客户的信息", nickName + "," + cellPhone + "," + description);
        Map<String, String> info = new HashMap<>();
        info.put(UdeskConst.UdeskUserInfo.NICK_NAME, TextUtils.isEmpty(nickName) ? "未知用户" : nickName);
//        info.put(UdeskConst.UdeskUserInfo.CELLPHONE, cellPhone);
        info.put(UdeskConst.UdeskUserInfo.DESCRIPTION, description);
        UdeskSDKManager.getInstance().setUpdateUserinfo(info);
    }

    /**
     * 进入页面分配会话
     */
    @ReactMethod
    public void openChatView() {
        UdeskSDKManager.getInstance().entryChat(getCurrentActivity());
    }

    /**
     * 结束此次会话,
     * 如果应用内切换用户,需退出当前会话,在调用setUserInfo和开启会话的方法
     */
    @ReactMethod
    public void logoutUdesk() {
        UdeskSDKManager.getInstance().logoutUdesk();
    }

    /**
     * 获取未读消息数
     *
     * @param callback
     */
    @ReactMethod
    public void getUnreadeMessagesCount(Callback callback) {
        int unReadMsgCount = UdeskSDKManager.getInstance().getCurrentConnectUnReadMsgCount();
        callback.invoke(unReadMsgCount);
    }

    /**
     * 开启带有咨询对象的会话
     *
     * @param message 咨询对象所需内容的json格式字符串
     */
    @ReactMethod
    public void openChatViewWithMessage(String message) {
        Log.i(TAG, "openChatViewWithMessage: " + message);
        if (!TextUtils.isEmpty(message)) {
            UdeskCommodityItem item = new GsonBuilder().create().fromJson(message, UdeskCommodityItem.class);
            UdeskSDKManager.getInstance().setCommodity(item);
        } else {
            UdeskSDKManager.getInstance().setCommodity(null);
        }
        openChatView();
    }

    /**
     * 开启指定分配客服的会话
     *
     * @param agentId
     */
    @ReactMethod
    public void lanuchChatByAgentId(String agentId) {
        UdeskSDKManager.getInstance().lanuchChatByAgentId(getCurrentActivity(), agentId);
        openChatView();
    }

    /**
     * 开启指定分配客服组的会话
     *
     * @param groupId
     */
    @ReactMethod
    public void lanuchChatByGroupId(String groupId) {
        UdeskSDKManager.getInstance().lanuchChatByAgentId(getCurrentActivity(), groupId);
        openChatView();
    }

    /**
     * 设置客户的头像显示
     *
     * @param url
     */
    @ReactMethod
    public void setCustomerUrl(String url) {
        if (!TextUtils.isEmpty(url))
            UdeskSDKManager.getInstance().setCustomerUrl(url);
    }

    /**
     * 删除客户聊天数据
     */
    @ReactMethod
    public void deleteMsg() {
        UdeskSDKManager.getInstance().deleteMsg();
    }

    /**
     * 断开与Udesk服务器连接
     */
    @ReactMethod
    public void disConnectXmpp() {
        UdeskSDKManager.getInstance().disConnectXmpp();
    }


    /**
     * @param status     sdk推送状态 ["on" | "off"]
     * @param registerId 机关推送注册的 Registration Id。  如果你用其它推送方案
     */
    private void setSdkPush(final String status, String registerId) {
        String domain = SPUtils.getValue(getCurrentActivity(), "domain", "");
        String appKey = SPUtils.getValue(getCurrentActivity(), "appKey", "");
        String appId = SPUtils.getValue(getCurrentActivity(), "appId", "");
        String sdkToken = SPUtils.getValue(getCurrentActivity(), "sdkToken", "");
        Log.i(TAG, "setSdkPush: " + status + "," + domain + "," + appKey + "," + appId + "," + sdkToken);
        if (TextUtils.isEmpty(domain) || TextUtils.isEmpty(appKey) || TextUtils.isEmpty(appId) || TextUtils.isEmpty(sdkToken)) {
            return;
        }
        //设置推送状态关闭
        UdeskSDKManager.getInstance().setSdkPushStatus(
                domain,
                appKey,
                sdkToken, status,
                registerId, appId, new UdeskCallBack() {
                    @Override
                    public void onSuccess(String message) {
                        Log.i(TAG, "onSuccess: " + message + "当前状态" + status);
                        try {
                            JSONObject object = new JSONObject(message);
                            if (object.has("code") && object.getString("code").equals("1000")) {
                                Log.i(TAG, "onSuccess: udesk推送开启");
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }

                    @Override
                    public void onFail(String message) {

                    }
                }
        );
    }
}
