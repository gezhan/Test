package com.rrkc.SplashScreen;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;

import com.rrkc.R;

import java.lang.ref.WeakReference;

/**
 * Created by HONG on 2016/10/24.
 */
public class SplashScreen {
    private static String servicesImgStr = null;
    private static Dialog mSplashDialog;
    private static WeakReference<Activity> mActivity;

    /**
     * 打开启动屏
     */
    public static void show(final Activity activity, final boolean fullScreen) {
        if (activity == null) return;
        mActivity = new WeakReference<Activity>(activity);
        mSplashDialog = new Dialog(activity, fullScreen ? R.style.SplashScreen_Fullscreen : R.style.SplashScreen_SplashTheme);
        SharedPreferences sharedPreferences = activity.getSharedPreferences("downloadImg", Context.MODE_PRIVATE);
        servicesImgStr = sharedPreferences.getString("imgAdress", "");
        View view = LayoutInflater.from(activity).inflate(R.layout.launch_screen, null);
        ImageView servicesImg = (ImageView) view.findViewById(R.id.iv_services_img);
        ImageView localImg = (ImageView) view.findViewById(R.id.iv_local_img);
//        Log.e("下载", "启动页查看广告页地址:" + servicesImgStr);
//        if (!TextUtils.isEmpty(servicesImgStr)) {
////                        Bitmap bitmap= BitmapFactory.decodeStream(getClass().getResourceAsStream(servicesImgStr));
//            Bitmap bitmap = getLoacalBitmap(servicesImgStr);
//            Log.e("下载", "启动页bitmap" + bitmap);
//            if (bitmap != null) {
//                servicesImg.setVisibility(View.VISIBLE);
//                servicesImg.setImageBitmap(bitmap);
//                Window window = activity.getWindow();
//                ViewGroup.LayoutParams sImgLayoutParams = servicesImg.getLayoutParams();
//                ViewGroup.LayoutParams lImgLayoutParams = localImg.getLayoutParams();
//                sImgLayoutParams.height = (int) (window.getWindowManager().getDefaultDisplay().getHeight() * 0.7);
//                sImgLayoutParams.width = window.getWindowManager().getDefaultDisplay().getWidth();
//                servicesImg.setLayoutParams(sImgLayoutParams);
//                lImgLayoutParams.height = (int) (window.getWindowManager().getDefaultDisplay().getHeight() * 0.3);
//                lImgLayoutParams.width = window.getWindowManager().getDefaultDisplay().getWidth();
//                localImg.setLayoutParams(lImgLayoutParams);
//            }
//        }
        mSplashDialog.setContentView(view);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (!activity.isFinishing()) {
                    mSplashDialog.setCancelable(false);
                    if (!mSplashDialog.isShowing()) {
                        mSplashDialog.show();
                    }
                }
            }
        });
    }

    public static Bitmap getLoacalBitmap(String url) {
        try {
            Bitmap bitmap = BitmapFactory.decodeFile(url);
            return bitmap;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 打开启动屏
     */
    public static void show(final Activity activity) {
        show(activity, false);
    }

    /**
     * 关闭启动屏
     */
    public static void hide(Activity activity) {
        if (activity == null) activity = mActivity.get();
        if (activity == null) return;

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (mSplashDialog != null && mSplashDialog.isShowing()) {
                    mSplashDialog.dismiss();
                }
            }
        });
    }
}