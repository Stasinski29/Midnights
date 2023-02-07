import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/utils/app_images.dart';

class DefaultCardComponent extends StatelessWidget {
  const DefaultCardComponent({
    super.key,
    required this.text,
    this.child,
    this.image,
    this.selected = false,
    this.icon,
    this.onTap,
    this.selectedValue,
  });

  final String text;
  final Widget? child;
  final String? selectedValue;
  final String? image;
  final bool selected;
  final IconData? icon;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final Color mainColor = selected ? AppColors.secondaryColor : AppColors.mainColor;
    final Color secondaryColor = !selected ? AppColors.bgColor : AppColors.mainColor;
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: selected ? 220 : 200,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, selectedValue != null ? 20.0 : 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: selected ? 24.0 : 22.0,
                      color: secondaryColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              child ??
                  Expanded(
                    child: Center(
                      child: image != null
                          ? Image.asset(
                              image ?? AppImages.musicIcon,
                              color: secondaryColor,
                            )
                          : Icon(
                              icon!,
                              size: 90,
                              color: secondaryColor,
                            ),
                    ),
                  ),
              if (selectedValue != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    selectedValue!,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: selected ? 22.0 : 20.0,
                        color: secondaryColor,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
