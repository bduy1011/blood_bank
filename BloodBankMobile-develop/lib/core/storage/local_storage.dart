// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:blood_donation/models/authentication.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract class ILocalStorage {
  Future<void> init();
  Authentication? get authentication;
  Future<void> saveAuthentication({required Authentication authentication});
  Future<void> clearAuthentication();
}

class LocalStorage extends ILocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();
  factory LocalStorage() {
    return _singleton;
  }
  LocalStorage._internal();

  static const String ACCESS_TOKEN = "ACCESS_TOKEN";
  static const String AUTHENTICATION = "AUTHENTICATION";

  late Box _box;

  @override
  Future<void> init() async {
    if (Platform.isAndroid || Platform.isIOS) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    _box = await Hive.openBox("box");
  }

  @override
  Authentication? get authentication {
    final data = _box.get(AUTHENTICATION, defaultValue: null);
    if (data != null) {
      return Authentication.fromJson(json.decode(data));
    }
    return null;
  }

  @override
  Future<void> clearAuthentication() {
    return _box.delete(AUTHENTICATION);
  }

  @override
  Future<void> saveAuthentication({required Authentication authentication}) {
    return _box.put(AUTHENTICATION, json.encode(authentication.toJson()));
  }
}
