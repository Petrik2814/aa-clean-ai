import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your profile')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(radius: 44, child: Icon(Icons.person, size: 44)),
            SizedBox(height: 16),
            Text('Eco explorer', style: TextStyle(fontSize: 22)),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.recycling),
              title: Text('Items sorted'),
              trailing: Text('0'),
            ),
          ],
        ),
      ),
    );
  }
}
