package com.aepanalytics;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;

import java.util.HashMap;
import java.util.Map;

import com.adobe.marketing.mobile.AdobeCallback;
import com.adobe.marketing.mobile.Analytics;
import com.adobe.marketing.mobile.Identity;
import com.adobe.marketing.mobile.InvalidInitException;
import com.adobe.marketing.mobile.Lifecycle;
import com.adobe.marketing.mobile.LoggingMode;
import com.adobe.marketing.mobile.MobileCore;
import com.adobe.marketing.mobile.Signal;
import com.adobe.marketing.mobile.UserProfile;


public class AepApplication extends Application {
    public static final String TAG = "AepApplication";

    @Override
    public void onCreate() {
        super.onCreate();

        SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("com.aepanalytics.AepApplication", Context.MODE_PRIVATE);

        if (sharedPref.getBoolean("firstrun", true)) {
            Boolean aepPluginEnabled = false;
            if (aepPluginEnabled == false) {
                return;
            }

            MobileCore.setApplication(this);
            MobileCore.setLogLevel(LoggingMode.DEBUG);

            try {
                Analytics.registerExtension();
                UserProfile.registerExtension();
                Identity.registerExtension();
                Lifecycle.registerExtension();
                Signal.registerExtension();
                
                MobileCore.start(new AdobeCallback () {
                    @Override
                    public void call(Object o) {
                        MobileCore.configureWithAppID("{AepAppId}");
                        MobileCore.lifecycleStart(null);
                        
                        Map<String, String> additionalContextData = new HashMap<String, String>();
                        additionalContextData.put("platform", "android");
                        MobileCore.trackAction("install", additionalContextData);
                    }
                });
            } catch (InvalidInitException e) {
                System.out.println("### AepAnalytics - Error");
                System.out.println(e);
            }

            sharedPref.edit().putBoolean("firstrun", false).commit();
        } else {
            System.out.println("### AepAnalytics - Not the first install");
        }
    }
}
