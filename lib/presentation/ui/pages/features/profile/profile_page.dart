import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/bloc/auth_bloc.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';

class ProfilePageScope extends StatelessWidget {
  const ProfilePageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthBloc>(),
      child: ProfilePage(),
    );;
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthUnauthenticated) {
              Navigator.of(context).pushReplacementNamed(routeLogin);
            }
          },
          child: Center(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Profile'),
                ButtonPrimary(mainButtonMessage: 'Logout', mainButton: () {
                  // TODO: implement logout
                  logger.d('auth bloc execute logout');
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                }),
              ],
            ),
          ),
        )
      ),
    );
  }
}
