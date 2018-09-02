package com.rrkc.Download;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class DownloadApkModule extends ReactContextBaseJavaModule {

    public DownloadApkModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "DownloadDilaogs";
    }

    /**
     * 显示下载新版本的更新进度条
     */
    @ReactMethod
    public void showDialog(boolean mandatory, String downloadUrl, String versionName, final Callback callback) {
        DownloadApk downloadApk = new DownloadApk(mandatory, downloadUrl, versionName,
                new DownloadApk.DownloadApkCallBack() {
                    @Override
                    public void onCallBack(int status) {
                        if (status == 1) {
                            callback.invoke(1, "下载弹框消失不需要退出程序");
                        } else if (status == 2) {
                            callback.invoke(2, "下载弹框消失需要退出程序");
                        }
                    }
                });
        downloadApk.showDownloadDialog(getCurrentActivity());
    }
}