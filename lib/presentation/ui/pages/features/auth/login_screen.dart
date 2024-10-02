import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import paket font awesome
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
// import 'signup.dart'; // Import halaman signup.dart

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              logoSplashScreen, // Ganti dengan path logo kamu
              height: 100,
            ),
            SizedBox(height: SizeConfig.calHeightMultiplier(24)),

            // Login to Your Account
            Text(
              'Login to Your Account',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.calHeightMultiplier(24)),

            // Username or email field
            TextField(
              decoration: InputDecoration(
                labelText: 'Username or email',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.calHeightMultiplier(16)),

            // Password field
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.visibility),
              ),
              obscureText: true,
            ),
            SizedBox(height: SizeConfig.calHeightMultiplier(24)),

            // Login button
            ElevatedButton(
              onPressed: () {
                // Action saat tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.blue[900],
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.calHeightMultiplier(24)),

            // Or Login With
            Text('Or Login With'),
            SizedBox(height: SizeConfig.calHeightMultiplier(16)),

            // Social Media Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaButton(
                  icon: FontAwesomeIcons.google,
                  onPressed: () {},
                ),
                SizedBox(width: 16),
                SocialMediaButton(
                  icon: FontAwesomeIcons.facebook,
                  onPressed: () {},
                ),
                SizedBox(width: 16),
                SocialMediaButton(
                  icon: FontAwesomeIcons.twitter,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: SizeConfig.calHeightMultiplier(24)),

            // Sign Up Link
            TextButton(
              onPressed: () {
                // Navigate to the Sign Up page
                Navigator.of(context).pushNamed(routeRegister);
              },
              child: Text.rich(
                TextSpan(
                  text: "Doesn't have an account? ",
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SocialMediaButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.blue[900]),
      iconSize: 36,
    );
  }
}
