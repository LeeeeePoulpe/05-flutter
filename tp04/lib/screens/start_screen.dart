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

  void _startGame(int taille, int nbMines) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GameScreen(
            tailleFromStartScreen: taille,
            nbMinesFromStartScreen: nbMines,
            // playerName: _nameController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade50;
    final cardColor = Colors.white;
    final primaryColor = Color(0xFF6E56CF); // Violet Shadcn
    final textColor = Color(0xFF1A1523); // Presque noir
    final borderColor = Colors.grey.shade200;
    final secondaryTextColor = Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête
                    Center(
                      child: Text(
                        'Démineur',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Section nom du joueur
                    Text(
                      'Nom du joueur',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Entrez votre nom",
                          hintStyle: TextStyle(color: secondaryTextColor),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer un nom de joueur";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Section difficulté
                    Text(
                      'Niveau de difficulté',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Boutons de difficulté
                    _buildShadcnButton(
                      label: 'Facile',
                      description: '8×8 grille, 10 mines',
                      onPressed: () => _startGame(8, 10),
                      primaryColor: primaryColor,
                      textColor: textColor,
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 12),
                    _buildShadcnButton(
                      label: 'Moyen',
                      description: '12×12 grille, 20 mines',
                      onPressed: () => _startGame(12, 20),
                      primaryColor: primaryColor,
                      textColor: textColor,
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 12),
                    _buildShadcnButton(
                      label: 'Difficile',
                      description: '16×16 grille, 40 mines',
                      onPressed: () => _startGame(16, 40),
                      primaryColor: primaryColor,
                      textColor: textColor,
                      borderColor: borderColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShadcnButton({
    required String label,
    required String description,
    required VoidCallback onPressed,
    required Color primaryColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: primaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
