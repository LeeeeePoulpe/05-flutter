import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: Screen1(),
  ));
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});
  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  String answerFromScreen2 = 'undefined';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Screen 1'),
        ),
        body: Center(
            child: Column(children: [
          ElevatedButton(
            child: const Text('Open Screen 2'),
            onPressed: () async {
              final String? result = await Navigator.of(context).push(
                MaterialPageRoute<String>(
                    builder: (context) => const Screen2("Gift from Screen 1")),
              );
              setState(() {
                answerFromScreen2 = result!;
              });
            },
          ),
          Text('Réponse de Screen2 : $answerFromScreen2')
        ])));
  }
}

class Screen2 extends StatelessWidget {
  final String dataFromScreen1;
  const Screen2(this.dataFromScreen1, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: Center(
          child: Column(children: [
        Text(dataFromScreen1),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop("Thanks for your gift !");
          },
          child: const Text('Back to Screen 1'),
        )
      ])),
    );
  }
}
