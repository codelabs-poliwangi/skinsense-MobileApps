import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:skinisense/presentation/ui/pages/features/forgot_password/reset_password_page.dart';

import 'package:skinisense/presentation/ui/widget/custom_button.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController pinController = TextEditingController();
  late Timer _timer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void resetTimer() {
  _timer.cancel(); // Hentikan timer lama
  setState(() {
    _remainingSeconds = 60; // Reset ke 60 detik atau sesuai kebutuhan
  });
  startTimer(); // Mulai timer baru
}

  String get formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(Object context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if(state is ForgotPasswordOtpSuccess) {
          Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300),
                child: BlocProvider.value(
                  value: BlocProvider.of<ForgotPasswordBloc>(context),
                  child: const ResetPasswordPage(),
                )
              )
            );
        }
      },
      builder: (context, state) {
        String emailText = 'Email not found';

        // Pengambilan state email
        if(state is ForgotPasswordEmailSuccess) {
          emailText = state.email;
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const  EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                children: [
                  Image.asset(
                    imageOTPVerification, // Ganti dengan path logo kamu
                    height: 200,
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                  // Login to Your Account
                  Text(
                    'OTP Verification',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: primaryBlueColor, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(10)),

                  // Login to your
                  Opacity(
                    opacity: .5,
                    child: Text(
                      'We will send you one time password this email address.',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: primaryBlueColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                  Text(
                      emailText,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: primaryBlueColor,
                          ),
                      textAlign: TextAlign.center,
                  ),

                  SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                  Pinput(
                    controller: pinController,
                    length: 6,
                    separatorBuilder: (index) =>
                        SizedBox(width: SizeConfig.calHeightMultiplier(10)),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 2,
                          color: primaryBlueColor,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                  Text(formattedTime, style: const TextStyle(fontSize: 12)),

                  SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not sent OTP?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(width: SizeConfig.calWidthMultiplier(8)),
                      GestureDetector(
                        child: Text(
                          "Send OTP",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: _remainingSeconds > 0 ? Colors.grey.shade300 : primaryBlueColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        onTap: () {
                          if(_remainingSeconds > 0) {
                            return;
                          }
                          else {
                            context.read<ForgotPasswordBloc>().add(ForgotPasswordEmailSubmitted(emailText));
                            resetTimer();
                          }
                        },
                      )
                    ],
                  ),

                  SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                  // Register button
                  CustomButton(
                    onPressed: () {
                      // print(context.read<ForgotPasswordBloc>().isClosed);
                      context.read<ForgotPasswordBloc>().add(ForgotPasswordOtpSubmitted(otp: pinController.text));
                    },
                    text: 'Submit',
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                  const Text(
                    '© 2024 SCIN. All rights reserved. Unauthorized copying or distribution is prohibited.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ) 
          ),
        );
      }
    );
  }
  
}