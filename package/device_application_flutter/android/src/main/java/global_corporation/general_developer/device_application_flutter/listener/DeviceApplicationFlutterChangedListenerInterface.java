package global_corporation.general_developer.device_application_flutter.listener;

import io.flutter.plugin.common.EventChannel;

public interface DeviceApplicationFlutterChangedListenerInterface {

    void onPackageInstalled(String packageName, EventChannel.EventSink events);

    void onPackageUpdated(String packageName, EventChannel.EventSink events);

    void onPackageUninstalled(String packageName, EventChannel.EventSink events);

    void onPackageChanged(String packageName, EventChannel.EventSink events);

}
