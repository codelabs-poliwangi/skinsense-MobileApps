import 'package:flutter/material.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/routes/Routes.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: routeInitial,
              onGenerateRoute: Routes.onRoute,
              theme: ThemeData(
                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
