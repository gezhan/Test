package com.rrkc;

import android.app.KeyguardManager;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.os.Build;
import android.provider.Settings.Secure;
import android.telephony.TelephonyManager;
import android.text.TextUtils;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.google.android.gms.iid.InstanceID;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import javax.annotation.Nullable;

import static android.content.Context.TELEPHONY_SERVICE;

public class RNDeviceModule extends ReactContextBaseJavaModule {

  private ReactApplicationContext reactContext;
  private HashMap<String, String> hashSet = null;

  public RNDeviceModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    hashSet = new HashMap<>();
    // 通用官网包
    hashSet.put("rrkc", "官网");
    // OPPO应用商店
    hashSet.put("oppoyysd", "OPPO应用商店");
    // 华为应用商店
    hashSet.put("hwyysd", "华为应用商店");
    // 腾讯应用宝
    hashSet.put("txyyb", "腾讯应用宝");
    // 小米应用商店
    hashSet.put("xmyysd", "小米应用商店");
    // VIVO应用商店
    hashSet.put("vivoyysd", "VIVO应用商店");
    // 魅族应用商店
    hashSet.put("mzyysd", "魅族应用商店");
    // 奇虎360手机助手
    hashSet.put("qh360sjzs", "奇虎360手机助手");
    // 阿里云应用分发平台
    hashSet.put("alyyyffpt", "阿里云应用分发平台");
  }

  @Override
  public String getName() {
    return "RNDeviceInfo";
  }

  private String getCurrentLanguage() {
      Locale current = getReactApplicationContext().getResources().getConfiguration().locale;
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          return current.toLanguageTag();
      } else {
          StringBuilder builder = new StringBuilder();
          builder.append(current.getLanguage());
          if (current.getCountry() != null) {
              builder.append("-");
              builder.append(current.getCountry());
          }
          return builder.toString();
      }
  }

  private String getCurrentCountry() {
    Locale current = getReactApplicationContext().getResources().getConfiguration().locale;
    return current.getCountry();
  }

  private Boolean isEmulator() {
    return Build.FINGERPRINT.startsWith("generic")
      || Build.FINGERPRINT.startsWith("unknown")
      || Build.MODEL.contains("google_sdk")
      || Build.MODEL.contains("Emulator")
      || Build.MODEL.contains("Android SDK built for x86")
      || Build.MANUFACTURER.contains("Genymotion")
      || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
      || "google_sdk".equals(Build.PRODUCT);
  }
  private String getChannelName() {
    if (this.reactContext == null) {
      return "";
    }
    String channelName = "";
    try {
      PackageManager packageManager = this.reactContext.getPackageManager();
      if (packageManager != null) {
        //注意此处为ApplicationInfo 而不是 ActivityInfo,因为友盟设置的meta-data是在application标签中，而不是某activity标签中，所以用ApplicationInfo
        ApplicationInfo applicationInfo = packageManager.getApplicationInfo(this.reactContext.getPackageName(), PackageManager.GET_META_DATA);
        if (applicationInfo != null) {
          if (applicationInfo.metaData != null) {
            channelName = applicationInfo.metaData.getString("JPUSH_CHANNEL");
          }
        }
      }
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }
    return channelName;
  }
  private Boolean isTablet() {
    int layout = getReactApplicationContext().getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK;
    return layout == Configuration.SCREENLAYOUT_SIZE_LARGE || layout == Configuration.SCREENLAYOUT_SIZE_XLARGE;
  }

  @ReactMethod
  public void isPinOrFingerprintSet(Callback callback) {
    KeyguardManager keyguardManager = (KeyguardManager) this.reactContext.getSystemService(Context.KEYGUARD_SERVICE); //api 16+
    callback.invoke(keyguardManager.isKeyguardSecure());
  }

  @Override
  public @Nullable Map<String, Object> getConstants() {
    HashMap<String, Object> constants = new HashMap<String, Object>();

    PackageManager packageManager = this.reactContext.getPackageManager();
    String packageName = this.reactContext.getPackageName();

    constants.put("appVersion", "not available");
    constants.put("buildVersion", "not available");
    constants.put("buildNumber", 0);
    constants.put("imei", "");
    try {
      PackageInfo info = packageManager.getPackageInfo(packageName, 0);
      constants.put("appVersion", info.versionName);
      constants.put("buildNumber", info.versionCode);
      TelephonyManager tm = (TelephonyManager) this.reactContext.getSystemService(TELEPHONY_SERVICE);
      if (tm != null){
        constants.put("imei",tm.getDeviceId() + "");
      }
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }

    String deviceName = "Unknown";

    try {
      BluetoothAdapter myDevice = BluetoothAdapter.getDefaultAdapter();
      if(myDevice!=null){
        deviceName = myDevice.getName();
      }
    } catch(Exception e) {
      e.printStackTrace();
    }
    constants.put("channel", TextUtils.isEmpty(getChannelName()) ? "" : hashSet.get(getChannelName()));
    constants.put("instanceId", InstanceID.getInstance(this.reactContext).getId());
    constants.put("deviceName", deviceName);
    constants.put("systemName", "Android");
    constants.put("systemVersion", Build.VERSION.RELEASE);
    constants.put("model", Build.MODEL);
    constants.put("brand", Build.BRAND);
    constants.put("deviceId", Build.BOARD);
    constants.put("deviceLocale", this.getCurrentLanguage());
    constants.put("deviceCountry", this.getCurrentCountry());
    constants.put("uniqueId", Secure.getString(this.reactContext.getContentResolver(), Secure.ANDROID_ID));
    constants.put("systemManufacturer", Build.MANUFACTURER);
    constants.put("bundleId", packageName);
    constants.put("userAgent", System.getProperty("http.agent"));
    constants.put("timezone", TimeZone.getDefault().getID());
    constants.put("isEmulator", this.isEmulator());
    constants.put("isTablet", this.isTablet());
    return constants;
  }
}