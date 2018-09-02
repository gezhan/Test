package com.rrkc.Location;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;

import com.rrkc.R;

import java.util.List;

public class AddressAdapter extends BaseAdapter {
    private Activity mContext;
    private ResultHolder holder;
    private List<AddressBean> beanList;

    public AddressAdapter(Activity context, List<AddressBean> addList) {
        beanList = addList;
        mContext = context;
    }


    @Override
    public int getCount() {
        return (beanList == null || beanList.size() == 0) ? 0 : beanList.size();
    }

    @Override
    public Object getItem(int position) {
        return beanList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            holder = new ResultHolder();
            convertView = LayoutInflater.from(mContext).inflate(R.layout.item_search_bottom_result, null);
            holder.ivPic = (ImageView) convertView.findViewById(R.id.iv_home_search_result_hor_img);
            holder.tvName = (MyTextView) convertView.findViewById(R.id.tv_search_result_address);
            holder.tvTime = (MyTextView) convertView.findViewById(R.id.tv_search_result_detail_address);
            convertView.setTag(holder);
        } else {
            holder = (ResultHolder) convertView.getTag();
        }
        AddressBean bean = beanList.get(position);
        holder.tvName.setText(bean.getAddress());
        holder.tvTime.setText(bean.getDetailAddress());
        return convertView;
    }

    private class ResultHolder {
        ImageView ivPic;
        MyTextView tvName, tvTime;
    }
}
