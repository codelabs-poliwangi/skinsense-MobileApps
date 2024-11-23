import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/bloc/auth_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';

class SplashPageScope extends StatelessWidget {
  const SplashPageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di<AuthBloc>()),
        ),
      ],
      child: const SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushReplacementNamed(routeHome);
          });
        } else if (state is AuthUnauthenticated) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushReplacementNamed(routeOnboard);
          });
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: SizeConfig.calMultiplierImage(156),
            height: SizeConfig.calHeightMultiplier(191),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(logoSplashScreen),
              ),
            ),
          ),
        ),
      ),
    );
  }
}