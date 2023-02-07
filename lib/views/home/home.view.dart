import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/components/home/profile_avatar.component.dart';
import 'package:midnights/controllers/home.controller.dart';
import 'package:midnights/stores/user.store.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/utils/app_images.dart';
import 'package:midnights/views/achievements/achievements.view.dart';
import 'package:midnights/views/game/new_game_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController? _controller;
  UserStore? _uStore;

  @override
  void didChangeDependencies() {
    _uStore ??= Provider.of<UserStore>(context);
    _controller ??= HomeController(_uStore!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.28,
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    image: DecorationImage(
                      image: AssetImage(AppImages.background),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Image.asset(AppImages.title, scale: 1.8),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  left: 10.0,
                  child: ProfileAvatar(_uStore!.user!.icon!, () => setState(() {})),
                )
              ],
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15,
                    vertical: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _controller!.getInitialMessage(),
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            color: AppColors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50.0),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const NewGameView()),
                        ),
                        child: Card(
                          elevation: 5.0,
                          color: AppColors.bgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: AppColors.purple3),
                          ),
                          borderOnForeground: true,
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Jogar',
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.purple3,
                                    ),
                                  ),
                                ),
                                const Icon(FontAwesomeIcons.music, color: AppColors.purple3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const AchievementsView()),
                        ),
                        child: Card(
                          elevation: 5.0,
                          color: AppColors.bgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: AppColors.purple3),
                          ),
                          borderOnForeground: true,
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Conquistas',
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.purple3,
                                    ),
                                  ),
                                ),
                                const Icon(FontAwesomeIcons.trophy, color: AppColors.purple3),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
