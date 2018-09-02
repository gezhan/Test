package com.rrkc.Location;

import android.app.Activity;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

/**
 * Project Name:zcmjr
 * Package Name:com.xiaobu.amap
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/8/10 10:10
 */

public class AMapModule extends ReactContextBaseJavaModule {

    public AMapModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "AMap2D";
    }

    @ReactMethod
    public void RNGaoDe(Callback callback){
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            AMapActivity.start(currentActivity,callback);
        }
    }
}
