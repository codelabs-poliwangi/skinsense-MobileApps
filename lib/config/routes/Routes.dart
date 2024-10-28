
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/presentation/ui/pages/features/home/home_screen.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/login_page.dart';
import 'package:skinisense/presentation/ui/pages/not_found_screen.dart';
import 'package:skinisense/presentation/ui/pages/features/splash_onboard/onboard_screen.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/register_page.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/register_password_page.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/forgot_password_screen.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/otp_verification_screen.dart';
import 'package:skinisense/presentation/ui/pages/features/splash_onboard/splash_screen.dart';
// import 'package:skinisense/presentation/ui/splash_screen.dart';

class Routes {
  static Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeInitial:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: SplashScreen(),
          settings: settings,
        );
      case routeOnboard:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: OnboardScreen(),
          settings: settings,
        );
      case routeLogin:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: Loginpage(),
          settings: settings,
        );
      case routeRegister:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: RegisterPage(),
          settings: settings,
        );
      case routerRegisterPassword:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: RegisterPasswordPage(),
          settings: settings,
        );
      case routeForgotPassword:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: ForgotPasswordScreen(),
          settings: settings,
        );
      case routeOtpVerification:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: OtpVerificationScreen(),
          settings: settings,
        );
      case routeHome:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: HomeScreen(),
          settings: settings,
        );
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: NotFoundScreen(),
          settings: settings,
        );
    }
  }
}
