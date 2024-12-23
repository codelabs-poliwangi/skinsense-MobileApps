import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/domain/provider/forgot_password_provider.dart';
import 'package:skinisense/presentation/ui/pages/features/forgot_password/otp_verification_page.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';
import 'package:skinisense/presentation/ui/widget/custom_input.dart';
import 'package:skinisense/dependency_injector.dart';

import 'bloc/forgot_password_bloc.dart';

class ForgotPasswordScope extends StatelessWidget {
  const ForgotPasswordScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
        create: (context) => ForgotPasswordBloc(forgotPasswordProvider: di<ForgotPasswordProvider>()),
        child: ForgotPasswordPage());
  }
}

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordStatus.loading) {
            showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: primaryBlueColor,
              ),
            ),
          );
          }
          if (state.status == ForgotPasswordStatus.emailSuccess) {
            Navigator.of(context).pop(); // Close loading dialog
            Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300),
                child: BlocProvider.value(
                  value: BlocProvider.of<ForgotPasswordBloc>(context),
                  child: const OtpVerificationPage(),
                )
              )
            );
          }
          if (state.status == ForgotPasswordStatus.failure) {
            Navigator.of(context).pop(); // Close loading dialog

            Future.delayed(Durations.short4);

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.redAccent,));
          }
        },
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          backgroundColor: Colors.white,
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: primaryBlueColor),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Logo
                  Image.asset(
                    imageForgotPassword, // Ganti dengan path logo kamu
                    height: 200,
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                  // Label Input
                  Align(
                    alignment: Alignment.centerLeft, // Atur alignment ke kiri
                    child: Text(
                      'Enter Your Email Address',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: primaryBlueColor,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign
                          .left, // Pastikan textAlign diatur ke TextAlign.left
                    ),
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(8)),

                  CustomInput(
                    key: const Key('keyEmailInput'),
                    controller: emailController,
                    hintText: 'example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email must be filled';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(emailController.text)) {
                        return 'Please enter valid email!';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                  // Register button
                  CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgotPasswordBloc>().add(ForgotPasswordEmailSubmitted(emailController.text));
                        }
                      },
                      text: 'Send OTP',
                      backgroundColor: primaryBlueColor),
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
            ),
          )),
        ),
      );
    });
  }
}
