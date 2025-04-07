import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final GetStorage _storage = GetStorage();

  // 用户
  static _LS<String> user_token = _LS('user_token');
  static _LS<String> user_uid = _LS('user_uid');
  static _LS<String> user_nickName = _LS('user_nickName');
  static _LS<String> user_avatar = _LS('user_avatar');
  static _LS<String> user_userName = _LS('user_userName');
  static _LS<String> user_mobile = _LS('user_mobile');
  static _LS<String> user_college = _LS('user_college');
  static _LS<String> user_gender = _LS('user_gender');
  static _LS<String> user_dormBuilding = _LS('user_dormBuilding');
  static _LS<String> user_dormNumber = _LS('user_dormNumber');

  // 课表
  static _LS<String> timetable_college = _LS('timetable_college');
  static _LS<String> timetable_jw_uf = _LS('timetable_jw_uf');
  static _LS<String> timetable_vleCookie = _LS('timetable_vleCookie');
  static _LS<String> timetable_vleUsername = _LS('timetable_vleUsername');
  static _LS<String> timetable_vlePassword = _LS('timetable_vlePassword');
  static _LS<bool> timetable_inited = _LS('timetable_inited');
  static _LS<Map> timetable_data = _LS('timetable_data');
}

class _LS<T> {
  final String key;
  final GetStorage _storage = GetStorage();

  _LS(this.key);

  T? get() {
    var v = _storage.read(key);
    if (v == null) {
      return null;
    }
    if (v is String && v.startsWith('@@**JSON^^@@')) {
      v = v.substring('@@**JSON^^@@'.length);
      return json.decode(v) as T;
    }
    return v as T?;
  }

  void set(T value) {
    if (value is Map) {
      _storage.write(key, '@@**JSON^^@@${json.encode(value)}');
    } else {
      _storage.write(key, value);
    }
  }
}
