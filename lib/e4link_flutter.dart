// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'e4link_flutter_platform_interface.dart';
import 'models.dart';

class E4linkFlutter {
  static const _address = "127.0.0.1";
  static const _port = 28000;
  static Map<String, Socket> devices = {};
  static final StreamController<E4Event> _eventStream =
      StreamController<E4Event>();

  static Stream<E4Event> get eventStream => _eventStream.stream;
  static final Map<String, E4EventType> eventTypes = {
    "E4_Bvp": E4EventType.bvp,
    "E4_Temperature": E4EventType.tmp,
    "E4_Gsr": E4EventType.gsr,
    "E4_Ibi": E4EventType.ibi,
    "E4_Hr": E4EventType.hr
  };

  Future<String?> getPlatformVersion() {
    return E4linkFlutterPlatform.instance.getPlatformVersion();
  }

  static Future<List<E4Device>> discoverDevices() async {
    var socket = await Socket.connect(_address, _port);
    socket.write("device_list\r\n");
    await for (final event in socket) {
      List<E4Device> deviceList = [];
      String result = utf8.decode(event);
      List<String> splitted = result.split(' ');
      if (splitted[0] == "R" && splitted[1] == "device_list") {
        List<String> devices = result.split(" | ").sublist(1);
        for (var device in devices) {
          List<String> deviceSplitted = device.split(" ");
          deviceList.add(E4Device(deviceSplitted[0], deviceSplitted[1], true));
        }
        socket.close();
        return deviceList;
      }
    }
    socket.close();
    return [];
  }

  //This method handles the received data from E4
  static void handleEvent(id, event) {
    String results = utf8.decode(event);
    print(results);
    for (String result in results.split('\n')) {
      if (result.isEmpty) continue;

      //print(id + result);
      List<String> splitted = result.split(' ');
      if (splitted[1] == "device_connect") {
        _eventStream.add(E4Event(id, E4EventType.connected, 0, "OK"));
      }
      switch (splitted[0]) {
        case 'E4_Bvp':
        case 'E4_Temperature':
        case 'E4_Ibi':
        case 'E4_Gsr':
        case 'E4_Hr':
          {
            _eventStream.add(E4Event(
                id,
                eventTypes[splitted[0]] ?? E4EventType.unknown,
                double.parse(splitted[1]),
                double.tryParse(splitted[2]) ?? splitted[2]));
          }
          break;
      }
    }
  }

  //This method connects to a device and stores the socket used for connection in this Map called devices.
  static Future<void> connect(String id) async {
    print("connecting $id");
    var socket = await Socket.connect(_address, _port);
    print("connected");
    socket.listen(
      (event) => handleEvent(id, event),
      onError: (error) {
        print(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    var command = "device_connect $id\r\n";
    print(command);
    socket.write(command);
    devices[id] = socket;
    Future.delayed(Duration(seconds: 3));
  }

  static Future<void> subscribe(String id, String feature) async {
    await Future.delayed(Duration(milliseconds: 500));
    devices[id]?.write("device_subscribe $feature ON\r\n");
  }

  static void unsubscribe(String id, String feature) {
    devices[id]?.write("device_subscribe $feature OFF\r\n");
  }
}
