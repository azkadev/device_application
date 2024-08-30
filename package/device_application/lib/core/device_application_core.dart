// ignore_for_file: non_constant_identifier_names

class DeviceApplication {
  static bool isInitiaLized = false;

  DeviceApplication();

  bool get is_support_library {
    return false;
  }

  void ensureInitialized() {
    if (isInitiaLized) {
      return;
    }
  }
}
