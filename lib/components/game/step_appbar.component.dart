import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/utils/app_colors.dart';

class StepsAppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const StepsAppBarComponent({
    super.key,
    required this.title,
    required this.stepsLenght,
    required this.currentStep,
    required this.subtitles,
    this.closeIcon = false,
  });
  final String title;
  final List<String> subtitles;
  final bool closeIcon;
  final int currentStep;
  final int stepsLenght;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          closeIcon ? Icons.arrow_back : FontAwesomeIcons.chevronLeft,
          color: AppColors.bgColor,
          size: 24.0,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 3.0,
      titleSpacing: 0.0,
      title: Text(
        title.toUpperCase(),
        style: GoogleFonts.nunito(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.bgColor,
          ),
        ),
      ),
      backgroundColor: AppColors.mainColor,
      centerTitle: true,
      flexibleSpace: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight, bottom: 20),
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                subtitles[currentStep - 1],
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    color: AppColors.bgColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              StepProgressComponent(
                curStep: currentStep,
                stepsLenght: stepsLenght,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}

class StepProgressComponent extends StatelessWidget {
  const StepProgressComponent({
    super.key,
    required this.curStep,
    required this.stepsLenght,
    this.lineWidth = 4.0,
    this.padding,
  });

  final int curStep;
  final int stepsLenght;

  final double? lineWidth;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: buildSteps(),
      ),
    );
  }

  List<Widget> buildSteps() {
    final List<Widget> list = <Widget>[];

    for (int i = 0; i < stepsLenght; i++) {
      final Color circleColor = (curStep > i + 1) ? AppColors.secondaryColor : AppColors.bgColor;
      final Color lineColor = curStep > i + 1 ? AppColors.secondaryColor : AppColors.bgColor;
      final Color iconColor = (curStep > i + 1) ? AppColors.bgColor : AppColors.secondaryColor;

      list.add(
        Container(
          width: 30.0,
          height: 30.0,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: i == 0 || i == curStep - 1
                ? Border.all(
                    color: AppColors.secondaryColor,
                    width: 2.0,
                  )
                : null,
          ),
          child: _getContent(i, stepsLenght, iconColor),
        ),
      );

      if (i != stepsLenght - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              color: lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget _getContent(int index, int lenght, Color? iconColor) {
    Widget result = const SizedBox();

    if (curStep > index + 1) {
      result = Icon(
        FontAwesomeIcons.check,
        color: iconColor,
        size: 15.0,
      );
    } else {
      result = Center(
        child: Text(
          '${index + 1}',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: index == curStep - 1 ? AppColors.mainColor : AppColors.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }

    return result;
  }
}
