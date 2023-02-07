import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/utils/app_images.dart';

class GameAlbumAppBar extends StatelessWidget {
  const GameAlbumAppBar(this.album, this.counter, {super.key});

  final Album album;
  final String counter;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                FontAwesomeIcons.xmark,
                color: Colors.white,
                size: 28.0,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Image.asset(album.image, height: 60.0),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              counter,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
