import 'package:flutter/material.dart';

class ServiceListScreen extends StatelessWidget {
  final String category; // The parameter to hold the category

  // Constructor to receive the category
  const ServiceListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services for $category',
        ), // Using the category in the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here are the available services for the $category category:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            // This would list services in a real app
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Placeholder count, replace with dynamic data
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Service ${index + 1}',
                      ), // Placeholder for service name
                      subtitle: Text('Details for service ${index + 1}'),
                      onTap: () {
                        // Handle the tap (e.g., navigate to service details)
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
