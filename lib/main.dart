import 'package:flutter/material.dart';

void main() {
  runApp(const UnifyApp());
}

// STATLESS WIDGET: The Root of Unify
// This builds the theme and top-level navigation structure.
class UnifyApp extends StatelessWidget {
  const UnifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unify Campus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Using a professional 'Unify' palette
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E), // Deep Indigo
          primary: const Color(0xFF1A237E),
          secondary: const Color(0xFFFFC107), // Amber/Gold
        ),
      ),
      home: const UnifyHomeScreen(),
    );
  }
}

// STATEFUL WIDGET: The Reactive Dashboard
// This handles dynamic data updates, like event check-ins.
class UnifyHomeScreen extends StatefulWidget {
  const UnifyHomeScreen({super.key});

  @override
  State<UnifyHomeScreen> createState() => _UnifyHomeScreenState();
}

class _UnifyHomeScreenState extends State<UnifyHomeScreen> {
  int _attendeeCount = 0; // Our 'State' variable

  // The Reactive Function
  void _markAttendance() {
    setState(() {
      // Calling setState triggers the Widget Tree to rebuild
      _attendeeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unify | Event Central'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.hub_outlined, size: 100, color: Color(0xFF1A237E)),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Welcome to Unify',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Centralizing campus communication.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 50),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('Ongoing Event: Club Orientation'),
                    const SizedBox(height: 10),
                    Text(
                      '$_attendeeCount',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    const Text('Students Checked In'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _markAttendance,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Check-In to Event'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}