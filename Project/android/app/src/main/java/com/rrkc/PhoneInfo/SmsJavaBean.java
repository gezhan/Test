package com.rrkc.PhoneInfo;

import java.io.Serializable;

/**
 * Project Name:ygfq
 * Package Name:com.ygfq.phoneInfo
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/11/21 16:06
 */

public class SmsJavaBean implements Serializable {
    private String phoneNumber;
    private String smsContent;
    private String date;
    private int type;//1接收短信 2发送短信

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getSmsContent() {
        return smsContent;
    }

    public void setSmsContent(String smsContent) {
        this.smsContent = smsContent;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
