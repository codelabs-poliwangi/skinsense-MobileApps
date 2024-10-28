import 'package:flutter/material.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String cancelButtonMessage;
  final VoidCallback cancelButton;
  final VoidCallback mainButton;
  final String mainButtonMessage;
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.mainButton,
    required this.cancelButtonMessage,
    required this.cancelButton,
    required this.mainButtonMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.white,
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
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.calHeightMultiplier(16)),
            ),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(6),
            ),
            Text(
              textAlign: TextAlign.center,
              message,
              style: TextStyle(
                  color: secoundaryTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.calHeightMultiplier(12)),
            ),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(30),
            ),
            ButtonPrimary(
              mainButtonMessage: mainButtonMessage,
              mainButton: mainButton,
            ),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(12),
            ),
            GestureDetector(
              onTap: cancelButton,
              child: Text(
                cancelButtonMessage,
              ),
            )
          ],
        ),
      ),
    );
  }
}

