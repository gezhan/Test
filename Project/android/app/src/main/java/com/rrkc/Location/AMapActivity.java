package com.rrkc.Location;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.AdapterView;
import android.widget.AutoCompleteTextView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
import com.amap.api.maps2d.AMap;
import com.amap.api.maps2d.CameraUpdateFactory;
import com.amap.api.maps2d.LocationSource;
import com.amap.api.maps2d.MapView;
import com.amap.api.maps2d.model.BitmapDescriptorFactory;
import com.amap.api.maps2d.model.CameraPosition;
import com.amap.api.maps2d.model.LatLng;
import com.amap.api.maps2d.model.Marker;
import com.amap.api.maps2d.model.MarkerOptions;
import com.amap.api.maps2d.model.MyLocationStyle;
import com.amap.api.services.core.AMapException;
import com.amap.api.services.core.LatLonPoint;
import com.amap.api.services.core.PoiItem;
import com.amap.api.services.poisearch.PoiResult;
import com.amap.api.services.poisearch.PoiSearch;
import com.facebook.react.ReactActivity;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.WritableMap;
import com.rrkc.Location.refresh.BGARefreshLayout;
import com.rrkc.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Project Name:zcmjr
 * Package Name:com.xiaobu.amap
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/8/10 09:50
 */

public class AMapActivity extends ReactActivity implements LocationSource, AMapLocationListener,
        AMap.OnCameraChangeListener, PoiSearch.OnPoiSearchListener, BGARefreshLayout.BGARefreshLayoutDelegate {
    private int screenWidth = 0; // 屏幕宽（像素，px）
    private MapView mMapView = null;
    private AMap aMap;
    private OnLocationChangedListener mListener;
    private AMapLocationClient mlocationClient;
    private AMapLocationClientOption mLocationOption;
    private MarkerOptions markerOption;
    private Marker marker;
    private boolean isFirst = true;
    private AutoCompleteTextView searchText;// 输入搜索关键字
    //搜索
    private ImageView ivBack;
    private String keyWord = "";// 要输入的poi搜索关键字
    private ProgressDialog progDialog = null;// 搜索时进度条
    private int currentPage = 1;// 当前页面，从0开始计数
    private PoiSearch.Query query;// Poi查询条件类
    private PoiSearch poiSearch;// POI搜索
    private LatLonPoint mLatLonPoint;
    //刷新
    private BGARefreshLayout refreshLayout;
    private boolean canLoadMore = false;
    //tips
    private MyTextView tvTips;
    //列表
    private boolean isShowMap = true;
    private boolean isSearching = false;
    private ListView mListView, mSearchListView;
    private AddressAdapter mAdapter;
    private AddressAdapter mSearchAdapter;
    private List<AddressBean> listData = new ArrayList<>();
    private List<AddressBean> searchData = new ArrayList<>();
    //回调
    private static Callback mCallback;

    /**
     * 搜索页面
     *
     * @param activity
     */
    public static void start(Activity activity, Callback callback) {
        if (activity != null) {
            Intent intent = new Intent(activity, AMapActivity.class);
            mCallback = callback;
            activity.startActivity(intent);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.layout_mapview);
        screenWidth = getWindowManager().getDefaultDisplay().getWidth();
        ivBack = (ImageView) findViewById(R.id.iv_back);
        tvTips = (MyTextView) findViewById(R.id.tv_tips);
        refreshLayout = (BGARefreshLayout) findViewById(R.id.pull_to_refresh);
        refreshLayout.setDelegate(this);
//        refreshLayout.setPullDownRefreshEnable(false);
        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isShowMap) {
                    WritableMap map = Arguments.createMap();
                    map.putInt("ret", 0);
                    mCallback.invoke(map);
                    mCallback = null;
                    finish();
                } else {
                    KeyBoardUtil.hide(AMapActivity.this);
                    searchText.clearFocus();
                }
            }
        });
        //获取地图控件引用
        mMapView = (MapView) findViewById(R.id.amap_map);
        //在activity执行onCreate时执行mMapView.onCreate(savedInstanceState)，创建地图
        mMapView.onCreate(savedInstanceState);
        mListView = (ListView) findViewById(R.id.lv_address);//分页列表
        mSearchListView = (ListView) findViewById(R.id.lv_search);
        mAdapter = new AddressAdapter(AMapActivity.this, listData);//分页列表adapter
        mSearchAdapter = new AddressAdapter(AMapActivity.this, searchData);
        mListView.setAdapter(mAdapter);
        mListView.setVisibility(View.GONE);
        mSearchListView.setAdapter(mSearchAdapter);
        mSearchListView.setVisibility(View.GONE);
        searchText = (AutoCompleteTextView) findViewById(R.id.keyWord);
        searchText.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (hasFocus) {
                    isShowMap = false;
                    mMapView.setVisibility(View.GONE);
                    mListView.setVisibility(View.GONE);
                    mSearchListView.setVisibility(View.VISIBLE);
                    tvTips.setVisibility(View.GONE);
                } else {
                    isShowMap = true;
                    mSearchListView.setVisibility(View.GONE);
                    mMapView.setVisibility(View.VISIBLE);
                    if (listData.size() > 0) {
                        mListView.setVisibility(View.VISIBLE);
                        tvTips.setVisibility(View.INVISIBLE);
                    } else {
                        mListView.setVisibility(View.GONE);
                        tvTips.setVisibility(View.VISIBLE);
                        tvTips.setText("请开始移动大头针搜索");
                    }
                    tvTips.setVisibility(View.INVISIBLE);
                }
            }
        });
        searchText.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (searchText.getText().toString().trim().length() != 0) {
                    if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                        keyWord = searchText.getText().toString();
                        KeyBoardUtil.hide(AMapActivity.this);
                        doKeyWordQuery();
                        return true;
                    }
                } else {
                    Toast.makeText(AMapActivity.this, "请输入关键字！", Toast.LENGTH_SHORT).show();
                    return true;
                }
                return false;
            }
        });
        mSearchListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                AddressBean bean = (AddressBean) parent.getAdapter().getItem(position);
                if (mCallback != null) {
                    WritableMap map = Arguments.createMap();
                    map.putInt("ret",1);
                    map.putString("city", bean.getCity());
                    map.putString("province", bean.getProvince());
                    map.putString("longitudeLocation", bean.getLongitude());
                    map.putString("latitudeLocation", bean.getLatitude());
                    map.putString("district", bean.getDistrict());
                    map.putString("name", bean.getAddress());
                    mCallback.invoke(map);
                    mCallback = null;
                }
                finish();
            }
        });
        mListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                AddressBean bean = (AddressBean) parent.getAdapter().getItem(position);
                if (mCallback != null) {
                    WritableMap map = Arguments.createMap();
                    map.putInt("ret",1);
                    map.putString("city", bean.getCity());
                    map.putString("province", bean.getProvince());
                    map.putString("longitudeLocation", bean.getLongitude());
                    map.putString("latitudeLocation", bean.getLatitude());
                    map.putString("district", bean.getDistrict());
                    map.putString("name", bean.getAddress());
                    mCallback.invoke(map);
                    mCallback = null;
                }
                finish();
            }
        });
        searchText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                if (!TextUtils.isEmpty(s)) {
                    keyWord = searchText.getText().toString();
                    doKeyWordQuery();
//                    KeyBoardUtil.toggle(AMapActivity.this);
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
        init();
    }

    @Override
    protected void onResume() {
        super.onResume();
        //在activity执行onResume时执行mMapView.onResume ()，重新绘制加载地图
        mMapView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        //在activity执行onPause时执行mMapView.onPause ()，暂停地图的绘制
        mMapView.onPause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        //在activity执行onDestroy时执行mMapView.onDestroy()，销毁地图
        aMap.setLocationSource(null);// 设置定位监听
        aMap.setOnCameraChangeListener(null);//设置一个可视范围变化时的回调的接口方法。
        mMapView.onDestroy();
        if (null != mlocationClient) {
            mlocationClient.onDestroy();
        }
    }

    /**
     * 初始化AMap对象
     */
    private void init() {
        if (aMap == null) {
            aMap = mMapView.getMap();
            setUpMap();
        }
    }

    /**
     * 设置一些amap的属性
     */
    private void setUpMap() {
        // 自定义系统定位小蓝点
        MyLocationStyle myLocationStyle = new MyLocationStyle();
        myLocationStyle.myLocationIcon(BitmapDescriptorFactory
                .fromResource(R.mipmap.location_marker));// 设置小蓝点的图标
//        myLocationStyle.strokeColor(Color.BLACK);// 设置圆形的边框颜色
        myLocationStyle.radiusFillColor(Color.argb(100, 0, 0, 180));// 设置圆形的填充颜色
        myLocationStyle.showMyLocation(false);
        // myLocationStyle.anchor(int,int)//设置小蓝点的锚点
        myLocationStyle.myLocationType(MyLocationStyle.LOCATION_TYPE_LOCATE);
        myLocationStyle.strokeWidth(1.0f);// 设置圆形的边框粗细
        aMap.setMyLocationStyle(myLocationStyle);
        aMap.moveCamera(CameraUpdateFactory.zoomTo(18));//设置地图的缩放级别
        aMap.setLocationSource(this);// 设置定位监听
        aMap.setOnCameraChangeListener(this);//设置一个可视范围变化时的回调的接口方法。
        aMap.getUiSettings().setZoomControlsEnabled(false);//设置缩放按钮不显示
        aMap.getUiSettings().setScrollGesturesEnabled(true);
        aMap.getUiSettings().setMyLocationButtonEnabled(false);// 设置默认定位按钮是否显示
        aMap.setMyLocationEnabled(true);// 设置为true表示显示定位层并可触发定位，false表示隐藏定位层并不可触发定位，默认是false
    }

    /**
     * 在地图上添加marker
     */
    private void addMarkersToMap(LatLng latlng) {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inSampleSize = 2;
        Bitmap bitmap = BitmapFactory
                .decodeResource(getResources(), R.mipmap.marker_location, options);
        markerOption = new MarkerOptions().icon(BitmapDescriptorFactory.fromBitmap(bitmap))
                .position(latlng)
                .draggable(true);
        marker = aMap.addMarker(markerOption);
        isFirst = false;
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        //在activity执行onSaveInstanceState时执行mMapView.onSaveInstanceState (outState)，保存地图当前的状态
        mMapView.onSaveInstanceState(outState);
    }

    @Override
    public void activate(OnLocationChangedListener listener) {
        mListener = listener;
        if (mlocationClient == null) {
            mlocationClient = new AMapLocationClient(this);
            mLocationOption = new AMapLocationClientOption();
            //设置定位监听
            mlocationClient.setLocationListener(this);
            //设置为高精度定位模式
            mLocationOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
            mLocationOption.setOnceLocation(true);
            //设置定位参数
            mlocationClient.setLocationOption(mLocationOption);
            // 此方法为每隔固定时间会发起一次定位请求，为了减少电量消耗或网络流量消耗，
            // 注意设置合适的定位时间的间隔（最小间隔支持为2000ms），并且在合适时间调用stopLocation()方法来取消定位请求
            // 在定位结束后，在合适的生命周期调用onDestroy()方法
            // 在单次定位情况下，定位无论成功与否，都无需调用stopLocation()方法移除请求，定位sdk内部会移除
            mlocationClient.startLocation();
        }
    }

    @Override
    public void deactivate() {
        mListener = null;
        if (mlocationClient != null) {
            mlocationClient.stopLocation();
            mlocationClient.onDestroy();
        }
        mlocationClient = null;
    }

    @Override
    public void onLocationChanged(AMapLocation amapLocation) {
        Log.e("定位", amapLocation.getLatitude() + amapLocation.getLongitude() + "");
        if (mListener != null && amapLocation != null) {
            if (amapLocation != null
                    && amapLocation.getErrorCode() == 0) {
                LatLng latlng = new LatLng(amapLocation.getLatitude(), amapLocation.getLongitude());
//                aMap.clear();
                mListener.onLocationChanged(amapLocation);// 显示系统小蓝点
//                aMap.moveCamera(CameraUpdateFactory.changeLatLng(latlng));
                if (isFirst) {
                    addMarkersToMap(latlng);
                    aMap.moveCamera(CameraUpdateFactory.changeLatLng(latlng));
                }
            } else {
                String errText = "定位失败," + amapLocation.getErrorCode() + ": " + amapLocation.getErrorInfo();
                Log.e("AmapErr", errText);
            }
        }
    }

    @Override
    public void onCameraChange(CameraPosition cameraPosition) {

    }

    @Override
    public void onCameraChangeFinish(CameraPosition cameraPosition) {
        LatLng latlng = cameraPosition.target;
        LatLonPoint latLonPoint = new LatLonPoint(cameraPosition.target.latitude, cameraPosition.target.longitude);
        Log.e("定位===", latlng.latitude + "," + latlng.longitude);
        marker.setPosition(latlng);
        marker.setPositionByPixels(screenWidth / 2, (int) ((mMapView.getY() + mMapView.getHeight()) / 2));
        doSearchQuery(latLonPoint);
        mLatLonPoint = latLonPoint;
//        aMap.clear();
//        aMap. moveCamera(CameraUpdateFactory.changeLatLng(latlng));
    }

    @Override
    public void onPoiSearched(PoiResult result, int rcode) {
        Log.e("定位", "onPoiSearched" + rcode + "====" + isShowMap + "====" + isSearching);
        refreshLayout.endLoadingMore();
        refreshLayout.endRefreshing();
        if (isShowMap || isSearching) {
            isSearching = false;
            if (rcode == AMapException.CODE_AMAP_SUCCESS) {
                if (result != null && result.getQuery() != null) {// 搜索poi的结果
                    PoiResult poiResult;
                    List<PoiItem> poiItems;
                    if (result.getQuery().equals(query)) {// 是否是同一条
                        poiResult = result;
                        poiItems = poiResult.getPois();// 取得第一页的poiitem数据，页数从数字0开始
                        if (poiItems != null && poiItems.size() > 0) {
                            if (listData.size() > 0)
                                listData.clear();
                            for (PoiItem poiItem : poiItems) {
                                AddressBean bean = new AddressBean();
                                bean.setAddress(poiItem.getTitle());
                                bean.setDetailAddress(poiItem.getSnippet());
                                bean.setProvince(poiItem.getProvinceName());
                                bean.setCity(poiItem.getCityName());
                                bean.setDistrict(poiItem.getAdName());
                                bean.setLongitude(poiItem.getLatLonPoint().getLongitude() + "");
                                bean.setLatitude(poiItem.getLatLonPoint().getLatitude() + "");
                                listData.add(bean);
                            }
                            Log.e("定位", "poiItems.size:" + poiItems.size());
                            if (poiItems.size() < 10) {
                                canLoadMore = false;
                            } else {
                                canLoadMore = true;
                            }
                            mAdapter.notifyDataSetChanged();
                            mListView.setSelection(0);
                            if (isShowMap) {
                                mListView.setVisibility(View.VISIBLE);
                                tvTips.setVisibility(View.INVISIBLE);
                            } else {
                                tvTips.setVisibility(View.GONE);
                                mListView.setVisibility(View.GONE);
                                mSearchListView.setVisibility(View.VISIBLE);
                            }
                        } else {
                            tvTips.setText("没有搜索到相关数据哦");
                            mListView.setVisibility(View.GONE);
//                            ToastUtil.show(AMapActivity.this, "对不起，没有搜索到相关数据！");
                        }
                    }
                } else {
                    tvTips.setText("没有搜索到相关数据哦");
                    mListView.setVisibility(View.GONE);
//                    ToastUtil.show(AMapActivity.this, "对不起，没有搜索到相关数据！");
                }
            } else {
                mListView.setVisibility(View.GONE);
//                ToastUtil.showerror(AMapActivity.this, rcode);
            }
        } else if (!isShowMap) {
            if (rcode == AMapException.CODE_AMAP_SUCCESS) {
                if (result != null && result.getQuery() != null) {// 搜索poi的结果
                    PoiResult poiResult;
                    List<PoiItem> poiItems;
                    if (result.getQuery().equals(query)) {// 是否是同一条
                        poiResult = result;
                        poiItems = poiResult.getPois();// 取得第一页的poiitem数据，页数从数字0开始
                        if (poiItems != null && poiItems.size() > 0) {
                            if (searchData.size() > 0)
                                searchData.clear();
                            for (PoiItem poiItem : poiItems) {
                                AddressBean bean = new AddressBean();
                                bean.setAddress(poiItem.getTitle());
                                bean.setDetailAddress(poiItem.getSnippet());
                                bean.setProvince(poiItem.getProvinceName());
                                bean.setCity(poiItem.getCityName());
                                bean.setDistrict(poiItem.getAdName());
                                bean.setLongitude(poiItem.getLatLonPoint().getLongitude() + "");
                                bean.setLatitude(poiItem.getLatLonPoint().getLatitude() + "");
                                searchData.add(bean);
                            }
                            mSearchAdapter.notifyDataSetChanged();
                            mSearchListView.setSelection(0);
                        } else {
//                            mSearchListView.setVisibility(View.GONE);
                            ToastUtil.show(AMapActivity.this, "对不起，没有搜索到相关数据！");
                        }
                    }
                } else {
//                    mSearchListView.setVisibility(View.GONE);
                    ToastUtil.show(AMapActivity.this, "对不起，没有搜索到相关数据！");
                }
            }
        }
    }

    @Override
    public void onPoiItemSearched(PoiItem poiItem, int i) {

    }

    /**
     * 开始进行地图指针poi搜索
     */
    protected void doSearchQuery(LatLonPoint latLonPoint) {
//        showProgressDialog();// 显示进度框
        currentPage = 1;
        query = new PoiSearch.Query("", "");// 第一个参数表示搜索字符串，第二个参数表示poi搜索类型，第三个参数表示poi搜索区域（空字符串代表全国）
        query.setPageSize(10);// 设置每页最多返回多少条poiitem
        query.setPageNum(currentPage);// 设置查第一页
        query.setCityLimit(false);//搜索关键字时是否严格按照设置城市搜索

        poiSearch = new PoiSearch(this, query);
        poiSearch.setOnPoiSearchListener(this);
        poiSearch.setBound(new PoiSearch.SearchBound(latLonPoint, 200, true));//
        // 设置搜索区域为以lp点为圆心，其周围200米范围
        poiSearch.searchPOIAsyn();// 异步搜索
        tvTips.setText("正在搜索中...");
        isSearching = true;
    }

    /**
     * 开始进行poi关键字搜索
     */
    protected void doKeyWordQuery() {
//        showProgressDialog();// 显示进度框
        currentPage = 1;
        query = new PoiSearch.Query(keyWord, "");// 第一个参数表示搜索字符串，第二个参数表示poi搜索类型，第三个参数表示poi搜索区域（空字符串代表全国）
        query.setPageSize(30);// 设置每页最多返回多少条poiitem
        query.setPageNum(currentPage);// 设置查第一页
        query.setCityLimit(false);//搜索关键字时是否严格按照设置城市搜索

        poiSearch = new PoiSearch(this, query);
        poiSearch.setOnPoiSearchListener(this);
        poiSearch.searchPOIAsyn();
        isSearching = false;
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            if (isShowMap) {
                finish();
            } else {
                KeyBoardUtil.hide(AMapActivity.this);
                searchText.clearFocus();
                return false;
            }
            return true;
        } else {
            return super.onKeyDown(keyCode, event);
        }
    }

    @Override
    public void onBGARefreshLayoutBeginRefreshing(BGARefreshLayout refreshLayout) {
        currentPage = 1;
        query.setPageNum(currentPage);// 设置查第一页
        poiSearch.searchPOIAsyn();// 异步搜索
        tvTips.setText("正在搜索中...");
    }

    @Override
    public boolean onBGARefreshLayoutBeginLoadingMore(BGARefreshLayout refreshLayout) {
        Log.e("定位", canLoadMore + "");
        if (canLoadMore) {
            ++currentPage;
            query.setPageNum(currentPage);
            poiSearch.searchPOIAsyn();// 异步搜索
            tvTips.setText("正在搜索中...");
            return true;
        } else {
            return false;
        }
    }
}