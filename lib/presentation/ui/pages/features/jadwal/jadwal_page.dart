import 'package:flutter/material.dart';


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
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('Jadwal Screen'),
      )),
    );
  }
}
