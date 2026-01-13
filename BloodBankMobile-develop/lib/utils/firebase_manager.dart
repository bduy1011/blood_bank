import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/app_version.dart';

class FireBaseManager {
  FireBaseManager();
  FireBaseManager._();
  static var instance = FireBaseManager._();
  final linkDataBase =
      "https://blood-bank-8d3544-default-rtdb.asia-southeast1.firebasedatabase.app";

  static String firebaseToken = "";

  String getPath(String endpoint) {
    return "$linkDataBase/$endpoint";
  }

  ///

  void getDataAppVersion(Function(AppVersion?)? callback) async {
    // TẠM THỜI TẮT Firebase để tránh crash (API Key không đúng)
    // TODO: Bật lại khi có GoogleService-Info.plist đúng
    callback?.call(null);
    return;
    
    /*
    try {
      final firebaseApp = Firebase.app();
      final rtdb = FirebaseDatabase.instanceFor(
          app: firebaseApp, databaseURL: '$linkDataBase/');
      var ref = rtdb.ref("AppVersion");
      ref.onValue.listen((event) {
        if (event.snapshot.value == null) {
          callback?.call(null);
          return;
        }
        final json = (event.snapshot.value as Map<Object?, Object?>)
            .cast<String, dynamic>();
        AppVersion version = AppVersion.fromJson(json);
        callback?.call(version);
      });
    } catch (e, t) {
      print(e);
      print(t);
      // TODO
    }
    */
  }

  ///
  //

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  ///

  ///init
  Future<void> initFireBaseMessage({
    VoidCallback? complete,
    Function(RemoteMessage message)? onOpenAppByNotification,
  }) async {
    ///
    ///

    await registerNotification(complete);
    await setupFlutterNotifications(onOpenAppByNotification);

    ///
    ///
    onMessage();
    onMessageOpenedApp(onOpenAppByNotification);
    onMessageOpenedAppBackground(onOpenAppByNotification);
    onNotificationOpenApp(onOpenAppByNotification);

    //
  }

  static bool isFlutterLocalNotificationsInitialized = false;
  static Future<void> registerNotification(VoidCallback? complete) async {
    // TẠM THỜI TẮT Firebase Messaging để tránh crash
    // TODO: Bật lại khi có GoogleService-Info.plist đúng
    complete?.call();
    return;
    
    /*
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      try {
        debugPrint('User granted permission');
        await FirebaseMessaging.instance.setAutoInitEnabled(true);
        String? token = "";

        token = await FirebaseMessaging.instance.getToken();

        firebaseToken = token ?? "";
        print("fireBaseToken: $token");
        FirebaseMessaging.onBackgroundMessage(
            _firebaseMessagingBackgroundHandler);
      } catch (e, t) {
        // TODO
        debugPrint('fireBaseException $e');
        debugPrint('fireBaseException $t');
      }
    } else {
      debugPrint('User declined or has not accepted permission');
    }
    onTokenRefresh((token) {});
    complete?.call();
    */
  }

  static void onTokenRefresh(Function(String) complete) async {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      debugPrint(token.toString());
      debugPrint("onTokenRefresh: $token");
      complete.call(token);
    });
  }

  //When app open
  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(message.toString());
      debugPrint(message.messageId);
      if (Platform.isAndroid) {
        FireBaseManager.showFlutterNotification(message);
      }
      debugPrint("onMessage ${message.toMap()}");
    });
  }

  static Future<void> onTerminalState(VoidCallback complete) async {
    try {
      await Firebase.initializeApp();
      await FirebaseMessaging.instance.getInitialMessage();
    } catch (e) {
      // Bỏ qua lỗi Firebase nếu có
      debugPrint('Firebase onTerminalState error: $e');
    }
    complete.call();
  }

  // For handling notification when the app
  // but not terminated
  static void onMessageOpenedApp(Function(RemoteMessage)? onMessageOpenedApp) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(message.toString());
      debugPrint(message.messageId);
      debugPrint("onMessageOpenedApp ");
      onMessageOpenedApp?.call(message);
    });
  }

  //For handling notification when the app is in background
  //app terminated
  static void onMessageOpenedAppBackground(
      Function(RemoteMessage)? onOpenApp) async {
    RemoteMessage? value = await FirebaseMessaging.instance.getInitialMessage();
    if (value != null) {
      debugPrint("onMessageOpenedAppBackground ");
      onOpenApp?.call(value);
    }
  }

  //For handling notification when the app is in background
  //app terminated
  static void onNotificationOpenApp(Function(RemoteMessage)? onOpenApp) async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await FireBaseManager.flutterLocalNotificationsPlugin
            ?.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      var payload = RemoteMessage.fromMap(jsonDecode(
          notificationAppLaunchDetails?.notificationResponse?.payload ?? ""));
      onOpenApp?.call(payload);
    }
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  static late AndroidNotificationChannel channel;

  static Future<void> setupFlutterNotifications(
      Function(RemoteMessage)? onOpenAppByNotification) async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'hien_mau_cho_ray_channel', // id
      'Hiến Máu Chợ Rẫy', // title
      description: 'Hiến Máu Chợ Rẫy', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            print(
                "NotificationResponseType.selectedNotification ${notificationResponse.payload}");
            onOpenAppByNotification?.call(RemoteMessage.fromMap(
                jsonDecode(notificationResponse.payload ?? "")));
            break;
          case NotificationResponseType.selectedNotificationAction:
            print(
                "NotificationResponseType.selectedNotificationAction ${notificationResponse.payload}");
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;

    ///
  }

  static void showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    String? imageUrl = android?.imageUrl;
    BigPictureStyleInformation? bigPictureStyleInformation;
    String? bigPicturePath;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      // final String largeIconPath =
      //     await _downloadAndSaveFile(imageUrl, 'largeIcon');
      bigPicturePath = await _downloadAndSaveFile(imageUrl, 'bigPicture');
      if (bigPicturePath != null) {
        bigPictureStyleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          contentTitle: message.notification?.title,
          summaryText: message.notification?.body,
        );
      }
    }
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin?.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              icon: 'icon_notification',
              styleInformation: bigPictureStyleInformation,
              largeIcon: bigPicturePath != null
                  ? FilePathAndroidBitmap(bigPicturePath)
                  : null),
        ),
      );
    }
  }

  static Future<String?> _downloadAndSaveFile(
      String url, String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/$fileName';
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      // TODO
    }
    return null;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("_firebaseMessagingBackgroundHandler ");
  // await Firebase.initializeApp();
  // await FirebaseManage.setupFlutterNotifications((m) {});
  // FirebaseManage.showFlutterNotification(message);
  // await setupFlutterNotifications();
  // FirebaseManage.instance.showFlutterNotification(message);
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}
