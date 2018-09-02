package com.rrkc.PhoneInfo;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;
import android.support.v7.app.AlertDialog;
import android.util.Log;

import com.facebook.react.bridge.Callback;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhuoxu on 2017/8/15.
 * 通讯录管理者,提供回调入口
 */

public class ContactsManager {

    private String username;

    private ContactsManager() {
    }

    private Callback callback;
    private static volatile ContactsManager instance;

    public static ContactsManager getInstance() {
        if (instance == null) {
            synchronized (ContactsManager.class) {
                if (instance == null) {
                    instance = new ContactsManager();
                }
            }
        }
        return instance;
    }

    public void setCallback(Callback callback) {
        this.callback = callback;
    }

    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && data != null) {
            // ContentProvider展示数据类似一个单个数据库表
            // ContentResolver实例带的方法可实现找到指定的ContentProvider并获取到ContentProvider的数据
            ContentResolver reContentResolverol = activity.getContentResolver();
            // URI,每个ContentProvider定义一个唯一的公开的URI,用于指定到它的数据集
            Uri contactData = data.getData();
            Log.i("ContactsManager", "onActivityResult: " + contactData.toString());
            // 查询就是输入URI等参数,其中URI是必须的,其他是可选的,如果系统能找到URI对应的ContentProvider将返回一个Cursor对象.
            Cursor cursor = activity.managedQuery(contactData, null, null, null, null);
            cursor.moveToFirst();
            // 获得DATA表中的名字
            username = cursor.getString(cursor
                    .getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME));
            // 条件为联系人ID
            String contactId = cursor.getString(cursor
                    .getColumnIndex(ContactsContract.Contacts._ID));
            // 获得DATA表中的电话号码，条件为联系人ID,因为手机号码可能会有多个
            Cursor phone = reContentResolverol.query(
                    ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null,
                    ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = "
                            + contactId, null, null);
            final List<String> phoneNumbers = new ArrayList<>();
            while (phone.moveToNext()) {
                String usernumber = phone
                        .getString(phone
                                .getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
                phoneNumbers.add(usernumber);

            }
            if (phoneNumbers.size() == 1) {
                if (callback != null) {
                    callback.invoke(username, phoneNumbers.get(0));
                    callback = null;
                }
            } else if (phoneNumbers.size() > 1) {
                AlertDialog.Builder builder = new AlertDialog.Builder(activity);
                int size = phoneNumbers.size();
                builder.setTitle("请选择一个号码").setItems(phoneNumbers.toArray(new String[size]), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        if (callback != null) {
                            callback.invoke(username, phoneNumbers.get(which));
                            callback = null;
                        }
                    }
                }).create().show();
            }
        }
    }
}
