import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';
import 'package:skinisense/presentation/ui/widget/custom_input.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleObscureTextConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.resetSuccess) {
          Navigator.pushNamed(context, routeLogin);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      logoSplashScreen,
                      width: SizeConfig.calWidthMultiplier(120),
                    ),
                    SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                    Text(
                      'Reset Password',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: primaryBlueColor, fontWeight: FontWeight.w700),
                    ),
                    Opacity(
                      opacity: .5,
                      child: Text(
                        'Reset Your Password Account',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: primaryBlueColor,
                            ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                    CustomInput(
                      controller: _passwordController,
                      isPasswordField: true,
                      obscureText: _obscureText,
                      onToggleVisibility: _toggleObscureText,
                      hintText: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password must be filled';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                    CustomInput(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      isPasswordField: true,
                      obscureText: _obscureTextConfirm,
                      onToggleVisibility: _toggleObscureTextConfirm,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password must be filled';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords entered do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: SizeConfig.calHeightMultiplier(12)),

                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ForgotPasswordBloc>().add(
                                ForgotPasswordResetSubmitted(
                                  token: state.otp!,
                                  password: _passwordController.text,
                                  confirmPassword: _confirmPasswordController.text
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Validation failed')),
                          );
                        }
                      },
                      text: 'Submit',
                      fontSize: 14,
                      backgroundColor: primaryBlueColor,
                    ),
                    SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                    Image.asset(
                      logoTransparent,
                      fit: BoxFit.cover,
                      width: 200,
                    ),

                    const Text(
                      '© 2024 SCIN. All rights reserved. Unauthorized copying or distribution is prohibited.',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
