import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/bloc/auth_bloc.dart';

class ProfilePageScope extends StatelessWidget {
  const ProfilePageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthBloc>(),
      child: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<String?> _fetchUserName() async {
    return di<SharedPreferencesService>().getString('name') ?? 'Guest';
  }

  Future<String?> _fetchUserEmail() async {
    return di<SharedPreferencesService>().getString('email') ??
        'guest@email.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              Navigator.of(context).pushReplacementNamed(routeLogin);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(imageForgotPassword),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          // FutureBuilder<String?>(
                          // future: _fetchUserName(context),
                          // builder: (context, snapshot) {
                          //   String userName = 'Guest';
                          //   if (snapshot.connectionState == ConnectionState.waiting) {
                          //     userName = 'Loading...';
                          //   } else if (snapshot.hasError) {
                          //     userName = 'Error';
                          //   } else if (snapshot.hasData) {
                          //     userName = snapshot.data!;
                          //   }
                          FutureBuilder(
                            future: _fetchUserName(),
                            builder: (context, snapshot) {
                              String userName = 'Guest';
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                userName = 'Loading...';
                              } else if (snapshot.hasError) {
                                userName = 'Guest';
                              } else if (snapshot.hasData) {
                                userName = snapshot.data!;
                              }
                              return Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              );
                            },
                          ),
                          FutureBuilder(
                            future: _fetchUserEmail(),
                            builder: (context, snapshot) {
                              String userEmail = 'Guest';
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                userEmail = 'Loading...';
                              } else if (snapshot.hasError) {
                                userEmail = 'guest@guest.com';
                              } else if (snapshot.hasData) {
                                userEmail = snapshot.data!;
                              }
                              return Text(
                                userEmail,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Profile Options Container
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildProfileOption(
                          title: 'Personal Info',
                          icon: FluentSystemIcons.ic_fluent_person_filled,
                          iconColor: Colors.blue.shade400,
                          onTap: () {},
                        ),
                        _buildProfileOption(
                          title: 'Privacy & Policy',
                          icon: FluentSystemIcons.ic_fluent_lock_filled,
                          iconColor: Colors.orange.shade400,
                          onTap: () {},
                        ),
                        _buildProfileOption(
                          title: 'Settings',
                          icon: FluentSystemIcons.ic_fluent_settings_regular,
                          iconColor: Colors.amber.shade400,
                          onTap: () {},
                        ),
                        _buildProfileOption(
                          title: 'logout',
                          icon: Icons.exit_to_app_rounded,
                          iconColor: Colors.red.shade400,
                          onTap: () {
                            logger.d('auth bloc execute logout');
                            context.read<AuthBloc>().add(AuthLogoutRequested());
                          },
                        ),
                        // Add more profile options here
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required String title,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            FluentSystemIcons.ic_fluent_chevron_right_filled,
            color: Colors.grey.shade700,
          ),
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.2),
            ),
            padding: EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade300,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
