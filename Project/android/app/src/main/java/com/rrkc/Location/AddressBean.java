package com.rrkc.Location;

import java.io.Serializable;

/**
 * Project Name:zcmjr
 * Package Name:com.xiaobu.amap
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/8/11 17:44
 */

public class AddressBean implements Serializable {

    private String address;
    private String detailAddress;
    private String province;
    private String city;
    private String district;
    private String longitude;
    private String latitude;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitud) {
        this.latitude = latitud;
    }
}
