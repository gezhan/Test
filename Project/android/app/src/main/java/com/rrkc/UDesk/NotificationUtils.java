package com.rrkc.UDesk;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v7.app.NotificationCompat;
import android.util.Log;


import com.rrkc.R;

import cn.udesk.activity.UdeskChatActivity;

/**
 * Project Name:zcmjr
 * Package Name:com.xjkc.udesk
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/9/13 21:12
 */

public class NotificationUtils {

    private NotificationUtils() {
    }

    private static volatile NotificationUtils instance;

    public static NotificationUtils getInstance() {
        if (instance == null) {
            synchronized (NotificationUtils.class) {
                if (instance == null) {
                    instance = new NotificationUtils();
                }
            }
        }
        return instance;
    }

    /**
     * @param context
     * @param message 状态栏显示的内容
     */
    public void notifyMsg(Context context, String message) {
        String notify_serivice = Context.NOTIFICATION_SERVICE;
        NotificationManager mNotificationManager = (NotificationManager) context.getSystemService(notify_serivice);
        int icon = R.mipmap.app_icon;
        CharSequence tickerText = "你有新消息了";
        long when = System.currentTimeMillis();
        CharSequence contentTitle = "有个钱包";
        CharSequence contentText = message;
        Intent notificationIntent = null;
        notificationIntent = new Intent(context, UdeskChatActivity.class);
        notificationIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        PendingIntent contentIntent = PendingIntent.getActivity(context, 0,
                notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
        Notification noti = builder.setSmallIcon(icon)
                .setContentTitle(contentTitle)
                .setContentText(contentText)
                .setTicker(tickerText)
                .setContentIntent(contentIntent)
                .setWhen(when).build();
        noti.flags = Notification.FLAG_AUTO_CANCEL;
        noti.defaults |= Notification.DEFAULT_VIBRATE;
        noti.defaults |= Notification.DEFAULT_LIGHTS;
        noti.defaults = Notification.DEFAULT_SOUND;
        mNotificationManager.notify(1, noti);
        Log.i("UdeskPush", "notifyMsg: 推送了一次:"+message);
    }
}
