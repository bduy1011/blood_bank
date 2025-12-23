// To parse this JSON data, do
//
//     final config = configFromJson(jsonString);

import 'dart:convert';

class AppVersion {
  //Bắt buộc update ngay cả 2 nền tảng
  bool? isForceUpdate;
  //Hiển thị thông báo update
  bool? isShowUpdate;
  //Tiêu đề thông báo update
  String? updateTitle;
  //Nội dung thông báo update
  String? updateContent;
  //Version mới nhất Android
  String? androidVersion;
  //Version mới nhất IOS
  String? iosVersion;
  //Link update IOS
  String? linkUpdateIos;
  //Link update Android
  String? linkUpdateAndroid;

  DateTime? updateDate;

  bool deadLineUpdate(){
    if (updateDate == null) return true;
    var now = DateTime.now();
    return now.isAfter(updateDate!);
  }

  AppVersion({
    this.isForceUpdate,
    this.isShowUpdate,
    this.updateTitle,
    this.updateContent,
    this.androidVersion,
    this.iosVersion,
    this.linkUpdateIos,
    this.linkUpdateAndroid,
    this.updateDate,
  });

  factory AppVersion.fromRawJson(String str) => AppVersion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppVersion.fromJson(Map<String, dynamic> json) => AppVersion(
    isForceUpdate:  json["isForceUpdate"],
    isShowUpdate:  json["isShowUpdate"],
    updateTitle: json["updateTitle"],
    updateContent: json["updateContent"],
    androidVersion: json["androidVersion"],
    iosVersion: json["iosVersion"],
    linkUpdateIos: json["linkUpdateIos"],
    linkUpdateAndroid: json["linkUpdateAndroid"],
    updateDate: json["dateUpdate"] != null ? DateTime.parse(json["dateUpdate"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "isForceUpdate": isForceUpdate,
    "isShowUpdate": isShowUpdate,
    "updateTitle": updateTitle,
    "updateContent": updateContent,
    "androidVersion": androidVersion,
    "iosVersion": iosVersion,
    "linkUpdateIOS": linkUpdateIos,
    "linkUpdateAndroid": linkUpdateAndroid,
    "dateUpdate": updateDate?.toIso8601String(),
  };
}
