import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/register/bloc/register_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/register/register_password_page.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';
import 'package:skinisense/presentation/ui/widget/custom_input.dart';
import 'package:skinisense/presentation/ui/widget/custom_logo_button.dart';
// import 'signup.dart'; // Import halaman signup.dart

class RegisterContactPage extends StatefulWidget {
  const RegisterContactPage({super.key});

  @override
  State<RegisterContactPage> createState() => _RegisterContactPageState();
}

class _RegisterContactPageState extends State<RegisterContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Pembuatan build Widget");
    print(context);
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
          if (state.isLoading == true) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: primaryBlueColor,
              ),
            ),
          );
        } else {
          Navigator.of(context).pop(); 
          if (state.status == RegisterStatus.contactSuccess) {
            Navigator.of(context).pushReplacement(
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300),
                child: BlocProvider.value(
                  value: BlocProvider.of<RegisterBloc>(context), // Mengirim RegisterBloc yang ada
                  child: RegisterPasswordPage(),
                )
              )
            );
          }
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
      print("Pembuatan build bloc");
      print("State : $state");
      return Scaffold(
          appBar: null,
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo
                          Image.asset(
                            logoSplashScreen, // Ganti dengan path logo kamu
                            width: SizeConfig.calWidthMultiplier(120),
                          ),
                          SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                          // Register to Your Account
                          Text(
                            'Create Your Account',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: primaryBlueColor,
                                    fontWeight: FontWeight.w700),
                          ),

                          // Register to your
                          Opacity(
                            opacity: .5,
                            child: Text(
                              'Create an Account to Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: primaryBlueColor,
                                  ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                          // Username or email field
                          CustomInput(
                            key: const Key('keyEmailInput'),
                            controller: _emailController,

                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email must be filled';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(_emailController.text)) {
                                return 'Please enter valid email!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: SizeConfig.calHeightMultiplier(16)),

                          CustomInput(
                            key: const Key('keyPhoneInput'),
                            controller: _phoneController,
                            hintText: 'Phone Number',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number must be filled';
                              }
                              if (!RegExp(r'^(08)[0-9]{8,11}$')
                                  .hasMatch(_phoneController.text)) {
                                return 'Please enter valid phone number!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                          // Register button
                          CustomButton(
                              onPressed: () {
                                print(state.name);
                                print(state.email);
                                print(state.phone);
                                if (_formKey.currentState!.validate()) {
                                  context.read<RegisterBloc>().add(
                                      RegisterContactSubmitted(
                                          _emailController.text,
                                          _phoneController.text));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Gagal')),
                                  );
                                }
                              },
                              text: 'Sign Up',
                              backgroundColor: primaryBlueColor),
                          SizedBox(height: SizeConfig.calHeightMultiplier(24)),

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                logoTransparent,
                                fit: BoxFit.cover,
                                width: 200,
                              ),
                              // Or Login With
                              Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color:
                                              primaryBlueColor, // Color of the line
                                          height: 1, // Height of the divider
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                8.0), // Spacing around text
                                        child: Text(
                                          'Or Login With',
                                          style: TextStyle(
                                            color:
                                                primaryBlueColor, // Color of the text
                                            fontSize: 12, // Font size
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color:
                                              primaryBlueColor, // Color of the line
                                          height: 1, // Height of the divider
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          SizeConfig.calHeightMultiplier(16)),

                                  // Social Media Buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomLogoButton(
                                          icon: imgLogoGoogle,
                                          onPressed: () {}),
                                      const SizedBox(width: 16),
                                      CustomLogoButton(
                                          icon: imgLogoFacebook,
                                          onPressed: () {}),
                                      const SizedBox(width: 16),
                                      CustomLogoButton(
                                          icon: imgLogoTwitter,
                                          onPressed: () {}),
                                      const SizedBox(width: 16),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          SizeConfig.calHeightMultiplier(24)),

                                  // Sign Up Link
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Have an account?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        child: Text(
                                          "Login",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(routeLogin),
                                      )
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
                          )
                        ],
                      )))));
    });
  }
}
