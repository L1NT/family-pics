package com.lukejeter.familypics;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MenuInflater;

public class FamilyPics extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
    }
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu, menu);
        return true;
    }
    
    @Override
    public boolean onMenuItemSelected(int featureId, MenuItem item) {
        switch (item.getItemId()) {
            case R.id.upload:
                //archive(item);
                return true;
            case R.id.settings:
				Intent settingsActivity = new Intent(getBaseContext(), Settings.class);
                startActivity(settingsActivity);
//                Settings settings = new Settings();
//                settings.show();
                return true;
            case R.id.exit:
                finish();
                return true;
            default:
                return false;
        }
    }
}
