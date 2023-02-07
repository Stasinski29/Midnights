import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/models/shared/user.model.dart';

class AchievementAlbumModel {
  AchievementAlbumModel(this.album, this.achievements);
  AchievementAlbumModel.empty();

  Album? album;
  List<AchievementModel>? achievements;

  void initAchievements() {}
}

class AchievementModel {
  AchievementModel(
    this.icon,
    this.name,
    this.type,
    this.isAvalible,
  );

  final UserIcon icon;
  final String name;
  final int type;
  bool isAvalible;

  String howToObtain(Album? album) {
    String result = <int, String>{
      1: 'Você precisa completar todos os álbuns com 100% de aproveitamento na categoria “trecho” para obter essa conquista.',
      2: 'Você precisa completar todos os álbuns com 100% de aproveitamento na categoria “verso” para obter essa conquista.',
      3: 'Você precisa completar todos os álbuns com 100% de aproveitamento em todas as categorias para obter essa conquista.',
    }[type]!;

    if (album != null) {
      result = <int, String>{
        1: 'Você precisa completar o álbum ${album.name} com 100% de aproveitamento na categoria “trecho” para obter essa conquista.',
        2: 'Você precisa completar o álbum ${album.name} com 100% de aproveitamento na categoria “verso” para obter essa conquista.',
        3: 'Você precisa completar o álbum ${album.name} com 100% de aproveitamento em todas as categorias para obter essa conquista.',
      }[type]!;
    }

    return result;
  }
}
