import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AA CLEAN AI')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Každý odpad má svoje miesto.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('🤖', style: TextStyle(fontSize: 70)),
                    SizedBox(height: 20),
                    Text(
                      'Ahoj.\nSom Cleany.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Odfoť odpad alebo sa ma opýtaj.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            FilledButton.icon(
              onPressed: () async {
                final imagePath = await context.push<String>('/camera');
                if (!context.mounted || imagePath == null) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fotografia odpadu je pripravená na analýzu.')),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Padding(
                padding: EdgeInsets.all(18),
                child: Text('ODFOTIŤ ODPAD', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () => context.push('/chat'),
              icon: const Icon(Icons.smart_toy),
              label: const Padding(
                padding: EdgeInsets.all(18),
                child: Text('SPÝTAŤ SA AI', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Najčastejšie otázky',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Text('🍕'),
              title: Text('Kam patrí mastná krabica od pizze?'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const ListTile(
              leading: Text('🪥'),
              title: Text('Kam patrí zubná kefka?'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const ListTile(
              leading: Text('☕'),
              title: Text('Kam patrí papierový pohár od kávy?'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const ListTile(
              leading: Text('💊'),
              title: Text('Kam patria staré lieky?'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          // TODO: Implement navigation to other screens
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Domov'),
          NavigationDestination(icon: Icon(Icons.camera_alt), label: 'Scan'),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Výzvy'),
          NavigationDestination(icon: Icon(Icons.public), label: 'Svet'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
