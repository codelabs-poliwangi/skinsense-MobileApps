import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/coming_soon.dart';

class JadwalPageScope extends StatelessWidget {
  const JadwalPageScope({super.key});

  @override
  Widget build(BuildContext context) {
    return JadwalPage();
  }
}

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComingSoonPage();
  }
}
