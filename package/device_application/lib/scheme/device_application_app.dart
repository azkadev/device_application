// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class DeviceApplicationApp extends JsonScheme {
  DeviceApplicationApp(super.rawData);

  static Map get defaultData {
    return {"@type": "deviceApplicationApp", "app_name": "", "apk_file_path": "", "app_icon": "", "package_name": "", "version_name": "", "version_code": 0, "data_dir": "", "system_app": false, "install_time": 0, "update_time": 0, "is_enabled": false, "category": "", "event_type": "", "time": 0};
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  set special_type(String? value) {
    rawData["@type"] = value;
  }

  String? get app_name {
    try {
      if (rawData["app_name"] is String == false) {
        return null;
      }
      return rawData["app_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set app_name(String? value) {
    rawData["app_name"] = value;
  }

  String? get apk_file_path {
    try {
      if (rawData["apk_file_path"] is String == false) {
        return null;
      }
      return rawData["apk_file_path"] as String;
    } catch (e) {
      return null;
    }
  }

  set apk_file_path(String? value) {
    rawData["apk_file_path"] = value;
  }

  String? get app_icon {
    try {
      if (rawData["app_icon"] is String == false) {
        return null;
      }
      return rawData["app_icon"] as String;
    } catch (e) {
      return null;
    }
  }

  set app_icon(String? value) {
    rawData["app_icon"] = value;
  }

  String? get package_name {
    try {
      if (rawData["package_name"] is String == false) {
        return null;
      }
      return rawData["package_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set package_name(String? value) {
    rawData["package_name"] = value;
  }

  String? get version_name {
    try {
      if (rawData["version_name"] is String == false) {
        return null;
      }
      return rawData["version_name"] as String;
    } catch (e) {
      return null;
    }
  }

  set version_name(String? value) {
    rawData["version_name"] = value;
  }

  num? get version_code {
    try {
      if (rawData["version_code"] is num == false) {
        return null;
      }
      return rawData["version_code"] as num;
    } catch (e) {
      return null;
    }
  }

  set version_code(num? value) {
    rawData["version_code"] = value;
  }

  String? get data_dir {
    try {
      if (rawData["data_dir"] is String == false) {
        return null;
      }
      return rawData["data_dir"] as String;
    } catch (e) {
      return null;
    }
  }

  set data_dir(String? value) {
    rawData["data_dir"] = value;
  }

  bool? get system_app {
    try {
      if (rawData["system_app"] is bool == false) {
        return null;
      }
      return rawData["system_app"] as bool;
    } catch (e) {
      return null;
    }
  }

  set system_app(bool? value) {
    rawData["system_app"] = value;
  }

  num? get install_time {
    try {
      if (rawData["install_time"] is num == false) {
        return null;
      }
      return rawData["install_time"] as num;
    } catch (e) {
      return null;
    }
  }

  set install_time(num? value) {
    rawData["install_time"] = value;
  }

  num? get update_time {
    try {
      if (rawData["update_time"] is num == false) {
        return null;
      }
      return rawData["update_time"] as num;
    } catch (e) {
      return null;
    }
  }

  set update_time(num? value) {
    rawData["update_time"] = value;
  }

  bool? get is_enabled {
    try {
      if (rawData["is_enabled"] is bool == false) {
        return null;
      }
      return rawData["is_enabled"] as bool;
    } catch (e) {
      return null;
    }
  }

  set is_enabled(bool? value) {
    rawData["is_enabled"] = value;
  }

  String? get category {
    try {
      if (rawData["category"] is String == false) {
        return null;
      }
      return rawData["category"] as String;
    } catch (e) {
      return null;
    }
  }

  set category(String? value) {
    rawData["category"] = value;
  }

  String? get event_type {
    try {
      if (rawData["event_type"] is String == false) {
        return null;
      }
      return rawData["event_type"] as String;
    } catch (e) {
      return null;
    }
  }

  set event_type(String? value) {
    rawData["event_type"] = value;
  }

  num? get time {
    try {
      if (rawData["time"] is num == false) {
        return null;
      }
      return rawData["time"] as num;
    } catch (e) {
      return null;
    }
  }

  set time(num? value) {
    rawData["time"] = value;
  }

  static DeviceApplicationApp create({
    String special_type = "deviceApplicationApp",
    String? app_name,
    String? apk_file_path,
    String? app_icon,
    String? package_name,
    String? version_name,
    num? version_code,
    String? data_dir,
    bool? system_app,
    num? install_time,
    num? update_time,
    bool? is_enabled,
    String? category,
    String? event_type,
    num? time,
  }) {
    // DeviceApplicationApp deviceApplicationApp = DeviceApplicationApp({
    Map deviceApplicationApp_data_create_json = {
      "@type": special_type,
      "app_name": app_name,
      "apk_file_path": apk_file_path,
      "app_icon": app_icon,
      "package_name": package_name,
      "version_name": version_name,
      "version_code": version_code,
      "data_dir": data_dir,
      "system_app": system_app,
      "install_time": install_time,
      "update_time": update_time,
      "is_enabled": is_enabled,
      "category": category,
      "event_type": event_type,
      "time": time,
    };

    deviceApplicationApp_data_create_json.removeWhere((key, value) => value == null);
    DeviceApplicationApp deviceApplicationApp_data_create = DeviceApplicationApp(deviceApplicationApp_data_create_json);

    return deviceApplicationApp_data_create;
  }
}
