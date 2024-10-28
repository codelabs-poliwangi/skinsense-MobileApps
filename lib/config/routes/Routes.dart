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
import 'package:skinisense/presentation/ui/pages/features/home/home_wrapper.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/preview_page_front.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/preview_page_left.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/preview_page_right.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/scan_page_front.dart';
// import 'package:skinisense/presentation/ui/pages/features/auth/login_screen.dart';
import 'package:skinisense/presentation/ui/pages/not_found_page.dart';
import 'package:skinisense/presentation/ui/pages/features/splash_onboard/onboard_page.dart';
// import 'package:skinisense/presentation/ui/pages/features/auth/register_screen.dart';
import 'package:skinisense/presentation/ui/pages/features/splash_onboard/splash_page.dart';
// import 'package:skinisense/presentation/ui/splash_screen.dart';

class Routes {
  static Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeInitial:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: HomeWrapper(),
          // child: ScanPage(),
          settings: settings,
        );
      case routeHome:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: HomeWrapper(),
          // child: ScanPage(),
          settings: settings,
        );
      case routeOnboard:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: OnboardPage(),
          settings: settings,
        );
      case routeScanFront:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: ScanPageFront(),
          settings: settings,
        );
       case routeScanFrontPreview:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: PreviewPageFront(),
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
          child: PreviewPageFront(),
          settings: settings,
        );
      case routeScanLeftPreview:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: PreviewPageLeft(),
          settings: settings,
        );
      case routeScanRightPreview:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: PreviewPageRight(),
          settings: settings,
        );
     
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: NotFoundPage(),
          settings: settings,
        );
    }
  }
}
