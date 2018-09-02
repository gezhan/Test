package com.rrkc.YouDun.bean;

/**
 * Created by tiancheng on 2017/9/4.
 */

public class BeanTrueNameParams {
    private String pubKey;
    private String signTime;
    private String sign;
    private String InfOrder;
    private String notifyUrl;
    private String userName;
    private String card;

    public String getPubKey() {
        return pubKey;
    }

    public void setPubKey(String puπbKey) {
        this.pubKey = puπbKey;
    }

    public String getSignTime() {
        return signTime;
    }

    public void setSignTime(String signTime) {
        this.signTime = signTime;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getInfOrder() {
        return InfOrder;
    }

    public void setInfOrder(String infOrder) {
        InfOrder = infOrder;
    }

    public String getNotifyUrl() {
        return notifyUrl;
    }

    public void setNotifyUrl(String notifyUrl) {
        this.notifyUrl = notifyUrl;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCard() {
        return card;
    }

    public void setCard(String card) {
        this.card = card;
    }
}
