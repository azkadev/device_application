// ignore_for_file: non_constant_identifier_names, empty_catches

import 'dart:async'; 

import 'package:device_application/core/device_application_core.dart';  
import 'package:device_application/scheme/device_application_app.dart'; 
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:general_lib/general_lib.dart';
 
void printToTerminal(dynamic value) {
  if (kDebugMode) {
    print(value);
  }
}

/// Plugin to list applications installed on an Android device
/// iOS is not supported
class DeviceApplicationFlutter extends DeviceApplication {
  static late final MethodChannel method_channel_device_application_flutter;
  static late final EventChannel event_channel_device_application_flutter_events;
  static bool isInitiaLized = false;
  static bool is_platform_support_library = () {
    if (Dart.isWeb) {
      return false;
    }
    return Dart.isAndroid;
  }();

  static bool get is_support_call_library {
    return (isInitiaLized && is_platform_support_library);
  }

  DeviceApplicationFlutter();

  @override
  bool get is_support_library {
    return is_platform_support_library;
  }

  @override
  void ensureInitialized() {
    if (isInitiaLized) {
      return;
    }
    if (is_support_library) {
      method_channel_device_application_flutter = MethodChannel('global_corporation/general_developer/device_application_flutter');
      event_channel_device_application_flutter_events = EventChannel('global_corporation/general_developer/device_application_flutter_events');
    }
    isInitiaLized = true;
  }

  /// List installed applications on the device
  /// [includeSystemApps] will also include system apps (or pre-installed) like
  /// Phone, Settings...
  /// [includeAppIcons] will also include the icon for each app (be aware that
  /// this feature is memory-heaving, since it will load all icons).
  /// To get the icon you have to cast the object to [ApplicationWithIcon]
  /// [onlyAppsWithLaunchIntent] will only list applications when an entrypoint.
  /// It is similar to what a launcher will display
  static Future<List<DeviceApplicationApp>> getInstalledApplications({
    bool includeSystemApps = false,
    bool includeAppIcons = false,
    bool onlyAppsWithLaunchIntent = false, 
  }) async {
    if (is_support_call_library == false) {
      return [];
    }
    try {
      final Object apps = await method_channel_device_application_flutter.invokeMethod('getInstalledApps', <String, bool>{
        'system_apps': includeSystemApps,
        'include_app_icons': includeAppIcons,
        'only_apps_with_launch_intent': onlyAppsWithLaunchIntent, 
      });

      if (apps is Iterable) {
        final List<DeviceApplicationApp> list = <DeviceApplicationApp>[];
        for (Object app in apps) {
          if (app is Map) {
            try {
              list.add(DeviceApplicationApp(app)..special_type = "deviceApplicationApp");
            } catch (e, trace) {
              if (e is AssertionError) {
                
                printToTerminal('[DeviceApplicationFlutter] Unable to add the following app: $app');
              } else {
                printToTerminal('[DeviceApplicationFlutter] $e $trace');
              }
            }
          }
        }
        return list;
      } else {
        return List<DeviceApplicationApp>.empty();
      }
    } catch (err) {
      printToTerminal(err);
      return List<DeviceApplicationApp>.empty();
    }
  }

  /// Provide all information for a given app by its [packageName]
  /// [includeAppIcon] will also include the icon for the app.
  /// To get it, you have to cast the object to [ApplicationWithIcon].
  static Future<DeviceApplicationApp?> getApp(
    String packageName, [
    bool includeAppIcon = false,
  ]) async {
    if (is_support_call_library == false) {
      return null;
    }
    if (packageName.isEmpty) {
      return null;
    }
    try {
      final Object? app = await method_channel_device_application_flutter.invokeMethod('getApp', <String, Object>{'package_name': packageName, 'include_app_icon': includeAppIcon});

      if (app != null && app is Map<dynamic, dynamic>) {
        return DeviceApplicationApp(app)..special_type = "deviceApplicationApp";
      } else {
        return null;
      }
    } catch (err) {
      printToTerminal(err);
      return null;
    }
  }

  /// Returns whether a given [packageName] is installed on the device
  /// You will then receive in return a boolean
  static Future<bool> isAppInstalled(String packageName) async {
    if (is_support_call_library == false) {
      return false;
    }
    if (packageName.isEmpty) {
      return false;
    }
    try {
      return await method_channel_device_application_flutter.invokeMethod<bool>('isAppInstalled', <String, String>{'package_name': packageName}) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Launch an app based on its [packageName]
  /// You will then receive in return if the app was opened
  /// (will be false if the app is not installed, or if no "launcher" intent is
  /// provided by this app)
  static Future<bool> openApp(String packageName) async {
    if (is_support_call_library == false) {
      return false;
    }
    if (packageName.isEmpty) {
      return false;
    }
    try {
      return await method_channel_device_application_flutter.invokeMethod<bool>('openApp', <String, String>{'package_name': packageName}) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Launch the Settings screen of the app based on its [packageName]
  /// You will then receive in return if the app was opened
  /// (will be false if the app is not installed)
  static Future<bool> openAppSettings(String packageName) async {
    if (is_support_call_library == false) {
      return false;
    }
    if (packageName.isEmpty) {
      return false;
    }
    try {
      return await method_channel_device_application_flutter.invokeMethod<bool>('openAppSettings', <String, String>{'package_name': packageName}) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Uninstall an application by giving its [packageName]
  /// Note: It will only open the Android's screen
  static Future<bool> uninstallApp(String packageName) async {
    if (is_support_call_library == false) {
      return false;
    }
    if (packageName.isEmpty) {
      return false;
    }
    try {
      return await method_channel_device_application_flutter.invokeMethod<bool>('uninstallApp', <String, String>{'package_name': packageName}) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Listen to app changes: installations, uninstallations, updates, enabled or
  /// disabled. As it is a [Stream], don't hesite to filter data if the content
  /// is too verbose for you
  static Stream<DeviceApplicationApp> listenToAppsChanges() async* {
    if (is_support_call_library == false) {
      return;
    }
    await for (var event in event_channel_device_application_flutter_events.receiveBroadcastStream()) {
      try {
        yield DeviceApplicationApp(event as Map<dynamic, dynamic>)..special_type = "deviceApplicationApp";
      } catch (e) {}
    }
    return;
    // old
    // return event_channel_device_application_flutter_events.receiveBroadcastStream().map(((dynamic event) => ApplicationEvent._(event as Map<dynamic, dynamic>))).handleError((Object err) => null);
  
  
  }
}
  