package com.rrkc.BqsDevice;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.location.LocationManager;
import android.net.Uri;
import android.provider.Settings;
import android.support.annotation.NonNull;
import android.util.Log;

import com.bqs.risk.df.android.BqsDF;
import com.bqs.risk.df.android.BqsParams;
import com.bqs.risk.df.android.OnBqsDFContactsListener;
import com.bqs.risk.df.android.OnBqsDFListener;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.moxie.client.model.MxParam;

public class BqsDeviceModule extends ReactContextBaseJavaModule {
    private boolean isGatherGps = false;// 是否忽略gps
    private boolean isGatherContacts = true; // 是否采集联系人
    private boolean isGatherCallRecord = false;// 是否采集通话记录
    private boolean isGatherSMSRecord = false;// 是否采集短信记录
    private static byte mStatus = 0;
    private BqsParams params = null;
    private Callback mCallBack;

    public BqsDeviceModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "BqsDeviceModule";
    }

    /**
     * 权限授权,并初始化白骑士SDK
     */
    @ReactMethod
    public void init(ReadableMap readableMap, Callback callback) {
        final Activity currentActivity = getCurrentActivity();
        mCallBack = callback;
        if (currentActivity != null) {
            params = new BqsParams();
            // TODO 商户编号, 这里要修改为自己公司的商户编号
            if (readableMap.hasKey("partnerId")) {
                params.setPartnerId(readableMap.getString("partnerId"));
            }
            // TODO 是否采集通话记录,true:采集 ,false：不采集(默认值)
            if (readableMap.hasKey("isGatherCallRecord")) {
                isGatherCallRecord = readableMap.getBoolean("isGatherCallRecord");
                params.setGatherCallRecord(isGatherCallRecord);
            }
            // TODO 是否采集联系人信息,true:采集 ,false：不采集(默认值)
            if (readableMap.hasKey("isGatherContacts")) {
                isGatherContacts = readableMap.getBoolean("isGatherContacts");
                params.setGatherContact(isGatherContacts);
            }
            // TODO 是否忽略gps信息,true:忽略(不采集gps) false：不忽略（默认值）
            if (readableMap.hasKey("isGatherGps")) {
                isGatherGps = readableMap.getBoolean("isGatherGps");
                params.setGatherGps(isGatherGps);
            }
            // TODO 是否忽略基站信息,true:忽略(不采集gps) false：不忽略（默认值）
            if (readableMap.hasKey("isGatherBaseStation")) {
                params.setGatherBaseStation(readableMap.getBoolean("isGatherBaseStation"));
            }
            // TODO 是否采集传感器信息,true:采 集(默认值) false:不采集
            if (readableMap.hasKey("isGatherSensorInfo")) {
                params.setGatherSensorInfo(readableMap.getBoolean("isGatherSensorInfo"));
            }
            // TODO 是否采集已安装的 app 名 称,true:采集(默认值) false:不采集
            if (readableMap.hasKey("isGatherInstalledApp")) {
                params.setGatherInstalledApp(readableMap.getBoolean("isGatherInstalledApp"));
            }
            // TODO 设置是否连接到白骑士测试环境， true:测试环境，false:生产环境
            if (readableMap.hasKey("isTestingEnv")) {
                params.setTestingEnv(readableMap.getBoolean("isTestingEnv"));
            }
            BqsDF.getInstance().setOnBqsDFListener(null);
            BqsDF.getInstance().setOnBqsDFContactsListener(null);
            BqsDF.getInstance().setOnBqsDFListener(new OnBqsDFListener() {
                @Override
                public void onSuccess(String tokenKey) {
                    // 白骑士SDK采集设备信息成功
                    mStatus = 1;
                    if (mCallBack != null) {
                        mCallBack.invoke(true, tokenKey);
                        mCallBack = null;
                    }
                }

                @Override
                public void onFailure(String resultCode, String resultDesc) {
                    // 白骑士SDK采集设备信息失败
                    mStatus = 0;
                    if (mCallBack != null) {
                        mCallBack.invoke(false, resultCode + "," + resultDesc);
                        mCallBack = null;
                    }
                }
            });
            if (isGatherContacts) {
                BqsDF.getInstance().setOnBqsDFContactsListener(new OnBqsDFContactsListener() {
                    @Override
                    public void onGatherResult(boolean gatherStatus) {
                        // 通讯录采集状态
                    }

                    @Override
                    public void onSuccess(String tokenKey) {
                        // 通讯录采集成功
                        mStatus = 1;
                        if (mCallBack != null) {
                            mCallBack.invoke(true, tokenKey);
                            mCallBack = null;
                        }
                    }

                    @Override
                    public void onFailure(String resultCode, String resultDesc) {
                        // 通讯录采集失败
                        mStatus = 0;
                        if (mCallBack != null) {
                            mCallBack.invoke(false, resultCode + "," + resultDesc);
                            mCallBack = null;
                        }
                    }
                });
            }
            currentActivity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    PermissionUtils.requestMultiPermissions(currentActivity,
                            BqsDF.getInstance().getRuntimePermissions(isGatherGps, isGatherContacts, isGatherCallRecord),
                            new PermissionUtils.PermissionGrant() {
                                @Override
                                public void onPermissionGranted(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults, String[] requestPermissions) {
                                    Log.i("BqsDeviceModule", "====Init requestCode=" + requestCode);
                                    BqsDF.getInstance().initialize(currentActivity, params);
                                }
                            });
                }
            });
            BqsDF.getInstance().initialize(currentActivity, params);
        } else {
            callback.invoke(false);
        }
    }

    /**
     * 获取设备指纹
     */
    @ReactMethod
    public void getBqsDevices(Callback callback) {
        if (mStatus == 1) {
            callback.invoke(BqsDF.getInstance().getTokenKey());
        } else {
            callback.invoke("");
        }
    }

    /**
     * 判断GPS是否开启，GPS或者AGPS开启一个就认为是开启的
     *
     * @return true 表示开启
     */
    @ReactMethod
    public void isGPSOpen(Callback callback) {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            LocationManager locationManager
                    = (LocationManager) currentActivity.getSystemService(Context.LOCATION_SERVICE);
            // 通过GPS卫星定位，定位级别可以精确到街（通过24颗卫星定位，在室外和空旷的地方定位准确、速度快）
            boolean gps = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
            // 通过WLAN或移动网络(3G/2G)确定的位置（也称作AGPS，辅助GPS定位。主要用于在室内或遮盖物（建筑群或茂密的深林等）密集的地方定位）
//            boolean network = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
            if (gps) {
                Log.i("BqsDeviceModule", "GPS已开启");
                callback.invoke(true);
            } else {
                Log.i("BqsDeviceModule", "GPS未开启");
                callback.invoke(false);
            }
        }
    }

    /***
     * 杀死本程序
     */
    @ReactMethod
    public void killProcess() {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            currentActivity.finish();
        }
    }

    /**
     * 打开系统定位设置界面
     */
    @ReactMethod
    public void openLocationSetting() {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            Intent intent = new Intent();
            intent.setAction(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
            currentActivity.startActivity(intent);
        }
    }

    /**
     * 打开应用详情界面
     */
    @ReactMethod
    public void openSystemSetting() {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            Intent intent = new Intent();
            intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
            Uri uri = Uri.fromParts("package", currentActivity.getPackageName(), null);
            intent.setData(uri);
            currentActivity.startActivity(intent);
        }
    }


}
