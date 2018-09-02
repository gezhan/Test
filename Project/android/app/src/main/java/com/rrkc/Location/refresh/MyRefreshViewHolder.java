package com.rrkc.Location.refresh;

import android.content.Context;
import android.support.v4.view.ViewCompat;
import android.view.View;
import android.widget.TextView;

import com.rrkc.R;


public class MyRefreshViewHolder extends BGARefreshViewHolder {

    private TextView imageView;
//    private AnimationDrawable mRefreshingAd;

    /**
     * @param context
     * @param isLoadingMoreEnabled 上拉加载更多是否可用
     */
    public MyRefreshViewHolder(Context context, boolean isLoadingMoreEnabled) {
        super(context, isLoadingMoreEnabled);
    }

    @Override
    public View getRefreshHeaderView() {
        if (mRefreshHeaderView == null) {
            mRefreshHeaderView = View.inflate(mContext, R.layout.refresh_custom_head, null);
        }
        imageView= (TextView) mRefreshHeaderView.findViewById(R.id.refresh_custom_img);
        return mRefreshHeaderView;
    }

    @Override
    public void handleScale(float scale, int moveYDistance) {
        if (scale <= 1.0f) {
            handleScale(scale);
        }
    }
    @Override
    public void changeToRefreshing() {
//        if (mRefreshingAd==null) {
//            mRefreshingAd= (AnimationDrawable) imageView.getDrawable();
//        }
//        if (!mRefreshingAd.isRunning()) {
//            mRefreshingAd.start();
//        }
    }

    @Override
    public void changeToIdle() {
    }

    @Override
    public void changeToPullDown() {
    }

    @Override
    public void changeToReleaseRefresh() {
    }


    @Override
    public void onEndRefreshing() {
        stopRefreshingAd();
    }

    public void handleScale(float scale) {
        scale = 0.1f + 0.9f * scale;
        ViewCompat.setScaleX(imageView, scale);
        ViewCompat.setPivotY(imageView, imageView.getHeight());
        ViewCompat.setScaleY(imageView, scale);
    }

    private void stopRefreshingAd() {
//        if (mRefreshingAd != null) {
//            mRefreshingAd.stop();
//            mRefreshingAd = null;
//        }
    }
}
