import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import paket font awesome
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart'; 
import 'package:skinisense/config/theme/color.dart';

// import 'signup.dart'; // Import halaman signup.dart
class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        
              // Username or email field
              TextField(
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  hintText: 'your-email@mail.com',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.calHeightMultiplier(16)),
        
              // Register button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(routeOtpVerification);
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
                    'Send OTP',
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
  }
}
