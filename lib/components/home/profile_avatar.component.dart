import 'package:flutter/material.dart';
import 'package:midnights/models/shared/user.model.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/views/profile/profile.view.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar(this.icon, this.callback, {super.key});

  final UserIcon icon;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => ProfileView(callback)),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(2.5),
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage(icon.image), fit: BoxFit.fitWidth),
          ),
        ),
      ),
    );
  }
}
