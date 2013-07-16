package com.lukejeter.familypics;

import android.os.Bundle;
import android.content.Context;
import android.support.v4.view.ViewPager;
import android.support.v4.app.FragmentActivity;

public class ImageActivity extends FragmentActivity
{
	ViewPager mViewPager;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_collection_demo);

        // ViewPager and its adapters use support library
        // fragments, so use getSupportFragmentManager.
        //mDemoCollectionPagerAdapter = new DemoCollectionPagerAdapter(getSupportFragmentManager());
        //mViewPager = (ViewPager) findViewById(R.id.pager);
        //mViewPager.setAdapter(mDemoCollectionPagerAdapter);
    }
}