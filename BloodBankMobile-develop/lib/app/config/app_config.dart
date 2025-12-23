class AppConfig {
  final String appName;

  AppConfig({
    required this.appName,
  });
  String get backendUrl => "http://xxx.xxx.xxx.xxx:yyy/";
  factory AppConfig.prod() => AppConfig(appName: 'RoomMobileWeb');
}
