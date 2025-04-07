
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart' as http;

void main() => runApp(SolidaritySMSApp());

class SolidaritySMSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solidarity SMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _message = '';

  // Function to request SMS permissions
  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.sms.request();
    if (status.isGranted) {
      _fetchMessageFromAPI();
    } else {
      // Handle the case when permissions are not granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMS permission is required')),
      );
    }
  }

  // Function to fetch message from API
  Future<void> _fetchMessageFromAPI() async {
    final url = 'https://lobay95670.pythonanywhere.com/get-message'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          _message = jsonResponse['message']; // Assuming the API returns a JSON object with a "message" field
        });

        // After fetching the message, send it
        _sendMessage();
      } else {
        throw Exception('Failed to load message');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch message from API: $e')),
      );
    }
  }

  // Function to send SMS
  Future<void> _sendMessage() async {
    if (_message.isNotEmpty) {
      try {
        await sendSMS(
          message: _message,
          recipients: ['<recipient-phone-number>'], // Add the recipient number here
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message sent successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No message to send')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solidarity SMS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _message.isNotEmpty ? 'Message: $_message' : 'Fetching message...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermissions,
              child: Text('Fetch and Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
