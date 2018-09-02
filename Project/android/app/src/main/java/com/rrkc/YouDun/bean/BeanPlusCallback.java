package com.rrkc.YouDun.bean;

/**
 * Created by tiancheng on 2017/9/4.
 */

public class BeanPlusCallback {
    private String Face;
    private String Living;

    public String getFace() {
        return Face;
    }

    public void setFace(String face) {
        Face = face;
    }

    public String getLiving() {
        return Living;
    }

    public void setLiving(String living) {
        Living = living;
    }

    @Override
    public String toString() {
        return "{" +
                "Face:" + Face +
                ", Living:" + Living + "}";
    }
}
