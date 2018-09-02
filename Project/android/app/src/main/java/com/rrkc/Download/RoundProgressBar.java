package com.rrkc.Download;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Style;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.view.View;

import com.rrkc.R;

/**
 * 仿iphone带进度的进度条，线程安全的View，可直接在线程中更新进度
 * 
 * @author panjun 2015年5月12日下午7:43:32
 *
 *
 */
@SuppressLint("DrawAllocation")
public class RoundProgressBar extends View {
	/**
	 * 画笔对象的引用
	 */
	private Paint mCirclePaint, mTextPaint;

	/**
	 * 圆环的颜色
	 */
	private int roundColor;

	/**
	 * 圆环进度的颜色
	 */
	private int roundProgressColor;

	/**
	 * 中间进度百分比的字符串的颜色
	 */
	private int textColor;

	/**
	 * 中间进度百分比的字符串的字体
	 */
	private float textSize;

	/**
	 * 圆环的宽度
	 */
	private float roundWidth;

	/**
	 * 最大进度
	 */
	private int max;

	/**
	 * 当前进度
	 */
	private int progress;
	/**
	 * 是否显示中间的进度
	 */
	private boolean textIsDisplayable;

	/**
	 * 进度的风格，实心或者空心
	 */
	private int style;
	
	private Paint mProgressPaint = new Paint();
	Shader mSweepGradient;

	public static final int STROKE = 0;
	public static final int FILL = 1;

	public RoundProgressBar(Context context) {
		this(context, null);
	}

	public RoundProgressBar(Context context, AttributeSet attrs) {
		this(context, attrs, 0);
	}

	public RoundProgressBar(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);

		TypedArray mTypedArray = context.obtainStyledAttributes(attrs, R.styleable.RoundProgressBar);

		// 获取自定义属性和默认值
		roundColor = mTypedArray.getColor(R.styleable.RoundProgressBar_roundColor, Color.parseColor("#f7f7f7"));
		roundProgressColor = mTypedArray.getColor(R.styleable.RoundProgressBar_roundProgressColor, Color.parseColor("#4e89eb"));
		textColor = mTypedArray.getColor(R.styleable.RoundProgressBar_textColor, Color.parseColor("#4e89eb"));
		textSize = mTypedArray.getDimension(R.styleable.RoundProgressBar_textSize, 35);
		roundWidth = mTypedArray.getDimension(R.styleable.RoundProgressBar_roundWidth, 6);
		max = mTypedArray.getInteger(R.styleable.RoundProgressBar_max, 100);
		textIsDisplayable = mTypedArray.getBoolean(R.styleable.RoundProgressBar_textIsDisplayable, true);
		style = mTypedArray.getInt(R.styleable.RoundProgressBar_style, 0);
		
		mCirclePaint = new Paint();
		mCirclePaint.setAntiAlias(true); // 消除锯齿
		mCirclePaint.setDither(true);
		mCirclePaint.setColor(roundColor); // 设置圆环的颜色
		mCirclePaint.setStyle(Style.STROKE); // 设置空心
		mCirclePaint.setStrokeWidth(roundWidth); // 设置圆环的宽度
		mCirclePaint.setAntiAlias(true); // 消除锯齿
		mCirclePaint.setDither(true);

		mTextPaint = new Paint();
		mTextPaint.setAntiAlias(true); // 消除锯齿
		mTextPaint.setDither(true);
		mTextPaint.setStrokeWidth(0);
		mTextPaint.setColor(textColor);
		mTextPaint.setTextSize(textSize);
		mTextPaint.setTypeface(Typeface.DEFAULT); // 设置字体

		mProgressPaint.setStyle(Style.STROKE);
		mProgressPaint.setStrokeWidth(roundWidth);
		mProgressPaint.setAntiAlias(true); // 消除锯齿
		mProgressPaint.setDither(true);
		mProgressPaint.setColor(roundProgressColor); // 设置进度的颜色

		// mSweepGradient = new SweepGradient(0, 0, new int[] {
		// Color.parseColor("#ffbbbb"),Color.parseColor("#FF0000"),
		// Color.parseColor("#ffbbbb"),Color.parseColor("#FF0000"),
		// Color.parseColor("#ffbbbb"),Color.parseColor("#FF0000")}, null);
		// // 绘制梯度渐变
		// mProgressPaint.setShader(mSweepGradient);


		mTypedArray.recycle();
	}

	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
	}

	@Override
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);

		/**
		 * 画最外层的大圆环
		 */
		int centre = getWidth() / 2; // 获取圆心的x坐标
		int radius = (int) (centre - roundWidth / 2); // 圆环的半径
		canvas.drawCircle(centre, centre, radius, mCirclePaint); // 画出圆环

		/**
		 * 画进度百分比
		 */
		int percent = (int) (((float) progress / (float) max) * 100);
		// 中间的进度百分比，先转换成float在进行除法运算，不然都为0
		float textWidth = mTextPaint.measureText(percent + "%"); // 测量字体宽度，我们需要根据字体的宽度设置在圆环中间
		if (textIsDisplayable && style == STROKE) {
			mTextPaint.setStyle(Style.FILL);
			canvas.drawText(percent + "%", centre - textWidth / 2, centre + textSize / 2 - 4, mTextPaint); // 画出进度百分比
		}

		/**
		 * 画圆弧 ，画圆环的进度
		 */

		RectF oval = new RectF(centre - radius, centre - radius, centre + radius, centre + radius); // 用于定义的圆弧的形状和大小的界限

		switch (style) {
		case STROKE: {
			mProgressPaint.setStyle(Style.STROKE);
			canvas.drawArc(oval, -90, 360 * progress / max, false, mProgressPaint); // 根据进度画圆弧
			break;
		}
		case FILL: {
			mProgressPaint.setStyle(Style.FILL_AND_STROKE);
			if (progress != 0)
				canvas.drawArc(oval, -90, 360 * progress / max, true, mProgressPaint); // 根据进度画圆弧
			break;
		}
		}

	}

	public synchronized int getMax() {
		return max;
	}

	/**
	 * 设置进度的最大值
	 * 
	 * @param max
	 */
	public synchronized void setMax(int max) {
		if (max < 0) {
			throw new IllegalArgumentException("max not less than 0");
		}
		this.max = max;
	}

	/**
	 * 获取进度.需要同步
	 * 
	 * @return
	 */
	public synchronized int getProgress() {
		return progress;
	}

	/**
	 * 设置进度，此为线程安全控件，由于考虑多线的问题，需要同步 刷新界面调用postInvalidate()能在非UI线程刷新
	 * 
	 * @param progress
	 */
	public synchronized void setProgress(int progress) {
		if (progress < 0) {
			throw new IllegalArgumentException("progress not less than 0");
		}
		if (progress > max) {
			progress = max;
		}
		if (progress <= max) {
			this.progress = progress;
			postInvalidate();
		}

	}

	public int getCricleColor() {
		return roundColor;
	}

	public void setCricleColor(int cricleColor) {
		this.roundColor = cricleColor;
	}

	public int getCricleProgressColor() {
		return roundProgressColor;
	}

	public void setCricleProgressColor(int cricleProgressColor) {
		this.roundProgressColor = cricleProgressColor;
	}

	public int getTextColor() {
		return textColor;
	}

	public void setTextColor(int textColor) {
		this.textColor = textColor;
	}

	public float getTextSize() {
		return textSize;
	}

	public void setTextSize(float textSize) {
		this.textSize = textSize;
	}

	public float getRoundWidth() {
		return roundWidth;
	}

	public void setRoundWidth(float roundWidth) {
		this.roundWidth = roundWidth;
	}

}
