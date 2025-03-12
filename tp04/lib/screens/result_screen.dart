import 'package:flutter/material.dart';
import 'package:tp02/screens/start_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final double temps;
  final String message;

  const ResultScreen({
    required this.score,
    required this.temps,
    required this.message,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap the Container in a Center widget
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center children horizontally
            children: [
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Vous avez un score de $score points en $temps secondes',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StartScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(Icons.arrow_right_alt),
                label: const Text('Rejouer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
