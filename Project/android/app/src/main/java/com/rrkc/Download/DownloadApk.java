package com.rrkc.Download;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;


import com.rrkc.R;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.WeakReference;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class DownloadApk {

    /* 下载中 */
    private static final int DOWNLOAD = 1;
    /* 下载结束 */
    private static final int DOWNLOAD_FINISH = 2;
    /* 下载保存路径 */
    private String mSavePath;
    /* 记录进度条数量 */
    private int progress;
    /* 是否取消更新 */
    private boolean cancelUpdate = false;

    private static AlertDialog buliderDownload;
    private static WeakReference<Activity> mActivity;

    private RoundProgressBar update_progress;
    private Button update_dialog_progress_cancel;
    private Activity activity;
    private boolean isMandatory = false;
    private String downloadUrl;
    private DownloadApkCallBack downloadApkCallBack;
    private String versionName;

    public DownloadApk(boolean mandatory, String downloadUrl, String versionName, DownloadApkCallBack downloadApkCallBack) {
        this.isMandatory = mandatory;
        this.downloadUrl = downloadUrl;
        this.downloadApkCallBack = downloadApkCallBack;
        this.versionName = versionName;
    }

    private Handler mHandler = new Handler() {
        public void handleMessage(Message msg) {
            switch (msg.what) {
                // 正在下载
                case DOWNLOAD:
                    // 设置进度条位置
                    update_progress.setProgress(progress);
                    break;
                case DOWNLOAD_FINISH:
                    // 安装文件
                    installApk();
                    break;
                default:
                    break;
            }
        }
    };

    /**
     * 显示软件下载对话框
     */
    public void showDownloadDialog(final Activity activity) {
        if (activity == null) return;
        mActivity = new WeakReference<>(activity);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (!activity.isFinishing()) {
                    buliderDownload = new AlertDialog.Builder(activity).create();
                    View builderdownloadview = LayoutInflater.from(activity).inflate(R.layout.layout_update_dialog_progress, null);
                    update_dialog_progress_cancel = (Button) builderdownloadview.findViewById(R.id.update_dialog_progress_cancel);
                    update_dialog_progress_cancel.setOnClickListener(onClickListener);
                    update_progress = (RoundProgressBar) builderdownloadview.findViewById(R.id.update_progress);
                    buliderDownload.setView(builderdownloadview);
                    buliderDownload.setOnDismissListener(onDismissListener);
                    if (!buliderDownload.isShowing()) {
                        buliderDownload.show();
                        downloadApk();
                    }
                }
            }
        });
    }

    /**
     * 隐藏弹框
     */
    private void hide(final int whats) {
        if (activity == null) activity = mActivity.get();
        if (activity == null) return;
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (buliderDownload != null && buliderDownload.isShowing()) {
                    buliderDownload.dismiss();
                }
            }
        });
    }

    /**
     * 下载apk文件
     */
    private void downloadApk() {
        // 启动新线程下载软件
        new downloadApkThread().start();
    }

    /**
     * 删除文件
     */
    private void deleteAPK(String path, String apkname) {
        File file = new File(path, apkname);
        delete(file);
    }

    /**
     * 下载文件线程
     */
    private class downloadApkThread extends Thread {
        @Override
        public void run() {
            try {
                // 判断SD卡是否存在，并且是否具有读写权限
                if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
                    // 获得存储卡的路径
                    String sdpath = Environment.getExternalStorageDirectory() + "/";
                    mSavePath = sdpath + "download";
                    URL url = new URL(downloadUrl);
                    // 创建连接
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.connect();
                    // 获取文件大小
                    int length = conn.getContentLength();
                    // 创建输入流
                    InputStream is = conn.getInputStream();

                    File file = new File(mSavePath);
                    // 判断文件目录是否存在
                    if (!file.exists()) {
                        file.mkdir();
                    }
                    File apkFile = new File(mSavePath, "hwy_" + versionName + ".apk");
                    FileOutputStream fos = new FileOutputStream(apkFile);
                    int count = 0;
                    // 缓存
                    byte buf[] = new byte[1024];
                    // 写入到文件中
                    do {
                        int numread = is.read(buf);
                        count += numread;
                        // 计算进度条位置
                        progress = (int) (((float) count / length) * 100);
                        // 更新进度
                        mHandler.sendEmptyMessage(DOWNLOAD);
                        if (numread <= 0) {
                            // 下载完成
                            mHandler.sendEmptyMessage(DOWNLOAD_FINISH);
                            break;
                        }
                        // 写入文件
                        fos.write(buf, 0, numread);
                    } while (!cancelUpdate);// 点击取消就停止下载.
                    fos.close();
                    is.close();
                }
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            // 取消下载对话框显示
            hide(1);
        }
    }

    /**
     * 安装APK文件
     */
    private void installApk() {
        File apkfile = new File(mSavePath, "hwy_" + versionName + ".apk");
        if (!apkfile.exists()) {
            return;
        }
        // 通过Intent安装APK文件
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setDataAndType(Uri.parse("file://" + apkfile.toString()), "application/vnd.android.package-archive");
        activity.startActivity(i);

        if (isMandatory == true) {
            hide(2);
        } else {
            hide(1);
        }
    }

    // 删除文件或者文件夹
    public void delete(File file) {
        if (file.exists()) {
            if (file.isFile()) {
                file.delete();
                return;
            }
            if (file.isDirectory()) {
                File[] childFiles = file.listFiles();
                if (childFiles == null || childFiles.length == 0) {
                    file.delete();
                    return;
                }
                for (int i = 0; i < childFiles.length; i++) {
                    delete(childFiles[i]);
                }
                file.delete();
            }
        }
    }

    DialogInterface.OnDismissListener onDismissListener = new DialogInterface.OnDismissListener() {

        @Override
        public void onDismiss(DialogInterface dialog) {
            cancelUpdate = true;
            if (isMandatory == true) {
                downloadApkCallBack.onCallBack(2);
            } else {
                downloadApkCallBack.onCallBack(1);
            }
        }
    };

    View.OnClickListener onClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            switch (v.getId()) {
                case R.id.update_dialog_progress_cancel:
                    cancelUpdate = true;
                    if (isMandatory == true) {
                        hide(2);
                    } else {
                        hide(1);
                    }
                    deleteAPK(mSavePath, "hwy_" + versionName + ".apk");
                    break;
            }
        }
    };

    public interface DownloadApkCallBack {
        void onCallBack(int status);
    }
}
