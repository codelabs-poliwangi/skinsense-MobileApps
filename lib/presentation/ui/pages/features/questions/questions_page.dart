import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Seberapa baik Anda mendeskripsikan jenis kulit Anda? (normal, kering, berminyak, kombinasi, sensitif)",
      "answer": [
        "Sangat Tidak Jelas",
        "Tidak Jelas",
        "Cukup Jelas",
        "Jelas",
        "Sangat Jelas"
      ]
    },
    {
      "question":
          "Seberapa baik Anda mendeskripsikan jenis kulit Anda? (normal, kering, berminyak, kombinasi, sensitif)",
      "answer": [
        "Sangat Tidak Jelas",
        "Tidak Jelas",
        "Cukup Jelas",
        "Jelas",
        "Sangat Jelas"
      ]
    },
    {
      "question":
          "Seberapa baik Anda mendeskripsikan jenis kulit Anda? (normal, kering, berminyak, kombinasi, sensitif)",
      "answer": [
        "Sangat Tidak Jelas",
        "Tidak Jelas",
        "Cukup Jelas",
        "Jelas",
        "Sangat Jelas"
      ]
    },
    {
      "question":
          "Seberapa baik Anda mendeskripsikan jenis kulit Anda? (normal, kering, berminyak, kombinasi, sensitif)",
      "answer": [
        "Sangat Tidak Jelas",
        "Tidak Jelas",
        "Cukup Jelas",
        "Jelas",
        "Sangat Jelas"
      ]
    },
    {
      "question":
          "Seberapa baik Anda mendeskripsikan jenis kulit Anda? (normal, kering, berminyak, kombinasi, sensitif)",
      "answer": [
        "Sangat Tidak Jelas",
        "Tidak Jelas",
        "Cukup Jelas",
        "Jelas",
        "Sangat Jelas"
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question 1/5"),
      ),
      body: PopScope(

        child: SafeArea(
          child: Column(
            children: [],
          ),  
        ),
      ),
    );
  }
}
