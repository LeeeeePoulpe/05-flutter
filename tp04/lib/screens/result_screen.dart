import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final double temps;

  const ResultScreen({
    required this.score,
    required this.temps,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                onPressed: Navigator.of(context).pop,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(Icons.arrow_right_alt),
                label: const Text('Rejouer'),
              )
            ],
          ),
        ));
  }
}
