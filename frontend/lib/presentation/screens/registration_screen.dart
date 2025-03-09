import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the login screen after successful registration
            Navigator.pushNamed(context, '/login');
          },
          child: Text('Register'),
        ),
      ),
    );
  }
}
