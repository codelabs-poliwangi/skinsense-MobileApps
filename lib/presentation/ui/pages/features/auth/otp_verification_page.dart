import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import paket font awesome
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';

// import 'signup.dart'; // Import halaman signup.dart
class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: SizeConfig.calHeightMultiplier(8)),
        
              Text(
                'your@email.com',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: primaryBlueColor,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.calHeightMultiplier(16)),
        
              // OTP Input Field
              PinCodeTextField(
                appContext: context,
                length: 4, // Jumlah digit OTP
                onChanged: (value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.grey[200],
                  inactiveFillColor: Colors.grey[200],
                  selectedFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
            
              ),
        
              Text(
                '00:30',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: primaryBlueColor,
                    ),
                textAlign: TextAlign.center,
              ),
              
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
  }
}
