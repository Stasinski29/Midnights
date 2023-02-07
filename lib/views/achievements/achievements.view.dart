import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:midnights/components/achievements/achievements_icon.dart';
import 'package:midnights/models/achievements/achievement.model.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/providers/records.provider.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/utils/app_images.dart';
import 'package:provider/provider.dart';

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key});

  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  RecordesRepository? records;

  @override
  void didChangeDependencies() {
    records ??= Provider.of<RecordesRepository>(context);

    super.didChangeDependencies();
  }

  List<AchievementAlbumModel> get achievements => records!.allAchievements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CONQUISTAS'),
        backgroundColor: AppColors.mainColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: achievementsList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> achievementsList() {
    List<Widget> result = <Widget>[];

    for (AchievementAlbumModel model in achievements) {
      Album? album = model.album;
      result.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          decoration: BoxDecoration(
            color: HexColor(album?.color ?? '#9B3179').withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.maxFinite,
                height: 50.0,
                margin: const EdgeInsets.only(top: 15.0),
                child: Image.asset(
                  album != null ? album.image : AppImages.grafiaEras,
                  scale: album != null ? 4.5 : 1.0,
                  color: HexColor(album != null
                      ? (album.useSecondary ? album.secondaryColor : album.color)
                      : '#9B3179'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: model.achievements!
                      .map<Widget>((icon) => AchievementsIcon(icon, album))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return result;
  }

  // Widget achievementsRow(int divisor, Album? album) {
  //   List<UserIcon> albunIcons = icons.sublist(divisor * 3, divisor * 3 + 3);
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
  //     decoration: BoxDecoration(
  //       color: HexColor(album?.color ?? '#9B3179').withOpacity(0.3),
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //           width: double.maxFinite,
  //           height: album != null ? 50.0 : 60.0,
  //           margin: const EdgeInsets.only(top: 15.0),
  //           child: Image.asset(
  //             album != null ? album.image : AppImages.grafiaEras,
  //             scale: album != null ? 4.5 : 1.0,
  //             color: HexColor(album != null
  //                 ? (album.useSecondary ? album.secondaryColor : album.color)
  //                 : '#9B3179'),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: albunIcons.map<Widget>((icon) => AchievementsIcon(icon)).toList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
