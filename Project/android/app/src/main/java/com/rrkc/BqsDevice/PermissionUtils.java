package com.rrkc.BqsDevice;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.Settings;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AlertDialog;

import java.util.ArrayList;
import java.util.List;

/**
 * Desction:授权工具类
 * Author:pengjianbo
 * Date:2017/1/15 AM2:39
 */
public class PermissionUtils {
    
    public static final int CODE_PERMISSIONS = 123;
    
    interface PermissionGrant {
        /**
         * 处理结果
         * @param requestCode 请求码
         * @param permissions 本次授权权限列表
         * @param grantResults 本次授权结果,0:授权成功 -1:拒绝授权
         * @param requestPermissions 请求所有权限
         */
        void onPermissionGranted(final int requestCode, @NonNull String[] permissions,
                                 @NonNull int[] grantResults, String[] requestPermissions);
    }
    
    private static void showMessageOKCancel(final Activity context, String message, DialogInterface.OnClickListener okListener, DialogInterface.OnClickListener cancelListener) {
        new AlertDialog.Builder(context)
        .setMessage(message)
        .setPositiveButton("是", okListener)
        .setNegativeButton("否", cancelListener)
        .create()
        .show();
    }
    
    /**
     * 跳转到系统设置界面去开启权限
     * @param activity
     * @param message
     */
    private static void openSettingActivity(final Activity activity, String message) {
        showMessageOKCancel(activity, message, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Intent intent = new Intent();
                intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                Uri uri = Uri.fromParts("package", activity.getPackageName(), null);
                intent.setData(uri);
                activity.startActivity(intent);
            }
        }, null);
    }
    
    /////////////////////////////////执行授权/////////////////////////////////////
    /**
     * 一次申请多个权限
     * @param activity
     * @param grant
     */
    public static void requestMultiPermissions(final Activity activity, final String[] requestPermissions, final PermissionGrant grant) {
        
        //获取没有授权的权限
        final List<String> permissionsList = getNoGrantedPermission(activity, requestPermissions, false);
        //获取上次被拒权限列表
        final List<String> shouldRationalePermissionsList = getNoGrantedPermission(activity, requestPermissions, true);
        
        if (permissionsList == null || shouldRationalePermissionsList == null) {
            return;
        }
        final int []grantResults = new int[requestPermissions.length];
        if (permissionsList.size() > 0) {//去授权
            ActivityCompat.requestPermissions(activity, permissionsList.toArray(new String[permissionsList.size()]), CODE_PERMISSIONS);
        } else if (shouldRationalePermissionsList.size() > 0) {
            showMessageOKCancel(activity, "应用缺少权限，是否重新去授权？",
                                new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    ActivityCompat.requestPermissions(activity, shouldRationalePermissionsList.toArray(new String[shouldRationalePermissionsList.size()]),
                                                      CODE_PERMISSIONS);
                }
            }, new DialogInterface.OnClickListener(){
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    grant.onPermissionGranted(CODE_PERMISSIONS, requestPermissions, grantResults, requestPermissions);
                }
            });
        } else {
            grant.onPermissionGranted(CODE_PERMISSIONS, requestPermissions, grantResults, requestPermissions);
        }
    }
    
    private static ArrayList<String> getNoGrantedPermission(Activity activity, String[] requestPermissions, boolean isShouldRationale) {
        ArrayList<String> permissions = new ArrayList<>();
        for (int i = 0; i < requestPermissions.length; i++) {
            String requestPermission = requestPermissions[i];
            
            int checkSelfPermission = -1;
            try {
                checkSelfPermission = ActivityCompat.checkSelfPermission(activity, requestPermission);
            } catch (RuntimeException e) {
                return null;
            }
            
            if (checkSelfPermission != PackageManager.PERMISSION_GRANTED) {
                if (ActivityCompat.shouldShowRequestPermissionRationale(activity, requestPermission)) {
                    if (isShouldRationale) {
                        permissions.add(requestPermission);
                    }
                    
                } else {
                    if (!isShouldRationale) {
                        permissions.add(requestPermission);
                    }
                }
            }
        }
        
        return permissions;
    }
    
    /////////////////////////////////处理授权结果/////////////////////////////////////
    /**
     * 处理授权
     * @param requestCode  Need consistent with requestPermission
     * @param permissions
     * @param grantResults
     */
    public static void requestPermissionsResult(final int requestCode, @NonNull String[] permissions,
                                                @NonNull int[] grantResults, String[] requestPermissions, PermissionGrant permissionGrant) {
        
        if (requestCode == CODE_PERMISSIONS) {
            permissionGrant.onPermissionGranted(requestCode, permissions, grantResults, requestPermissions);
            return;
        }
    }
}
