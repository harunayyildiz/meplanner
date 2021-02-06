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
