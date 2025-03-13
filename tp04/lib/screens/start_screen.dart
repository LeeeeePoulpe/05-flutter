import 'package:flutter/material.dart';
import 'package:tp02/screens/game_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Choisi un nom de joueur !",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vous devez avoir un nom de joueur";
                  }
                  return null;
                },
              ),
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          tailleFromStartScreen: 8,
                          nbMinesFromStartScreen: 10,
                        ),
                      ),
                    );
                  }
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          tailleFromStartScreen: 12,
                          nbMinesFromStartScreen: 20,
                        ),
                      ),
                    );
                  }
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          tailleFromStartScreen: 16,
                          nbMinesFromStartScreen: 40,
                        ),
                      ),
                    );
                  }
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
      ),
    );
  }
}
