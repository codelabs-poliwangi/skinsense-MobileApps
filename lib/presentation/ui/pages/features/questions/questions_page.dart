import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/bloc/question_bloc.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';

class QuestionsPageScope extends StatelessWidget {
  const QuestionsPageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionBloc(),
      child: QuestionsPage(),
    );
  }
}

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
    // Tambahkan pertanyaan lain jika diperlukan
  ];

  int selectedAnswerIndex = -1; // Index pilihan yang dipilih

  void nextQuestion() {
    if (selectedAnswerIndex != -1) {
      print(
          "Jawaban yang dipilih: ${questions[0]["answer"][selectedAnswerIndex]}");
      setState(() {
        selectedAnswerIndex = -1; // Reset pilihan setelah pindah pertanyaan
      });
    } else {
      print("Belum ada pilihan yang dipilih.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Question 1/5",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: secoundaryBlueColor,
          ),
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              scrollable: false,
              contentPadding: EdgeInsets.all(0),
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(32),
                // height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      // width: 200,
                      height: 200,
                      image: AssetImage(
                        imgStop,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Ayo lengkapi semua pertanyaan dulu, baru bisa lanjut ke tahap berikutnya!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConfig.calHeightMultiplier(12)),
                    ),
                    SizedBox(
                      height: SizeConfig.calHeightMultiplier(30),
                    ),
                    ButtonPrimary(
                      mainButtonMessage: "Kembali",
                      mainButton: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.calHeightMultiplier(12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Stack(
          children: [
            footerPage(), // Footer berada di paling bawah dan di belakang
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Text(
                      questions[0]["question"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: questions[0]["answer"].length,
                        itemBuilder: (context, index) {
                          bool isSelected = index == selectedAnswerIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAnswerIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12),
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? primaryBlueColor : Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  questions[0]["answer"][index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: primaryBlueColor),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Center(
                  child: Icon(FluentSystemIcons.ic_fluent_arrow_left_regular),
                ),
              ),
              onTap: () {},
            ),
            SizedBox(width: 24),
            Expanded(
              child: ButtonPrimary(
                mainButtonMessage: 'Next',
                mainButton:
                    nextQuestion, // Panggil fungsi nextQuestion saat tombol ditekan
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align footerPage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(right: 24, left: 24, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              logoSplashScreen,
              height: 190,
              color: Colors.black.withOpacity(0.2),
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              '© 2024 SCIN. All rights reserved. Unauthorized copying or distribution is prohibited.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                color: primaryBlueColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
