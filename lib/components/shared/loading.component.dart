import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/utils/app_images.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen(this.album, {super.key});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: HexColor(album.color),
        image: const DecorationImage(
          image: AssetImage(AppImages.background),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(album.image, scale: 0.6),
          Text('Carregando...',
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 24.0,
                  color: AppColors.bgColor,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
    );
  }
}
