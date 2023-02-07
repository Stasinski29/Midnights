import 'package:midnights/utils/app_images.dart';

enum GameType { lyrics, time }

enum Album {
  taylorSwift('Taylor Swift', AppImages.grafiaTS, '#386F43', '#50A7E0', false),
  fearless('Fearless', AppImages.grafiaFearless, '#DAC785', '#8C551C', false),
  speakNow('Speak Now', AppImages.grafiaSpeakNow, '#AB3AB4', '#CB2D30', false),
  red('Red', AppImages.grafiaRed, '#87000F', '#A99679', false),
  album1989('1989', AppImages.grafia1989, '#B6CEF0', '#836277', true),
  reputation('reputation', AppImages.grafiaReputation, '#676767', '#F45C1D', false),
  lover('Lover', AppImages.grafiaLover, '#F5A3CB', '#98C4F2', false),
  folklore('folklore', AppImages.grafiaFolk, '#E3E3E3', '#A6A6A6', true),
  evermore('evermore', AppImages.grafiaEvermore, '#953F10', '#6D412A', false),
  midnights('Midnights', AppImages.grafiaMidnights, '#85A6B7', '#AC9FB8', false);

  const Album(this.name, this.image, this.color, this.secondaryColor, this.useSecondary);
  final String image;
  final String color;
  final String secondaryColor;
  final String name;
  final bool useSecondary;

  String get title => name;
}

class GameModel {
  GameModel({this.type, this.album});

  GameType? type;
  Album? album;
}
