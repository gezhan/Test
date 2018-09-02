package com.rrkc;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;
import com.rrkc.Moxie.MoXieModule;
import com.rrkc.PhoneInfo.ContactsModule;
import com.rrkc.PhoneInfo.PhoneInfoModule;
import com.rrkc.SmAntiFraud.SmDeviceModule;
import com.rrkc.SplashScreen.SplashScreenModule;
import com.rrkc.UDesk.UDeskModule;
import com.rrkc.YouDun.YouDunModule;
import com.rrkc.Download.DownloadApkModule;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class MyReactPackage implements ReactPackage {
    @Override
    public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
        return Arrays.<NativeModule>asList(
                new SplashScreenModule(reactContext),
                new MoXieModule(reactContext),
                new SmDeviceModule(reactContext),
                new RNDeviceModule(reactContext),
                new YouDunModule(reactContext),
                new PhoneInfoModule(reactContext),
                new ContactsModule(reactContext),
                new DownloadApkModule(reactContext),
                new UDeskModule(reactContext)
        );
    }
    
    @Override
    public List<Class<? extends JavaScriptModule>> createJSModules() {
        return Collections.emptyList();
    }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        return Collections.emptyList();
    }
}