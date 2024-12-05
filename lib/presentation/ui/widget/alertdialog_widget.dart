import 'package:flutter/material.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback mainButton;
  final String mainButtonMessage;
  final String? cancelButtonMessage;
  final VoidCallback? cancelButton;

  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.mainButton,
    required this.mainButtonMessage,
    this.cancelButtonMessage,
    this.cancelButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(32),
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
                fontSize: SizeConfig.calHeightMultiplier(16),
              ),
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
                fontSize: SizeConfig.calHeightMultiplier(12),
              ),
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
            // Tampilkan cancel button hanya jika keduanya tidak null
            if (cancelButtonMessage != null && cancelButton != null)
              GestureDetector(
                onTap: cancelButton,
                child: Text(
                  cancelButtonMessage!,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}