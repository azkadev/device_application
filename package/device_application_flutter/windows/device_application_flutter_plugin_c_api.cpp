#include "include/device_application_flutter/device_application_flutter_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "device_application_flutter.h"

void DeviceApplicationFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  device_application_flutter::DeviceApplicationFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
