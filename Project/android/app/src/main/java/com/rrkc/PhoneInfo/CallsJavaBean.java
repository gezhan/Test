package com.rrkc.PhoneInfo;

import java.io.Serializable;

/**
 * Project Name:ygfq
 * Package Name:com.ygfq.phoneInfo
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/11/21 16:07
 */

public class CallsJavaBean implements Serializable {
    private String phoneNumber;
    private String date;
    private long duration;
    private int type;//1呼入 2呼出 3未接

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDate() {
        return date;
    }

    public void setDuration(long duration) {
        this.duration = duration;
    }

    public long getDuration() {
        return duration;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getType() {
        return type;
    }
}
