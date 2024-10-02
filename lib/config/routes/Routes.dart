
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/presentation/ui/pages/home_screen.dart';
import 'package:skinisense/presentation/ui/pages/login_screen.dart';
import 'package:skinisense/presentation/ui/pages/not_found_screen.dart';
import 'package:skinisense/presentation/ui/pages/onboard_screen.dart';
import 'package:skinisense/presentation/ui/pages/register_screen.dart';
import 'package:skinisense/presentation/ui/pages/splash_screen.dart';
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
          child: LoginScreen(),
          settings: settings,
        );
      case routeRegister:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: RegisterScreen(),
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
