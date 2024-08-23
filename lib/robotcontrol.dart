import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class RobotControlScreen extends StatelessWidget {
  final MqttServerClient client = MqttServerClient('broker.hivemq.com', '');

  RobotControlScreen() {
    _connect();
  }

  void _connect() async {
    client.logging(on: true);
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .authenticateAs('username', 'password')
        .withClientIdentifier('flutter_client')
        .keepAliveFor(60) // Must agree with the keep alive set above or not set
        .startClean() // Non persistent session for testing
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  void _onDisconnected() {
    print('Disconnected');
  }

  void _onConnected() {
    print('Connected');
  }

  void _onSubscribed(String topic) {
    print('Subscribed: $topic');
  }

  void _sendCommand(String command) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(command);
    client.publishMessage('controlServo', MqttQos.exactlyOnce, builder.payload!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robot Control'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Mjpeg(
              isLive: true,
              //stream: 'http://192.168.1.18:8000/stream.mjpg',
              stream: 'http://172.20.10.5:8000/stream.mjpg',
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ControlButton(
                        icon: Icons.arrow_upward,
                        onPressed: () {
                          _sendCommand('top');
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ControlButton(
                        icon: Icons.arrow_back,
                        onPressed: () {
                          _sendCommand('left');
                        },
                      ),
                      ControlButton(
                        icon: Icons.arrow_forward,
                        onPressed: () {
                          _sendCommand('right');
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ControlButton(
                        icon: Icons.arrow_downward,
                        onPressed: () {
                          _sendCommand('down');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  ControlButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(icon),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.white,
        padding: EdgeInsets.all(20.0),
        shape: CircleBorder(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RobotControlScreen(),
  ));
}
