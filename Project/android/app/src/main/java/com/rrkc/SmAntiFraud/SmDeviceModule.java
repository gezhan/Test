package com.rrkc.SmAntiFraud;

import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.ishumei.smantifraud.SmAntiFraud;

import javax.annotation.Nullable;

/**
 * Project Name:MPR
 * Package Name:com.rrkc.SmAntiFraud
 * Class Description:
 * Created By:firecloud
 * Created Time:2018/5/11 19:29
 */

public class SmDeviceModule extends ReactContextBaseJavaModule {
    private static byte mStatus = 0;
    private ReactApplicationContext mReactApplicationContext;

    public SmDeviceModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mReactApplicationContext = reactContext;
    }

    @Override
    public String getName() {
        return "SmAntiFraud";
    }

    /**
     * 取得当前进程名
     *
     * @param context
     * @return
     */
    private String getCurProcessName(Context context) {
        int pid = android.os.Process.myPid();
        ActivityManager mActivityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningAppProcessInfo appProcess : mActivityManager.getRunningAppProcesses()) {
            if (appProcess.pid == pid) {
                return appProcess.processName;
            }
        }
        return null;
    }

    @ReactMethod
    public void init(ReadableMap readableMap) {
        Log.e(getName(), "PackageName:" + mReactApplicationContext.getPackageName());
        Log.e(getName(), "CurProcessName:" + getCurProcessName(mReactApplicationContext));
        if (getCurProcessName(mReactApplicationContext).equals(mReactApplicationContext.getPackageName())) {
            SmAntiFraud.SmOption option = new SmAntiFraud.SmOption();
            if (readableMap.hasKey("organization")) {
                option.setOrganization(readableMap.getString("organization"));
            }
            if (readableMap.hasKey("channel")) {
                option.setChannel(readableMap.getString("channel"));//渠道代码
            }
            // 可选的方式，deviceId拉取成功的事件监听，异步方式
            SmAntiFraud.registerServerIdCallback(new SmAntiFraud.IServerSmidCallback() {
                @Override
                public void onSuccess(String s) {
                    mStatus = 1;
                    sendEvent("onSmInit", Arguments.createMap());
                }

                @Override
                public void onError(int i) {
                    mStatus = 0;
                }
            });
            SmAntiFraud.create(mReactApplicationContext, option);
//            SmAntiFraud.getContact(SmAntiFraud.SM_AF_ASYN_MODE);
        }
    }

    @ReactMethod
    public void getSMFingerToken(Callback callback) {
        if (mStatus == 1) {
            callback.invoke(SmAntiFraud.getDeviceId());
        } else {
            callback.invoke("");
        }
    }

    private void sendEvent(String eventName, @Nullable WritableMap params) {
        if (mReactApplicationContext != null) {
            mReactApplicationContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit(eventName, params);
        }
    }
}