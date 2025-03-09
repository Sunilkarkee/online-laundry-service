import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the services list screen
            Navigator.pushNamed(context, '/services', arguments: 'categoryName');
          },
          child: Text('Go to Services'),
        ),
      ),
    );
  }
}
