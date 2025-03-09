import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to profile screen
            Navigator.pushNamed(context, '/profile');
          },
          child: Text('Go to Profile'),
        ),
      ),
    );
  }
}
