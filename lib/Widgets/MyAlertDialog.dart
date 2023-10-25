import 'package:flutter/material.dart';
import 'package:flutter_simple_page/Services/ApiClient.dart';

class MyAlertDialog extends StatefulWidget {
  final String alertMessage;
  MyAlertDialog({required this.alertMessage});

  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('API Request'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.alertMessage),
          const SizedBox(height: 16),
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              // Make your API request here
              //await ApiClient.makeApiRequest();
              //setState(() {
                //_isLoading = false;
              //});
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
