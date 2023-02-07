import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/models/achievements/achievement.model.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/utils/app_colors.dart';

class AchievementsIcon extends StatelessWidget {
  const AchievementsIcon(this.achievement, this.album, {super.key});

  final AchievementModel achievement;
  final Album? album;

  @override
  Widget build(BuildContext context) {
    bool isAvalible = achievement.isAvalible;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          HeroDialogRoute(
            builder: (context) => AlertDialog(
              titlePadding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              title: Container(
                height: 50.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          achievement.name,
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              color: AppColors.bgColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.bgColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              content: Row(
                children: <Widget>[
                  Hero(
                    tag: achievement.icon,
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(achievement.icon.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Flexible(
                    child: Text(
                      achievement.howToObtain(album),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Opacity(
            opacity: isAvalible ? 1.0 : 0.5,
            child: Hero(
              tag: achievement.icon,
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(achievement.icon.image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          if (!isAvalible)
            const Positioned(
              left: 15.0,
              top: 12.5,
              child: Icon(
                Icons.lock,
                size: 32.0,
                color: AppColors.bgColor,
              ),
            ),
        ],
      ),
    );
  }
}

// stack overflow veio bem
class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({required this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child);
  }

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String? get barrierLabel => 'teste';
}
