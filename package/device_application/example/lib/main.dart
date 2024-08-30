import 'package:device_application/flutter/flutter.dart';
import 'package:example/apps_events.dart';
import 'package:example/apps_list.dart'; 
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceApplicationFlutter().ensureInitialized();
  runApp(const MaterialApp(home: ExampleApp()));
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device apps demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Object>(builder: (BuildContext context) => AppsListScreen()),
                  );
                },
                child: const Text('Applications list')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Object>(builder: (BuildContext context) => AppsEventsScreen()),
                  );
                },
                child: const Text('Applications events'))
          ],
        ),
      ),
    );
  }
}
