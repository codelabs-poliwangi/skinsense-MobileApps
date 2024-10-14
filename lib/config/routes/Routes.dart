import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/presentation/ui/pages/features/home/home_wrapper.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/scan_page.dart';
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
      case routeOnboard:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: OnboardPage(),
          settings: settings,
        );
      case routeScan:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: ScanPage(),
          settings: settings,
        );
      // case routeLogin:
      //   return PageTransition(
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 300),
      //     child: Login(),
      //     settings: settings,
      //   );
      // case routeRegister:
      //   return PageTransition(
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 300),
      //     child: RegisterScreen(),
      //     settings: settings,
      //   );
      // case routeHome:
      //   return PageTransition(
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 300),
      //     child: HomeWrapper(),
      //     settings: settings,
      //   );
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
