package com.rrkc;

import android.app.Application;
import android.content.Context;
import android.support.multidex.MultiDex;

import com.BV.LinearGradient.LinearGradientPackage;
import com.facebook.react.ReactApplication;
import com.microsoft.codepush.react.CodePush;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;
import com.moxie.client.manager.MoxieSDK;
import com.rrkc.BqsDevice.BqsDevicePackage;
import com.rrkc.Location.AMapLocationPackage;
import com.tencent.bugly.crashreport.CrashReport;
import com.umeng.commonsdk.UMConfigure;

import java.util.Arrays;
import java.util.List;

import cn.jpush.reactnativejpush.JPushPackage;

public class MainApplication extends Application implements ReactApplication {

    private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
        private boolean SHUTDOWN_TOAST = false;
        private boolean SHUTDOWN_LOG = false;
        @Override
        protected String getJSBundleFile() {
            if (BuildConfig.DEBUG) {
                return null;
            }
            return CodePush.getJSBundleFile();
        }
    
        @Override
        public boolean getUseDeveloperSupport() {
            return BuildConfig.DEBUG;
        }

        @Override
        protected List<ReactPackage> getPackages() {
            return Arrays.<ReactPackage>asList(
                    new MainReactPackage(),
                    new CodePush("6k6_i-zyh4LAId8bOYy5yOZJJkWLba48ea16-4f15-4335-9884-d2b76ae76f38",  MainApplication.this, BuildConfig.DEBUG),
                    new MyReactPackage(),
                    new LinearGradientPackage(),
                    new AMapLocationPackage(),
                    new BqsDevicePackage(),
                    new JPushPackage(SHUTDOWN_TOAST,SHUTDOWN_LOG)
            );
        }
    };

    @Override
    public ReactNativeHost getReactNativeHost() {
        return mReactNativeHost;
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();
        SoLoader.init(this, /* native exopackage */ false);
        UMConfigure.init(this, UMConfigure.DEVICE_TYPE_PHONE, "");
        CrashReport.initCrashReport(getApplicationContext(), "b547652fb8", false);
        MoxieSDK.init(this);
    }
}