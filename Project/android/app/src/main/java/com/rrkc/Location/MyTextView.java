package com.rrkc.Location;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.support.annotation.Nullable;
import android.support.v7.widget.AppCompatTextView;
import android.util.AttributeSet;

/**
 * Project Name:zcmjr
 * Package Name:com.xiaobu.amap
 * Class Description:
 * Created By:firecloud
 * Created Time:2017/8/11 21:36
 */

public class MyTextView extends AppCompatTextView {


    Paint.FontMetricsInt fontMetricsInt;
    boolean adjustTopForAscent = true;

    public MyTextView(Context context) {
        super(context);
    }

    public MyTextView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public MyTextView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }


    @Override
    protected void onDraw(Canvas canvas) {
        if (adjustTopForAscent){//设置是否remove间距，true为remove
            if (fontMetricsInt == null){
                fontMetricsInt = new Paint.FontMetricsInt();
                getPaint().getFontMetricsInt(fontMetricsInt);
            }
            canvas.translate(0, fontMetricsInt.top - fontMetricsInt.ascent);
        }
        super.onDraw(canvas);
    }
}
