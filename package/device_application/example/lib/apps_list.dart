// import 'package:device_apps/device_apps.dart';
// import 'package:device_application_flutter/device_apps.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:device_application/flutter/flutter.dart';
import 'package:device_application/scheme/device_application_app.dart';
import 'package:flutter/material.dart';

class AppsListScreen extends StatefulWidget {
  const AppsListScreen({super.key});

  @override
  State<AppsListScreen> createState() => _AppsListScreenState();
}

class _AppsListScreenState extends State<AppsListScreen> {
  bool _showSystemApps = false;
  bool _onlyLaunchableApps = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed applications'),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                const PopupMenuItem<String>(value: 'system_apps', child: Text('Toggle system apps')),
                const PopupMenuItem<String>(
                  value: 'launchable_apps',
                  child: Text('Toggle launchable apps only'),
                )
              ];
            },
            onSelected: (String key) {
              if (key == 'system_apps') {
                setState(() {
                  _showSystemApps = !_showSystemApps;
                });
              }
              if (key == 'launchable_apps') {
                setState(() {
                  _onlyLaunchableApps = !_onlyLaunchableApps;
                });
              }
            },
          )
        ],
      ),
      body: _AppsListScreenContent(
        includeSystemApps: _showSystemApps,
        onlyAppsWithLaunchIntent: _onlyLaunchableApps,
        key: GlobalKey(),
      ),
    );
  }
}

class _AppsListScreenContent extends StatelessWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  const _AppsListScreenContent({
    super.key,
    this.includeSystemApps = false,
    this.onlyAppsWithLaunchIntent = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DeviceApplicationApp>>(
      future: Future(() async {
        final List<DeviceApplicationApp> result = await DeviceApplicationFlutter.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: includeSystemApps,
          onlyAppsWithLaunchIntent: onlyAppsWithLaunchIntent,
        );
        result.sort((a, b) {
          return (a.app_name ?? "").trim().toLowerCase().compareTo((b.app_name ?? "").trim().toLowerCase());
        });
        return result;
      }),
      builder: (BuildContext context, AsyncSnapshot<List<DeviceApplicationApp>> data) {
        if (data.data == null || data.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final List<DeviceApplicationApp> apps = data.data ?? [];

          return Scrollbar(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int position) {
                DeviceApplicationApp app = apps[position];
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: () {
                        String appIcon = (app.app_icon ?? "").trim();
                        if (appIcon.isEmpty) {
                          return null;
                        }
                        Uint8List? appIconData = () {
                          try {
                            return base64.decode(appIcon);
                          } catch (e) {
                            return null;
                          }
                        }();
                        if (appIconData == null) {
                          return null;
                        }
                        return CircleAvatar(
                          backgroundImage: MemoryImage(appIconData),
                          backgroundColor: Colors.white,
                        );
                      }(),
                      onTap: () => onAppClicked(context, app),
                      title: Text('${app.app_name} (${app.package_name})'),
                      subtitle: Text(
                        'Version: ${app.version_name}\n'
                        'System app: ${app.system_app}\n'
                        'APK file path: ${app.apk_file_path}\n'
                        'Data dir: ${app.data_dir}\n'
                        'Installed: ${DateTime.fromMillisecondsSinceEpoch((app.install_time ?? 0).toInt()).toString()}\n'
                        'Updated: ${DateTime.fromMillisecondsSinceEpoch((app.update_time ?? 0).toInt()).toString()}'
                        'Special Type: ${app.special_type}',
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                    )
                  ],
                );
              },
              itemCount: apps.length,
            ),
          );
        }
      },
    );
  }

  void onAppClicked(BuildContext context, DeviceApplicationApp app) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(app.app_name ?? ""),
          actions: <Widget>[
            _AppButtonAction(
              label: 'Open app',
              onPressed: () {
                DeviceApplicationFlutter.openApp(app.package_name ?? "");
              },
            ),
            _AppButtonAction(
              label: 'Open app settings',
              onPressed: () {
                // app.openSettingsScreen()
                DeviceApplicationFlutter.openAppSettings(app.package_name ?? "");
              },
            ),
            _AppButtonAction(
              label: 'Uninstall app',
              onPressed: () async {
                DeviceApplicationFlutter.uninstallApp(app.package_name ?? "");
              },
            ),
          ],
        );
      },
    );
  }
}

class _AppButtonAction extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _AppButtonAction({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed?.call();
        Navigator.of(context).maybePop();
      },
      child: Text(label),
    );
  }
}
