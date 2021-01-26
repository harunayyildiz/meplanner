import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class LocalNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));
    var initializationSettingsAndroid =
        new AndroidInitializationSettings("ic_launcher");
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    this.flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Bir Bildirimi Anlık Gösterme (Özel Bildirim Sesi ile)

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound('custom_sound'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(100),
      'sad',
      'Harun Ayyıldlz',
      platformChannelSpecifics,
    );
  }

  //Bir Israrcı (Tıklayana kadar Aktif) Bildirimi Belirli bir zaman göre Gösterme (Özel Bildirim Sesi ile)

  Future<void> showInsistentNotification(
      {int todoKey,
      String title,
      String bodyText,
      int year,
      int month,
      int day,
      int oclock,
      int minute}) async {
    // Israrcı Bildirimi
    const int insistentFlag = 4;
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('custom_sound'),
            additionalFlags: Int32List.fromList(<int>[insistentFlag]),
            subText: 'Görevini Tamamladın mı?');

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    this.flutterLocalNotificationsPlugin.zonedSchedule(
        todoKey,
        title,
        bodyText,
        tz.TZDateTime(tz.local, year, month, day, oclock, minute),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  //Kaç Bildirim İsteği Olduğunu Görüntüleme

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
            '${pendingNotificationRequests.length} adet Bildirim İsteğiniz vardır'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  // TodoKey ile Bildirmi İptal Etme

  Future<void> cancelNotification({int key}) async {
    await this.flutterLocalNotificationsPlugin.cancel(key);
  }

  //Bir Bildirimi Belirli bir zaman göre Gösterme (Özel Bildirim Sesi ile)

  Future<void> schedule({
    int todoKey,
    String title,
    String bodyText,
    int year,
    int month,
    int day,
    int oclock,
    int minute,
  }) async {
    final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          sound: RawResourceAndroidNotificationSound('custom_sound'),
        ),
        iOS: IOSNotificationDetails());
    this.flutterLocalNotificationsPlugin.zonedSchedule(
        todoKey,
        title,
        bodyText,
        tz.TZDateTime(tz.local, year, month, day, oclock, minute),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  //Haftalık Bildirim Gösterme (Her Cuma)

  Future<void> scheduleweekly() async {
    final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
        iOS: IOSNotificationDetails());
    this.flutterLocalNotificationsPlugin.zonedSchedule(Random().nextInt(100),
        'Zamanlanmış', 'Bildirim', _nextinstanceofFriday(), notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime _nextinstanceofFriday() {
    tz.TZDateTime scheduleDate = _nextInstanceOfTenAM();
    while (scheduleDate.weekday != DateTime.friday) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 01, 31);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }

  //Kronometre ile Bildirim Gösterme

  Future<void> showNotificationWithChronometer() async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
      usesChronometer: true,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }
}
