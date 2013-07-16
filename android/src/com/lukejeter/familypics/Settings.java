package com.lukejeter.familypics;
/**
 * Settings.java
 * This class provides the settings menu for the app.
 * 
 * "Picture service url":
 * " ":
 */
 
import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.Preference.OnPreferenceClickListener;
import android.widget.Toast;

public class Settings extends PreferenceActivity
{
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		addPreferencesFromResource(R.xml.settings);
		Preference customPref = (Preference) findPreference("customPref");
        customPref.setOnPreferenceClickListener(new OnPreferenceClickListener() {
			public boolean onPreferenceClick(Preference preference) {
					Toast.makeText(getBaseContext(),
									"The custom preference has been clicked",
									Toast.LENGTH_LONG).show();
					SharedPreferences customSharedPreference = getSharedPreferences(
									"myCustomSharedPrefs", Activity.MODE_PRIVATE);
					SharedPreferences.Editor editor = customSharedPreference.edit();
					editor.putString("myCustomPref", "The preference has been clicked");
					editor.commit();
					return true;
			}
		});
    }
}
