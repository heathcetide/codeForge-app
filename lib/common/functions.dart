import 'dart:io';
import 'dart:typed_data';
import 'package:demo_project/common/local_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:demo_project/api/user_api.dart';

final UserApi userApi = UserApi();

DateTime getZeroOclockOfDay(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

String padLeft(int num, [int length = 2, String fill = '0']) {
  return num.toString().padLeft(length, '0');
}

String getChineseStringByDatetime(DateTime dateTime, [DateTime? now]) {
  now ??= DateTime.now();
  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    int min = now.hour * 60 + now.minute - dateTime.hour * 60 - dateTime.minute;
    if (min <= 1) return '刚刚';
    if (min < 60) return '$min分钟前';
    return '${now.hour - dateTime.hour}小时前';
  }
  int day =
      getZeroOclockOfDay(now).difference(getZeroOclockOfDay(dateTime)).inDays;
  if (day <= 0) return '未来(请检查本机系统时间)';
  if (day == 1)
    return '昨天${padLeft(dateTime.hour)}:${padLeft(dateTime.minute)}';
  if (day == 2) return '前天';
  if (day <= 7) {
    return '$day天前';
  }
  if (dateTime.year == now.year) {
    return '${padLeft(dateTime.month)}-${padLeft(dateTime.day)}';
  }
  return '${dateTime.year}-${padLeft(dateTime.month)}-${padLeft(dateTime.day)}';
}

Future<void> syncUserInfo() async {
  var resp = await userApi.getUserInfo();
}

Future<void> saveUserInfo(userInfo) async {
  clearMemoryImageCache();
  await clearDiskCachedImage(userInfo['user']['userAvatar']);
  await clearDiskCachedImage(userInfo['user']['userAvatar'] + '_original');
}

Future<void> saveNetworkImage(String imageUrl, context) async {
  if (Platform.isAndroid) {
    final bool suc = await requestStoragePermission();
    if (!suc) {
      SmartDialog.showNotify(msg: '请先授权存储权限', notifyType: NotifyType.error);
      return;
    }
  }
}

Future<bool> requestStoragePermission() async {
  final DeviceInfoPlugin info = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await info.androidInfo;
  final int androidVersion = int.parse(androidInfo.version.release);
  bool havePermission = false;
  if (androidVersion >= 13) {
    final request = await [Permission.videos, Permission.photos].request();

    havePermission = request.values.every(
      (status) => status == PermissionStatus.granted,
    );
  } else {
    final status = await Permission.storage.request();
    havePermission = status.isGranted;
  }
  if (!havePermission) {
    await openAppSettings();
  }
  return havePermission;
}

Future<Uint8List> getCompressedImage(
  Uint8List image, {
  minHeight = 1920,
  minWidth = 1920,
  quality = 88,
}) async {
  var result = await FlutterImageCompress.compressWithList(
    image,
    minHeight: minHeight,
    minWidth: minWidth,
    quality: quality,
  );
  return result;
}
