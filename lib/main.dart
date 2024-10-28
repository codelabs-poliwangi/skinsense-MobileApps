import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import untuk SystemChrome
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/routes/Routes.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding diinisialisasi
  await SystemChrome.setPreferredOrientations([ // Set hanya untuk potret
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.init(context);
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
  }
}
