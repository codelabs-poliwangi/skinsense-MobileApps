import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/presentation/ui/pages/features/login/login_page.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/questions_page.dart';
import 'package:skinisense/presentation/ui/pages/features/register/register_contact_page.dart';
import 'package:skinisense/presentation/ui/pages/features/register/register_page.dart';
import 'package:skinisense/presentation/ui/pages/features/register/register_password_page.dart';
import 'package:skinisense/presentation/ui/pages/features/forgot_password/forgot_password_page.dart';
import 'package:skinisense/presentation/ui/pages/features/forgot_password/otp_verification_page.dart';
import 'package:skinisense/presentation/ui/pages/features/home/home_wrapper.dart';
import 'package:skinisense/presentation/ui/pages/features/product/product_katalog_page.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/questions_intro.dart';
import 'package:skinisense/presentation/ui/pages/features/result/package/package_from_loading_to_scan_result.dart';
import 'package:skinisense/presentation/ui/pages/features/result/package/package_from_resul_scan_to_result_recom.dart';
import 'package:skinisense/presentation/ui/pages/features/result/result_recom_page.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/preview_page_front.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/preview_page_left.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/preview_page_right.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/scan_choice.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/scan_gallery.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/scan_page_front.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/scan_page_left.dart';
import 'package:skinisense/presentation/ui/pages/features/scan/scan_page_right.dart';
import 'package:skinisense/presentation/ui/pages/features/result/result_scan_page.dart';
import 'package:skinisense/presentation/ui/pages/features/splash_onboard/splash_page.dart';
// import 'package:skinisense/presentation/ui/pages/features/auth/login_screen.dart';
import 'package:skinisense/presentation/ui/pages/not_found_page.dart';
import 'package:skinisense/presentation/ui/pages/features/splash_onboard/onboard_page.dart';

import '../../presentation/ui/pages/features/questions/model/result_question_list.dart';
import '../../presentation/ui/pages/features/result/model/scan_successfull_response_model.dart';
import '../../presentation/ui/pages/features/result/result_loading.dart';
// import 'package:skinisense/presentation/ui/pages/features/auth/register_screen.dart';
// import 'package:skinisense/presentation/ui/splash_screen.dart';

class Routes {
  static Route onRoute(RouteSettings settings) {
    // final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case routeInitial:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const SplashPage(),
          settings: settings,
        );
      case routeHome:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const HomeWrapper(),
          // child: ScanPage(),
          settings: settings,
        );
      case routeOnboard:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const OnboardPage(),
          settings: settings,
        );
      case routeScanChoice:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const ScanChoiceScope(),
          settings: settings,
        );
      case routeScanGallery:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const ScanGalleryScope(),
          settings: settings,
        );
      case routeScanFront:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const ScanPageFront(),
          settings: settings,
        );
      case routeScanLeft:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const ScanPageLeft(),
          settings: settings,
        );
      case routeScanRight:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const ScanPageRight(),
          settings: settings,
        );
      case routeScanFrontPreview:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const PreviewPageFront(),
          settings: settings,
        );
      case routeScanLeftPreview:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const PreviewPageLeft(),
          settings: settings,
        );
      case routeScanRightPreview:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const PreviewPageRight(),
          settings: settings,
        );
      case routeLoadingScan:
        final args = settings.arguments as List<ResultQuestionList>;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: ResultLoading(question: args,),
          settings: settings,
        );
      case routeResultScan:
        final args = settings.arguments as PackageFromLoadingToScanResult;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: ResultScanPage(result: args,),
          settings: settings,
        );
      case routeResultRecom:
      final args = settings.arguments as PackageFromResulScanToResultRecom;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: ResultRecomScope(package: args,),
          settings: settings,
        );
      case routeRegister:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const RegisterScope(),
          settings: settings,
        );
      case routeRegisterContact:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: RegisterContactPage(),
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
          child: ForgotPasswordScope(),
          settings: settings,
        );
      case routeOtpVerification:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const OtpVerificationPage(),
          settings: settings,
        );
      case routeQuestionIntro:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: QuestionsIntro(),
          settings: settings,
        );

      case routeQuestions:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: QuestionsPageScope(),
          settings: settings,
        );
      case routeLogin:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const LoginScope(),
          settings: settings,
        );
      case routeProductKatalog:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: ProductKatalogScope(),
          settings: settings,
        );
      case routeProductDetail:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const NotFoundPage(),
          settings: settings,
        );
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: const NotFoundPage(),
          settings: settings,
        );
    }
  }
}
