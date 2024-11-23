import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/bloc/auth_bloc.dart';

import '../../../../../domain/utils/logger.dart';

class SplashPageScope extends StatelessWidget {
  const SplashPageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthBloc>(),
      child: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCheckRequested());
    logger.d('auth bloc ${di<AuthBloc>().state}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: di<AuthBloc>(),
      listener: (context, state) {
        if(state is AuthInitial){
          context.read<AuthBloc>().add(AuthCheckRequested());
        }
        logger.d('state is ${state}');
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
