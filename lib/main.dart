import 'package:flutter/material.dart';
import 'Questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'A Quizzler App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Icon> iconList = [];
  List<Questions> qList = [
    Questions(question: 'The Great Wall of China is visible from the Moon.', ans: false),
    Questions(question: 'Lightning never strikes the same place twice.', ans: false),
    Questions(question: 'Humans share 50% of their DNA with bananas.', ans: true),
    Questions(question: 'The speed of light is approximately 300,000 kilometers per second.', ans: true),
    Questions(question: 'Bats are blind.', ans: false),
    Questions(question: 'Water boils at 100°C at standard atmospheric pressure.', ans: true),
    Questions(question: 'Venus is the closest planet to the Sun.', ans: false),
    Questions(question: 'Australia is both a country and a continent.', ans: true),
    Questions(question: 'The Amazon River is the longest river in the world.', ans: false),
    Questions(question: 'Africa is the largest continent by area.', ans: false),
    Questions(question: 'The Sahara Desert is the largest desert in the world.', ans: true),
    Questions(question: 'A baker\'s dozen is 12.', ans: false),
    Questions(question: 'The currency of Japan is the Yen.', ans: true),
    Questions(question: 'The Eiffel Tower is located in Berlin.', ans: false),
    Questions(question: 'Thomas Edison invented the lightbulb.', ans: true),
   ];


  int questionNo = 0;
  int quizScore = 0;

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (qList[questionNo].a == userAnswer) {
        quizScore++;
        iconList.add(const Icon(Icons.check, color: Colors.green));
      } else {
        iconList.add(const Icon(Icons.close, color: Colors.red));
      }

      if (questionNo < qList.length - 1) {
        questionNo++;
      } else {
        _showQuizEndDialog();
      }
    });
  }

  void _showQuizEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quiz Completed"),
          content: Text("You have scored $quizScore out of 15 . Restart?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartQuiz();
              },
              child: const Text("Restart"),
            ),
          ],
        );
      },
    );
  }

  void _restartQuiz() {
    setState(() {
      questionNo = 0;
      iconList.clear();
      quizScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                  child: Container(
                    color: Colors.white12,
                    width: double.maxFinite,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                          'Quizzler',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20, color: Colors.white,fontStyle: FontStyle.italic),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Score: $quizScore',
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
              ),),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      qList[questionNo].q,
                      textAlign: TextAlign.center,
                      style:  const TextStyle(color: Colors.white, fontSize: 25 ,fontFamily: 'Poppins',),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    onPressed: () => checkAnswer(true),
                    child: Container(
                      color: Colors.green.shade800,
                      width: double.maxFinite,
                      height: 80,
                      child: const Center(
                        child: Text(
                        'True',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    onPressed: () => checkAnswer(false),
                    child: Container(
                      color: Colors.red.shade800,
                      width: double.maxFinite,
                      height: 80,
                      child: const Center(
                        child: Text(
                          'False',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: iconList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
