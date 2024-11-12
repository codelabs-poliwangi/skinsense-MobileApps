import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/login/bloc/login_bloc.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';
import 'package:skinisense/presentation/ui/widget/custom_input.dart';
import 'package:skinisense/presentation/ui/widget/custom_logo_button.dart';
// import 'signup.dart'; // Import halaman signup.dart
class LoginScope extends StatelessWidget {
  const LoginScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: LoginPage(), // Replace with the actual widget to be wrapped
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _rememberMe = false;

  // Function State Management
  void _isObsecure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _isRemember(value) {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: primaryBlueColor,
              ),
            ),
          );
        } else if (state is LoginSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
    
          // Navigate to home
          Navigator.pushNamedAndRemoveUntil(
            context,
            routeHome,
            (route) => false,
          );
        } else if (state is LoginFailure) {
          Navigator.of(context).pop(); // Close loading dialog
          showCustomModalBottomSheet(
              context, imageTryAgain, primaryBlueColor);
        }
      },
      child: Scaffold(
        appBar: null,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
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
    
                  // Login to Your Account
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            color: primaryBlueColor,
                            fontWeight: FontWeight.w700),
                  ),
    
                  // Login to your
                  Opacity(
                    opacity: .5,
                    child: Text(
                      'Log in to existing SCIN account',
                      style:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: primaryBlueColor,
                              ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),
    
                  // Username or email field
                  CustomInput(
                    controller: _emailController,
                    hintText: 'Username or Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an username or email!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(16)),
    
                  // Password field
                  CustomInput(
                    controller: _passwordController,
                    hintText: 'Password',
                    isPasswordField: true,
                    obscureText: _obscureText,
                    onToggleVisibility: _isObsecure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password!';
                      }
                      return null;
                    },
                  ),
    
                  // Remember Me and Forgot Password
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            activeColor: primaryBlueColor,
                            onChanged: _isRemember,
                          ),
                          Text(
                            'Remember Me',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(routeForgotPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: primaryBlueColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
    
                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),
                  CustomButton(
                      onPressed: () {
                        // Jika form sudah tervalidasi
                        if (_formKey.currentState!.validate()) {

                          context.read<LoginBloc>().add(
                            LoginSubmitted(
                              email: _emailController.text,
                              password: _passwordController.text
                            )
                          );
                        }
                      },
                      text: 'Login',
                      backgroundColor: primaryBlueColor),
                  SizedBox(height: SizeConfig.calHeightMultiplier(24)),
    
                  //=========================================================================
    
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
                                    horizontal: 8.0), // Spacing around text
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
                              height: SizeConfig.calHeightMultiplier(16)),
    
                          // Social Media Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomLogoButton(
                                icon: imgLogoGoogle,
                                onPressed: () {},
                              ),
                              const SizedBox(width: 16),
                              CustomLogoButton(
                                icon: imgLogoFacebook,
                                onPressed: () {},
                              ),
                              const SizedBox(width: 16),
                              CustomLogoButton(
                                icon: imgLogoTwitter,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                              height: SizeConfig.calHeightMultiplier(24)),
    
                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Doesn't have an account?",
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
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                onTap: () => Navigator.of(context)
                                    .pushNamed(routeRegister),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
    
                  const Text(
                    '© 2024 SCIN. All rights reserved. Unauthorized copying or distribution is prohibited.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomModalBottomSheet(
    BuildContext context, String imageTryAgain, Color primaryBlueColor) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Image.asset(
              imageTryAgain,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Text(
              'Ooops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryBlueColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Seems like your username and password do not match. Please check once again.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'Try Again',
                backgroundColor: primaryBlueColor)
          ],
        ),
      );
    },
  );
}
