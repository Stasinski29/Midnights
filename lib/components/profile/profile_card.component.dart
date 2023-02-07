import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/utils/app_colors.dart';

class ProfileCardComponent extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProfileCardComponent(this.image, this.text);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
            colors: <Color>[
              AppColors.secondaryColor,
              AppColors.mainColor,
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(child: Opacity(opacity: 0.8, child: Image.asset(image, height: 70))),
            Center(
              child: Text(
                text,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    color: AppColors.bgColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
