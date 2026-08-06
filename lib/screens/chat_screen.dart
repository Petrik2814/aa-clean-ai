import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ask Clean AI')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: Center(child: Text('Ask how to dispose of any item.')),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type a question…',
                suffixIcon: Icon(Icons.send),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
