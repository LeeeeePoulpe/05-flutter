import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final void Function(int, int) startGame;

  const StartScreen({
    required this.startGame,
    Key? key,
  });

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Démineur',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 80),
            Text(
              'Choisissez une difficulté',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 50),
            OutlinedButton.icon(
              onPressed: () {
                startGame(8, 10);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Facile', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                startGame(12, 20);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Moyen', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                startGame(16, 40);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Difficile', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
