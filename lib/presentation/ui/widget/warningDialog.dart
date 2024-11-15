import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';

Future<void> warningDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: false,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(32),
        // height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              // width: 200,
              height: 200,
              image: AssetImage(
                imgStop,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              "Ayo lengkapi semua pertanyaan dulu, baru bisa lanjut ke tahap berikutnya!",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.calHeightMultiplier(12)),
            ),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(30),
            ),
            ButtonPrimary(
              mainButtonMessage: "Kembali",
              mainButton: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(12),
            ),
          ],
        ),
      ),
    ),
  );
}
