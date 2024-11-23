import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart'; // Import untuk SystemChrome
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/routes/Routes.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skinisense/dependency_injector.dart';
import 'firebase_options.dart';

// ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  init();
  // Menunggu inisialisasi format tanggal
  await initializeDateFormatting('id_ID', null);

  // Setelah semua selesai, baru jalankan aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
