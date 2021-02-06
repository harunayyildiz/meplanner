# mePlanner

<br>
Görevlerinizi net ve kolay bir şekilde organize edin.
<br>
Hedefleriniz yerine getirin ve yaptığınız görevleri takip edin.
<br>
Unutmamak için Herhangi bir göreve hatırlatıcı ekleyin.
<br>
Hemen Başlayın!

## Play Store

Hemen Kullanmak için: [tıklayınız](xx)
<br>
Gizlilik Politikası için [tıklayınız](https://www.harunayyildiz.com/gizlilik-bildirimi/)

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


Notification IOS sessing:
meplanner/ios/Runner/AppDelegate.swift

Android Notification settings:
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
  
    
    
