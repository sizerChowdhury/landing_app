import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(DestinationApp());
}

class DestinationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destination App',
      home: DestinationHomePage(),
    );
  }
}

class DestinationHomePage extends StatefulWidget {
  @override
  _DestinationHomePageState createState() => _DestinationHomePageState();
}

class _DestinationHomePageState extends State<DestinationHomePage> {
  static const platform = MethodChannel('com.example.destination_app/deep_link');
  String _receivedMessage = "https://via.placeholder.com/300/09f/fff.png";

  @override
  void initState() {
    super.initState();
    _getDeepLinkMessage();
  }

  Future<void> _getDeepLinkMessage() async {
    platform.setMethodCallHandler((call) async {
      if (call.method == "passMessage") {
        final message = call.arguments as String;
        setState(() {
          _receivedMessage = message;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destination App"),
      ),
      body: Center(
        // child: Text(_receivedMessage),
        child: Image.network(
          _receivedMessage
        ),
      ),
    );
  }
}
