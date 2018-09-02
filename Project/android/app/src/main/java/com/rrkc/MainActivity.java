package com.rrkc;

import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.util.Log;

import com.facebook.react.ReactActivity;
import com.rrkc.PhoneInfo.ContactsManager;
import com.rrkc.SplashScreen.SplashScreen;
import com.rrkc.UDesk.NotificationUtils;
import com.umeng.analytics.MobclickAgent;

import cn.udesk.model.MsgNotice;

public class MainActivity extends ReactActivity {

    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "MPR";
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SplashScreen.show(MainActivity.this, true);
        initMobclick();
    }

    @Override
    protected void onResume() {
        super.onResume();
        MobclickAgent.onResume(this);
    }

    @Override
    protected void onPause() {
        super.onPause();
        MobclickAgent.onPause(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        android.os.Process.killProcess(android.os.Process.myPid());
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        getReactInstanceManager().onActivityResult(this, requestCode, resultCode, data);
        if (data != null && data.getData() != null && data.getData().toString().contains("content://com.android.contacts/contacts/")) {
            //提供获取通讯录回调
            ContactsManager.getInstance().onActivityResult(this, requestCode, resultCode, data);
        }
    }

    @Override
    public Resources getResources() {
        Resources res = super.getResources();
        Configuration config=new Configuration();
        config.setToDefaults();
        res.updateConfiguration(config,res.getDisplayMetrics());
        return res;
    }

    public void OnNewMsgNotice(MsgNotice msgNotice) {
        if (msgNotice != null) {
            NotificationUtils.getInstance().notifyMsg(MainActivity.this, msgNotice.getContent());
            Log.e("UDesk", "OnNewMsgNotice: 推送了这个::" + msgNotice.getContent());
        }
    }

    private void initMobclick() {
        //使用集成测试模式请先在程序入口处调用如下代码，打开调试模式
        MobclickAgent.setDebugMode(false);
        //禁止使用默认的统计（默认统计只用于统计activity）禁止false 使用true
        MobclickAgent.openActivityDurationTrack(false);
        //设置日志加密
        MobclickAgent.enableEncrypt(true);
        //设置统计场景
        MobclickAgent.setScenarioType(MainActivity.this, MobclickAgent.EScenarioType.E_UM_NORMAL);
    }
}
