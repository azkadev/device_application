import 'dart:io';

import 'package:general_lib/general_lib.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  Directory directory = Directory(path.join(Directory.current.uri.toFilePath(), "lib", "scheme"));
  if (directory.existsSync()) {
    directory.deleteSync(recursive: true);
  }
  directory.createSync(recursive: true);
  await jsonToScripts(schemes, directory: directory);
  exit(0);
}

List<Map> schemes = [
  {
    "@type": "deviceApplicationApp",
    "app_name": "",
    "apk_file_path": "",
    "app_icon": "",
    "package_name": "",
    "version_name": "",
    "version_code": 0,
    "data_dir": "",
    "system_app": false,
    "install_time": 0,
    "update_time": 0,
    "is_enabled": false,
    "category": "",
    "event_type": "",
    "time": 0,
    // : appName = map['app_name'] as String,
    //   apkFilePath = map['apk_file_path'] as String,
    //   versionName = map['version_name'] as String?,
    //   versionCode = map['version_code'] as int,
    //   dataDir = map['data_dir'] as String,
    //   systemApp = map['system_app'] as bool,
    //   installTimeMillis = map['install_time'] as int,
    //   updateTimeMillis = map['update_time'] as int,
    //   enabled = map['is_enabled'] as bool,
    //   category = _parseCategory(map['category']),
  }, 
];
