import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Entry point of the application
void main() {
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MyHomePage(title: 'Counter App'),
    );
  }
}

// Stateful home page widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _opacity = 1.0; // For fade animation

  // Increments the counter and triggers fade animation
  void _incrementCounter() {
    setState(() {
      _counter++;
      _triggerFadeAnimation();
    });
  }

  // Decrements the counter and triggers fade animation
  void _decrementCounter() {
    setState(() {
      _counter--;
      _triggerFadeAnimation();
    });
  }

  // Resets the counter, triggers fade animation, and shows SnackBar
  void _resetCounter() {
    setState(() {
      _counter = 0;
      _triggerFadeAnimation();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Counter reset to zero!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Triggers a fade animation by changing opacity
  void _triggerFadeAnimation() {
    setState(() => _opacity = 0.3);
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _opacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic AppBar color based on counter value
    final appBarColor = _counter.isEven
        ? Theme.of(context).colorScheme.primary
        : Colors.amber;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current Count:'),
            CounterDisplay(counter: _counter, opacity: _opacity),
            const SizedBox(height: 40),
            ActionButtons(
              onIncrement: _incrementCounter,
              onDecrement: _decrementCounter,
              onReset: _resetCounter,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to display the counter with fade animation
class CounterDisplay extends StatelessWidget {
  final int counter;
  final double opacity;

  const CounterDisplay({
    super.key,
    required this.counter,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 200),
      child: Text(
        '$counter',
        style: GoogleFonts.poppins(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.teal[800],
        ),
      ),
    );
  }
}

// Widget to display action buttons
class ActionButtons extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  const ActionButtons({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              icon: Icons.add,
              tooltip: 'Increment',
              onPressed: onIncrement,
              color: Colors.teal,
            ),
            const SizedBox(width: 16),
            _buildButton(
              icon: Icons.remove,
              tooltip: 'Decrement',
              onPressed: onDecrement,
              color: Colors.teal,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildButton(
          icon: Icons.refresh,
          tooltip: 'Reset',
          onPressed: onReset,
          color: Colors.amber,
        ),
      ],
    );
  }

  // Helper method to build a styled button
  Widget _buildButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Icon(icon, size: 32, color: Colors.white),
    );
  }
}
