import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/register/bloc/register_bloc.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';
import 'package:skinisense/presentation/ui/widget/custom_input.dart';
import 'package:skinisense/presentation/ui/widget/custom_logo_button.dart';

class RegisterPasswordPage extends StatefulWidget {
  const RegisterPasswordPage({super.key});

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  bool _rememberMe = false;

  void _toggleRememberMe(bool? value) {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

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
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        print("password:  ${_passwordController.text}");
        print("status:  ${state.status}");
        print("state :  $state");
        print("is loading :  ${state.isLoading}");
        if (state.isLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(color: primaryBlueColor),
            ),
          );
        } else {
          Navigator.of(context).pop(); // Close loading dialog

          if (state.status == RegisterStatus.passwordSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              routeLogin,
              (route) => false,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registrasi Berhasil')),
            );
          } else if (state.status == RegisterStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'An error occurred')),
            );
          }
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
                      'Create Your Account',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: primaryBlueColor, fontWeight: FontWeight.w700),
                    ),
                    Opacity(
                      opacity: .5,
                      child: Text(
                        'Create an Account to Sign In',
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
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          activeColor: primaryBlueColor,
                          onChanged: _toggleRememberMe,
                        ),
                        Text(
                          'I agree with and Accept',
                          style: TextStyle(fontSize: SizeConfig.calMultiplierText(11)),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          child: Text(
                            'Privacy and Policy',
                            style: TextStyle(
                              fontSize: SizeConfig.calMultiplierText(11),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.calHeightMultiplier(12)),

                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterBloc>().add(
                                RegisterPasswordSubmitted(
                                  _passwordController.text,
                                  _confirmPasswordController.text,
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Validation failed')),
                          );
                        }
                      },
                      text: 'Create Account',
                      fontSize: 14,
                      backgroundColor: primaryBlueColor,
                    ),
                    SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          logoTransparent,
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Expanded(child: Divider(color: primaryBlueColor)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Or Login With',
                                    style: TextStyle(color: primaryBlueColor, fontSize: 12),
                                  ),
                                ),
                                Expanded(child: Divider(color: primaryBlueColor)),
                              ],
                            ),
                            SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLogoButton(icon: imgLogoGoogle, onPressed: () {}),
                                const SizedBox(width: 16),
                                CustomLogoButton(icon: imgLogoFacebook, onPressed: () {}),
                                const SizedBox(width: 16),
                                CustomLogoButton(icon: imgLogoTwitter, onPressed: () {}),
                              ],
                            ),
                            SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Have an account?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  child: Text(
                                    "Login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.blue[900], fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () => Navigator.of(context).pushNamed(routeLogin),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
