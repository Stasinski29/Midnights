import 'package:midnights/utils/app_images.dart';

class UserModel {
  UserModel({this.name, this.icon});

  String? name;
  UserIcon? icon;
}

enum UserIcon {
  avatar1(AppImages.avatar1, true),
  avatar2(AppImages.avatar2, true),
  avatar3(AppImages.avatar3, true),
  avatarTs1(AppImages.avatarTs1, false),
  avatarTs2(AppImages.avatarTs2, false),
  avatarTs3(AppImages.avatarTs3, false),
  avatarFear1(AppImages.avatarFear1, false),
  avatarFear2(AppImages.avatarFear2, false),
  avatarFear3(AppImages.avatarFear3, false),
  avatarSN1(AppImages.avatarSpeak1, false),
  avatarSN2(AppImages.avatarSpeak2, false),
  avatarSN3(AppImages.avatarSpeak3, false),
  avatarRed1(AppImages.avatarRed1, false),
  avatarRed2(AppImages.avatarRed2, false),
  avatarRed3(AppImages.avatarRed3, false),
  avatar19891(AppImages.avatar19891, false),
  avatar19892(AppImages.avatar19892, false),
  avatar19893(AppImages.avatar19893, false),
  avatarRep1(AppImages.avatarRep1, false),
  avatarRep2(AppImages.avatarRep2, false),
  avatarRep3(AppImages.avatarRep3, false),
  avatarLover1(AppImages.avatarLover1, false),
  avatarLover2(AppImages.avatarLover2, false),
  avatarLover3(AppImages.avatarLover3, false),
  avatarFolk1(AppImages.avatarFolk1, false),
  avatarFolk2(AppImages.avatarFolk2, false),
  avatarFolk3(AppImages.avatarFolk3, false),
  avatarEver1(AppImages.avatarEver1, false),
  avatarEver2(AppImages.avatarEver2, false),
  avatarEver3(AppImages.avatarEver3, false),
  avatarMid1(AppImages.avatarMid1, false),
  avatarMid2(AppImages.avatarMid2, false),
  avatarMid3(AppImages.avatarMid3, false),
  avatarEras1(AppImages.avatarEras1, false),
  avatarEras2(AppImages.avatarEras2, false),
  avatarEras3(AppImages.avatarEras3, false),
  ;

  const UserIcon(this.image, this.avalible);

  final String image;
  final bool avalible;
}
