import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

/// Root widget of the interval timer app.
class App extends StatelessWidget {
  /// Creates the root widget.
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Interval Timer',
      home: Scaffold(
        body: Center(child: Text('Interval Timer')),
      ),
    );
  }
}
