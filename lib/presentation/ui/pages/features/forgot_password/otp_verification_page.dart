import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
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
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        //
      },
      builder: (context, state) {
        return Scaffold(
          appBar: null,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Logo
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

                  // Text(
                  //   state.email,
                  //   style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  //         color: primaryBlueColor,
                  //       ),
                  //   textAlign: TextAlign.center,
                  // ),

                  SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                  Pinput(
                    length: 6,
                    // You can pass your own SmsRetriever implementation based on any package
                    // in this example we are using the SmartAuth
                    separatorBuilder: (index) =>
                        SizedBox(width: SizeConfig.calHeightMultiplier(10)),
                    validator: (value) {
                      return value == '2222222' ? null : 'Pin is incorrect';
                    },
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
                        border:
                            Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
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
                  TextButton(
                    onPressed: () {
                      // Navigate to the Sign Up page
                      Navigator.of(context).pushNamed(routeRegister);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Do not sent OTP? ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                        children: [
                          TextSpan(
                            text: "Send OTP",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Register button
                  ElevatedButton(
                    onPressed: () {
                      // Action saat tombol ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue[900],
                    ),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                  const Text(
                    '© 2024 SCIN. All rights reserved. Unauthorized copying or distribution is prohibited.',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}