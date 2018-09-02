package com.rrkc.PhoneInfo;

import java.io.Serializable;

/**
 * Project Name:ygfq
 * Package Name:com.ygfq.phoneInfo
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/11/21 16:08
 */

public class ContactsJavaBean implements Serializable {
    private String name;
    private String number;
    private String[] numbers;

    public void setName(String name) {
        this.name = name;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public void setNumbers(String[] numbers) {
        this.numbers = numbers;
    }

    public String getName() {
        return name;
    }

    public String getNumber() {
        return number;
    }

    public String[] getNumbers() {
        return numbers;
    }
}
