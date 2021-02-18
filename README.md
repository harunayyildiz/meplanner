# :part_alternation_mark: mePlanner 

<br>
:date: Görevlerinizi net ve kolay bir şekilde organize edin.
<br>
 :hourglass_flowing_sand: Hedefleriniz yerine getirin ve yaptığınız görevleri takip edin. 
<br>
:mega: Unutmamak için Herhangi bir göreve hatırlatıcı ekleyin.
<br>
:zap: Hemen Başlayın!

# Play Store

:point_right: Hemen Kullanmak için: [tıklayınız](https://play.google.com/store/apps/details?id=com.meplanner)
<br>
:key: Gizlilik Politikası için [tıklayınız](https://www.harunayyildiz.com/gizlilik-bildirimi/)

# Özellikler
- Israrlı Bildirimler
- Özel Bildirim Sesi

Dark Mode | Light Mode
------------ | -------------
<img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/HomePage_Dark.png" alt="Dark Mode" width="220" height="391"> | <img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/HomePage_Light.png" alt="Light Mode" width="220" height="391">



Tamamlanmış Görevler | Tamamlanmamış Görevler
------------ | -------------
<img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/NoItem_Dark.png" alt="Dark Mode" width="220" height="391"> | <img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/NoItem_Light.png" alt="Light Mode" width="220" height="391">


Yeni Görev | Yeni Görev
------------ | -------------
<img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/NewTodo_Dark.png" alt="Yeni Görev" width="220" height="391"> | <img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/NewTodo_Light.png" alt="Light Mode" width="220" height="391">


Görevi Güncelle | Görevi Güncelle
------------ | -------------
<img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/UpdateTodo_Dark.png" alt="Dark Mode" width="220" height="391"> | <img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/UpdateTodo_Light.png" alt="Light Mode" width="220" height="391">

Notification(Android) | Notification(IOS)
------------ | -------------
<img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/Notification_Android.jpg" alt="Geçmiş Ödül" width="220" height="391"> | <img src="https://github.com/harunayyildiz/meplanner/blob/master/assets/Notification_Ios.png" alt="Geçmiş Ödül" width="220" height="391">


# Android Notification settings:
# 1- app/build.gradge
```

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
            minifyEnabled true
            shrinkResources true
             // flutter_local_notification için Eklendi (Bildirimlerin Bozulmaması için...🔔)
            proguardFiles getDefaultProguardFile(
                    'proguard-android.txt'),
                    'proguard-rules.pro'
        }
    }
    
 ```
# 2- app/src/proguard-rules.pro Dosyasını oluştur

 ```
 # Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { <fields>; }

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

-keep public class LocalNotification

##---------------End: proguard configuration for Gson  ----------

 ```
                   
# 3- androidManifest.xml
```
    <!-- Notification and INTERNET Permission -->
         <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
         <uses-permission android:name="android.permission.VIBRATE" />
         <uses-permission android:name="android.permission.INTERNET" />
         <uses-permission android:name="android.permission.WAKE_LOCK" />
```
  
```
     <activity
    android:showWhenLocked="true"
    android:turnScreenOn="true">
    <!-- flutter_local_notification için Eklendi --> 🔔
    <!-- (Cihaz Kitli halde Bildirimin Gelmesi ve Ekranın Açılması için) 🔔 -->
    
 ```
 
  ```
         <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
            <!--Notification Start 🔔-->
    <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"></action>
            </intent-filter>
        </receiver>
        <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" /> 
            <!--Notification End 🔔-->   

```

# IOS Notification sessing:
meplanner/ios/Runner/AppDelegate.swift

# License 
## MIT ~
<p><a target="_blank" rel="noopener noreferrer" href="https://camo.githubusercontent.com/4b8724b99a8519c22d968e1e441f3623f645adb89e7dde5fd467f679da96ae69/68747470733a2f2f6d65646961312e67697068792e636f6d2f6d656469612f5a486a53587a526b55575457452f3230302e676966"><img src="https://camo.githubusercontent.com/4b8724b99a8519c22d968e1e441f3623f645adb89e7dde5fd467f679da96ae69/68747470733a2f2f6d65646961312e67697068792e636f6d2f6d656469612f5a486a53587a526b55575457452f3230302e676966" alt="Yeay" data-canonical-src="https://media1.giphy.com/media/ZHjSXzRkUWTWE/200.gif" style="max-width:100%;"></a></p>
    
