import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/bloc/question_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/repository/question_repository.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';
import 'package:skinisense/presentation/ui/widget/warningDialog.dart';

class QuestionsPageScope extends StatelessWidget {
  const QuestionsPageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionBloc(di<QuestionRepository>()),
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
  int selectedAnswerIndex = -1; // Index pilihan yang dipilih

  @override
  void initState() {
    super.initState();
    // Fetch questions when the page is initialized
    context.read<QuestionBloc>().add(FetchQuestion());
  }

  void nextQuestion() {
    if (selectedAnswerIndex != -1) {
      print(
          "Jawaban yang dipilih: ${context.read<QuestionBloc>().listQuestion[context.read<QuestionBloc>().currentIndex].option[selectedAnswerIndex]}");
      setState(() {
        selectedAnswerIndex = -1; // Reset pilihan setelah pindah pertanyaan
      });
      context.read<QuestionBloc>().add(QuestionNext());
    } else {
      print("Belum ada pilihan yang dipilih.");
    }
  }

  void previousQuestion() {
    context
        .read<QuestionBloc>()
        .add(QuestionPrevious()); // Dispatch previous question event

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Question ${context.watch<QuestionBloc>().currentIndex + 1}/5",
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
          return warningDialog(context);
        },
        child: Stack(
          children: [
            footerPage(), // Footer berada di paling bawah dan di belakang
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: BlocBuilder<QuestionBloc, QuestionState>(
                    builder: (context, state) {
                  if (state is QuestionLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is QuestionOnLoaded) {
                    final question = state.listQuestions;
                    var currentIndex =
                        context.read<QuestionBloc>().currentIndex;
                    List listOption = question[currentIndex].option;
                    return Column(
                      children: [
                        SizedBox(height: 24),
                        Text(
                          question[currentIndex].question,
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
                            itemCount: question.length,
                            itemBuilder: (context, index) {
                              bool isSelected = index == selectedAnswerIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAnswerIndex = index;
                                  });
                                  context.read<QuestionBloc>().add(
                                      SelectAnswer(listOption[index].id));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? primaryBlueColor
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      listOption[index].option,
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
                    );
                  } else {
                    return Container();
                  }
                }),
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
            // Conditional rendering for the Previous button
            if (context.watch<QuestionBloc>().currentIndex != 0) ...[
              GestureDetector(
                onTap: previousQuestion,
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
              ),
              SizedBox(width: 16),
            ],
            Expanded(
              child: ButtonPrimary(
                mainButtonMessage: context.watch<QuestionBloc>().currentIndex ==
                        context.watch<QuestionBloc>().listQuestion.length - 1
                    ? 'Finish'
                    : 'Next',
                mainButton: () {
                  final questionBloc = context.read<QuestionBloc>();
                  final isLastQuestion = questionBloc.currentIndex ==
                      questionBloc.listQuestion.length - 1;

                  if (isLastQuestion) {
                    questionBloc.add(QuestionSubmited());
                  } else {
                    nextQuestion(); // Panggil fungsi nextQuestion saat tombol ditekan
                  }
                },
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
