package com.rrkc.PhoneInfo;

import android.Manifest;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.database.Cursor;
import android.database.sqlite.SQLiteException;
import android.net.ConnectivityManager;
import android.net.DhcpInfo;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.os.SystemClock;
import android.provider.CallLog;
import android.provider.ContactsContract;
import android.provider.Settings;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.WindowManager;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.google.gson.GsonBuilder;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Method;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.UUID;

import static android.content.Context.TELEPHONY_SERVICE;
import static android.content.Context.WIFI_SERVICE;

/**
 * Created by LF on 2017/3/25.
 */

public class PhoneInfoModule extends ReactContextBaseJavaModule {

    public PhoneInfoModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "PhoneInfoModule";
    }

    /**
     * 网络是否可用
     */
    @ReactMethod
    public void isNetworkAvailable(Callback callback) {
        boolean isAvailable = false;
        isAvailable = NetworkUtil.isNetworkAvailable(getCurrentActivity());
        callback.invoke(isAvailable);
    }

    /**
     * 判断是否有网络连接
     */
    @ReactMethod
    public void isNetworkConnected(Callback callback) {
        boolean isConnected = false;
        isConnected = NetworkUtil.isNetworkConnected(getCurrentActivity());
        callback.invoke(isConnected);
    }

    @ReactMethod
    public void isAliInstalled(Callback callback) {
        boolean isInstall = false;
        try {
            PackageInfo e = getCurrentActivity().getPackageManager().getPackageInfo("com.eg.android.AlipayGphone", 64);
            isInstall = e != null;
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        callback.invoke(isInstall);
    }

    @ReactMethod
    public void getCalls(Callback callback) {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            try {
                if (ContextCompat.checkSelfPermission(currentActivity, Manifest.permission.READ_CALL_LOG) != PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(currentActivity, new String[]{Manifest.permission.READ_CALL_LOG}, 1);
                    callback.invoke(false, "通话记录获取失败");
                } else {
                    List<CallsJavaBean> list = getCallsInPhone(currentActivity);
                    if (list != null && list.size() > 0) {
                        String jsonContactStr = parsetoCallsJson(list);
                        callback.invoke(true, jsonContactStr);
                    } else {
                        callback.invoke(false, "通话记录获取失败");
                    }
                }
            } catch (RuntimeException e) {
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw);
                e.printStackTrace(pw);
                String msg=sw.toString();
                callback.invoke(false, "请打开阅读通话记录权限", msg);
            }
        } else {
            callback.invoke(false, "当前Activity不存在");
        }
    }

    @ReactMethod
    public void getSms(Callback callback) {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            try {
                if (ContextCompat.checkSelfPermission(currentActivity, Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(currentActivity, new String[]{Manifest.permission.READ_SMS}, 1);
                    callback.invoke(false, "短信记录获取失败");
                } else {
                    List<SmsJavaBean> list = getSmsInPhone(currentActivity);
                    if (list != null && list.size() > 0) {
                        String jsonSmsStr = parsetoSmsJson(list);
                        callback.invoke(true, jsonSmsStr);
                    } else {
                        callback.invoke(false, "短信记录获取失败");
                    }
                }
            } catch (RuntimeException e) {
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw);
                e.printStackTrace(pw);
                String msg=sw.toString();
                callback.invoke(false, "请打开阅读短信记录权限", msg);
            }
        } else {
            callback.invoke(false, "当前Activity不存在");
        }
    }

    /**
     * 获取系统通话记录
     */
    private List<CallsJavaBean> getCallsInPhone(Activity activity) {
        List<CallsJavaBean> mCallsDatas = new ArrayList<>();
        if (ActivityCompat.checkSelfPermission(activity, Manifest.permission.READ_CALL_LOG) != PackageManager.PERMISSION_GRANTED) {
            return mCallsDatas;
        }
        try {
            Cursor cursor = activity.getContentResolver().query(
                    CallLog.Calls.CONTENT_URI,
                    new String[]{CallLog.Calls.DURATION, CallLog.Calls.TYPE, CallLog.Calls.DATE,
                            CallLog.Calls.NUMBER}, null, null, CallLog.Calls.DEFAULT_SORT_ORDER);
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "yyyy-MM-dd HH:mm:ss", Locale.CHINA);
            //六个月前的毫秒数
            long needTime = System.currentTimeMillis() - 15811200000l;
            if (cursor != null) {
                for (cursor.moveToFirst(); !cursor.isAfterLast(); cursor.moveToNext()) {
                    int index_PhoneNumber = cursor.getColumnIndex(CallLog.Calls.NUMBER);
                    int index_Duration = cursor.getColumnIndex(CallLog.Calls.DURATION);
                    int index_Date = cursor.getColumnIndex(CallLog.Calls.DATE);
                    int index_Type = cursor.getColumnIndex(CallLog.Calls.TYPE);

                    String strPhoneNumber = cursor.getString(index_PhoneNumber);
                    strPhoneNumber = strPhoneNumber.replace(" ", "").replace("+86", "").replace("-", "");
                    long lngDuration = cursor.getLong(index_Duration);
                    long longDate = cursor.getLong(index_Date);
                    int intType = cursor.getInt(index_Type);

                    if (longDate > needTime) {
                        CallsJavaBean bean = new CallsJavaBean();
                        bean.setPhoneNumber(strPhoneNumber);
                        bean.setType(intType);
                        bean.setDuration(lngDuration);
                        bean.setDate(dateFormat.format(new Date(longDate)));
                        mCallsDatas.add(bean);
                    }
                }
                if (!cursor.isClosed()) {
                    cursor.close();
                    cursor = null;
                }
            }
        } catch (SQLiteException ex) {
            return mCallsDatas;
        }
        return mCallsDatas;
    }

    /**
     * 获取系统短信记录
     */
    private List<SmsJavaBean> getSmsInPhone(Activity activity) {
        List<SmsJavaBean> mSmsDatas = new ArrayList<>();
        if (ActivityCompat.checkSelfPermission(activity, Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED) {
            return mSmsDatas;
        }
        final String SMS_URI_ALL = "content://sms/";
        try {
            Uri uri = Uri.parse(SMS_URI_ALL);
            String[] projection = new String[]{"address", "person",
                    "body", "date", "type"};
            Cursor cursor = activity.getContentResolver().query(uri, projection, null,
                    null, "date desc"); // 获取手机内部短信
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "yyyy-MM-dd HH:mm:ss", Locale.CHINA);
            //六个月前的毫秒数
            long needTime = System.currentTimeMillis() - 15811200000l;

            if (cursor != null) {
                for (cursor.moveToFirst(); !cursor.isAfterLast(); cursor.moveToNext()) {
                    int index_Address = cursor.getColumnIndex("address");
                    int index_Body = cursor.getColumnIndex("body");
                    int index_Date = cursor.getColumnIndex("date");
                    int index_Type = cursor.getColumnIndex("type");

                    String strAddress = cursor.getString(index_Address);
                    String strbody = cursor.getString(index_Body);
                    if (strAddress != null && strbody != null) {
                        strAddress = strAddress.replace(" ", "").replace("+86", "").replace("-", "");
                        long longDate = cursor.getLong(index_Date);
                        int intType = cursor.getInt(index_Type);

                        //判断短信时间与六个月前时间是否匹配
                        if (longDate > needTime) {
                            SmsJavaBean bean = new SmsJavaBean();
                            String strDate = dateFormat.format(new Date(longDate));
                            bean.setPhoneNumber(strAddress);
                            bean.setSmsContent(strbody);
                            bean.setType(intType);
                            bean.setDate(strDate);
                            mSmsDatas.add(bean);
                        }
                    }
                }
            }
        } catch (SQLiteException ex) {
            ex.printStackTrace();
        }
        return mSmsDatas;

    }

    /**
     * 把电话记录集合转换成JSON格式的字符串
     */
    private String parsetoCallsJson(List<CallsJavaBean> mDatas) {
        try {
            JSONArray array = new JSONArray();
            for (CallsJavaBean contactJavaBean : mDatas) {
                if (!TextUtils.isEmpty(contactJavaBean.getDate())) {
                    JSONObject obj = new JSONObject();
                    obj.put("PhoneNumber", contactJavaBean.getPhoneNumber());
                    obj.put("Duration", contactJavaBean.getDuration());
                    obj.put("Date", contactJavaBean.getDate());
                    obj.put("Type", contactJavaBean.getType());
                    array.put(obj);
                }
            }
            return array.length() > 0 ? array.toString() : "";
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 把短信记录集合转换成JSON格式的字符串
     */
    private String parsetoSmsJson(List<SmsJavaBean> mDatas) {
        try {
            JSONArray array = new JSONArray();
            for (SmsJavaBean contactJavaBean : mDatas) {
                if (!TextUtils.isEmpty(contactJavaBean.getDate())) {
                    JSONObject obj = new JSONObject();
                    obj.put("phoneNumber", contactJavaBean.getPhoneNumber());
                    obj.put("smsContent", contactJavaBean.getSmsContent());
                    obj.put("date", contactJavaBean.getDate());
                    obj.put("type", contactJavaBean.getType());
                    array.put(obj);
                }
            }
            return array.length() > 0 ? array.toString() : "";
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}