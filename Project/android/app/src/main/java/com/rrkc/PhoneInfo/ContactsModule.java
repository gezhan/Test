package com.rrkc.PhoneInfo;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhuoxu on 2017/8/15.
 */

public class ContactsModule extends ReactContextBaseJavaModule {

    public ContactsModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "ContactsModule";
    }

    @ReactMethod
    public void toContact(Callback callback) {
        ContactsManager.getInstance().setCallback(callback);
        getCurrentActivity().startActivityForResult(new Intent(Intent.ACTION_PICK,
                ContactsContract.Contacts.CONTENT_URI), 0);
    }

    @ReactMethod
    public void getContacts(Callback callback) {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            try {
                if (ContextCompat.checkSelfPermission(currentActivity, Manifest.permission.READ_CONTACTS) != PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(currentActivity, new String[]{Manifest.permission.READ_CONTACTS}, 1);
                    Log.i("PhoneInfoModule", "向用户请求权限");
                } else {
                    if (getContacts(currentActivity) != null && getContacts(currentActivity).size() > 0) {
                        List<ContactsJavaBean> mContactDatas = groupList(getContacts(currentActivity));
                        String jsonContactStr = toJsonStr(mContactDatas);
                        Log.i("PhoneInfoModule", jsonContactStr);
                        callback.invoke(true, jsonContactStr);
                    } else {
                        Log.i("PhoneInfoModule", "联系人信息获取失败");
                        callback.invoke(false, "联系人信息获取失败");
                    }
                }
            } catch (RuntimeException e) {
                Log.e("PhoneInfoModule", "请打开联系人权限");
                callback.invoke(false, "请打开联系人权限");
            }
        } else {
            Log.e("PhoneInfoModule", "当前Activity不存在");
            callback.invoke(false, "当前Activity不存在");
        }
    }

    /**
     * 查询系统的联系人数据,获取联系人信息列表
     *
     * @param activity
     * @return
     */
    private List<ContactsJavaBean> getContacts(Activity activity) {
        List<ContactsJavaBean> mContactDatas = new ArrayList<>();
        try {
            Uri contactUri = ContactsContract.CommonDataKinds.Phone.CONTENT_URI;
            Cursor cursor = activity.getContentResolver().query(contactUri, new String[]{"display_name", "sort_key", "contact_id", "data1"}, null, null, "sort_key");
            String contactName;
            String contactNumber;
            if (cursor != null) {
                for (cursor.moveToFirst(); !cursor.isAfterLast(); cursor.moveToNext()) {
                    contactName = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME));
                    contactNumber = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));

                    if (contactName != null) {
                        ContactsJavaBean contactsInfo = new ContactsJavaBean();
                        contactsInfo.setName(contactName);
                        contactsInfo.setNumber(contactNumber);
                        mContactDatas.add(contactsInfo);
                    }
                }
                if (!cursor.isClosed()) {
                    cursor.close();
                    cursor = null;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mContactDatas;
    }

    /**
     * 对联系人集合根据姓名,对电话号码进行合并
     *
     * @param mDatas
     * @return
     */
    private List<ContactsJavaBean> groupList(List<ContactsJavaBean> mDatas) {
        List<ContactsJavaBean> newDatas = new ArrayList<>();
        for (ContactsJavaBean contactsJavaBean : mDatas) {
            boolean state = false;
            for (ContactsJavaBean contactsJavaBeans : newDatas) {
                if (contactsJavaBeans.getName().equals(contactsJavaBean.getName())) {
                    String numbers = contactsJavaBeans.getNumber();
                    numbers = numbers + "#" + contactsJavaBean.getNumber();
                    contactsJavaBeans.setNumber(numbers);
                    state = true;
                }
            }
            if (!state) {
                newDatas.add(contactsJavaBean);
            }
        }
        for (int i = 0; i < newDatas.size(); i++) {
            Log.i("PhoneInfoModule", "姓名=" + newDatas.get(i).getName() + " , 电话=" + newDatas.get(i).getNumber());
            if (newDatas.get(i).getNumber().indexOf("#") != -1) {
                String[] numbers = newDatas.get(i).getNumber().split("#");
                newDatas.get(i).setNumbers(numbers);
            }
        }
        return newDatas;
    }

    /**
     * 把集合转换成JSON格式的字符串
     */
    private String toJsonStr(List<ContactsJavaBean> mDatas) {
        try {
            JSONArray array = new JSONArray();
            for (ContactsJavaBean contactJavaBean : mDatas) {
                if (!TextUtils.isEmpty(contactJavaBean.getName())) {
                    JSONObject obj = new JSONObject();
                    obj.put("contactName", contactJavaBean.getName().replace(" ", ""));
                    JSONArray numberArray = new JSONArray();
                    String[] numbers = contactJavaBean.getNumbers();
                    if (numbers != null && numbers.length > 0) {
                        for (String number : numbers) {
                            numberArray.put(number.replace(" ", "").replace("+86", "").replace("-", ""));
                        }
                    } else if (!TextUtils.isEmpty(contactJavaBean.getNumber())) {
                        String num = contactJavaBean.getNumber();
                        numberArray.put(num.replace(" ", "").replace("+86", "").replace("-", ""));
                    }
                    obj.put("contactPhoneNumber", numberArray);
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
