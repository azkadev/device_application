import 'dart:async';
import 'package:device_application/flutter/flutter.dart';
import 'package:device_application/scheme/device_application_app.dart';

import 'package:flutter/material.dart';

class AppsEventsScreen extends StatefulWidget {
  const AppsEventsScreen({super.key});

  @override
  State<AppsEventsScreen> createState() => _AppsEventsScreenState();
}

class _AppsEventsScreenState extends State<AppsEventsScreen> {
  final List<DeviceApplicationApp> _events = <DeviceApplicationApp>[];
  late StreamSubscription<DeviceApplicationApp> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = DeviceApplicationFlutter.listenToAppsChanges().listen((DeviceApplicationApp event) {
      setState(() {
        _events.add(event);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications events'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Visibility(
            visible: _events.isNotEmpty,
            child: _EventsList(events: _events),
          ),
          Visibility(
            visible: _events.isEmpty,
            child: const Center(child: Text('No event yet!')),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class _EventsList extends StatelessWidget {
  final Iterable<DeviceApplicationApp> _events;

  _EventsList({required List<DeviceApplicationApp> events}) : _events = events.reversed;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int position) {
          return KeyedSubtree(key: Key('$position'), child: _AppEventItem(event: _events.elementAt(position)));
        },
        itemCount: _events.length,
      ),
    );
  }
}

class _AppEventItem extends StatelessWidget {
  final DeviceApplicationApp event;

  const _AppEventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(event.package_name ?? ""),
          subtitle: Text(event.event_type ?? ""),
          leading: Text('${DateTime.fromMillisecondsSinceEpoch((event.time ?? 0).toInt()).hour}:${DateTime.fromMillisecondsSinceEpoch((event.time ?? 0).toInt()).minute}'),
        ),
        const Divider()
      ],
    );
  }
} 