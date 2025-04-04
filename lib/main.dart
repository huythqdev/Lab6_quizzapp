import 'package:flutter/material.dart';
import 'package:quizzapplab6/question.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int count = 0;
  List<Icon> iconsList = [];

  final List<Question> questionsList = [
    Question('Môn Lập trình đa nền tảng cuối kì thi trắc nghiệm?', false),
    Question('Môn Lập trình đa nền tảng(2) học vào sáng thứ 6?', true),
    Question('ThS Ngô Lê Quân là giảng viên dạy môn Lập trình đa nền tảng', true),
    Question('Mức thuế Mỹ áp dụng lên Việt Nam là 46%', true),
  ];

  void _checkAnswer(bool selectedAnswer) {
    bool isCorrect = selectedAnswer == questionsList[count].correctAnswer;

    setState(() {
      iconsList.add(
        isCorrect
            ? Icon(Icons.check_circle, color: Colors.green, size: 30)
            : Icon(Icons.cancel, color: Colors.red, size: 30),
      );
    });

    if (!isCorrect) {
      HapticFeedback.heavyImpact();
    }

    Future.delayed(Duration(milliseconds: 500), () {
      if (count < questionsList.length - 1) {
        setState(() {
          count++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      questionsList[count].question,
                      key: ValueKey<int>(count),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildAnswerButton("True", Colors.green, true),
                    SizedBox(height: 10),
                    _buildAnswerButton("False", Colors.red, false),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: iconsList,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton(String text, Color color, bool answer) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        elevation: 5,
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _checkAnswer(answer),
    );
  }
}