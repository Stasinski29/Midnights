import 'package:hive/hive.dart';
import 'package:midnights/models/achievements/achievement.model.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/models/shared/user.model.dart';
import 'package:mobx/mobx.dart';

part 'records.provider.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;

abstract class RecordesRepositoryBase with Store {
  late final Box _recordes;

  @observable
  AchievementAlbumModel conquistaEras = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaTs = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaFear = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaSn = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaRed = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquista1989 = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaRep = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaLover = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaFolk = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaEver = AchievementAlbumModel.empty();

  @observable
  AchievementAlbumModel conquistaMid = AchievementAlbumModel.empty();

  RecordesRepositoryBase() {
    _initRepository();
  }

  List<AchievementAlbumModel> get allAchievements => <AchievementAlbumModel>[
        conquistaEras,
        conquistaTs,
        conquistaFear,
        conquistaSn,
        conquistaRed,
        conquista1989,
        conquistaRep,
        conquistaLover,
        conquistaFolk,
        conquistaEver,
        conquistaMid,
      ];

  _initRepository() async {
    await _initDatabase();
    await loadRecordes();
  }

  _initDatabase() async {
    _recordes = await Hive.openBox('gameRecordes');
  }

  @action
  void deleteRecords() {
    _recordes.deleteFromDisk();
  }

  @action
  loadRecordes() {
    conquistaEras = AchievementAlbumModel(null, getAchievements(null, 11));
    conquistaTs = AchievementAlbumModel(Album.taylorSwift, getAchievements(Album.taylorSwift, 1));
    conquistaFear = AchievementAlbumModel(Album.fearless, getAchievements(Album.fearless, 2));
    conquistaSn = AchievementAlbumModel(Album.speakNow, getAchievements(Album.speakNow, 3));
    conquistaRed = AchievementAlbumModel(Album.red, getAchievements(Album.red, 4));
    conquista1989 = AchievementAlbumModel(Album.album1989, getAchievements(Album.album1989, 5));
    conquistaRep = AchievementAlbumModel(Album.reputation, getAchievements(Album.reputation, 6));
    conquistaLover = AchievementAlbumModel(Album.lover, getAchievements(Album.lover, 7));
    conquistaFolk = AchievementAlbumModel(Album.folklore, getAchievements(Album.folklore, 8));
    conquistaEver = AchievementAlbumModel(Album.evermore, getAchievements(Album.evermore, 9));
    conquistaMid = AchievementAlbumModel(Album.midnights, getAchievements(Album.midnights, 10));
  }

  List<AchievementModel> getAchievements(Album? album, int divisor) {
    List<UserIcon> albunIcons = UserIcon.values.sublist(divisor * 3, divisor * 3 + 3);
    String key1 = album != null ? (album.title + GameType.time.name) : 'eras1';
    String key2 = album != null ? (album.title + GameType.lyrics.name) : 'eras2';
    String key3 = album != null ? ('${album.title}both') : 'eras3';

    return <AchievementModel>[
      AchievementModel(
        albunIcons[0],
        album?.name ?? 'Eras',
        1,
        _recordes.get(key1) ?? false,
      ),
      AchievementModel(
        albunIcons[1],
        album?.name ?? 'Eras',
        2,
        _recordes.get(key2) ?? false,
      ),
      AchievementModel(
        albunIcons[2],
        album?.name ?? 'Eras',
        3,
        _recordes.get(key3) ?? false,
      ),
    ];
  }

  @action
  updateRecordes({required Album album, required GameType type, required int score}) async {
    if (score == 100) {
      switch (album) {
        case Album.taylorSwift:
          await setRecord(conquistaTs, album, type);
          break;
        case Album.fearless:
          await setRecord(conquistaFear, album, type);
          break;
        case Album.speakNow:
          await setRecord(conquistaSn, album, type);
          break;
        case Album.red:
          await setRecord(conquistaRed, album, type);
          break;
        case Album.album1989:
          await setRecord(conquista1989, album, type);
          break;
        case Album.reputation:
          await setRecord(conquistaRep, album, type);
          break;
        case Album.lover:
          await setRecord(conquistaLover, album, type);
          break;
        case Album.folklore:
          await setRecord(conquistaFolk, album, type);
          break;
        case Album.evermore:
          await setRecord(conquistaEver, album, type);

          break;
        case Album.midnights:
          await setRecord(conquistaMid, album, type);

          break;
      }
    }
  }

  Future<void> setRecord(AchievementAlbumModel model, Album album, GameType type) async {
    int index = type == GameType.time ? 0 : 1;
    final key = album.title;

    model.achievements![index].isAvalible = true;
    await _recordes.put(key + type.name, true);

    if (model.achievements![0].isAvalible && model.achievements![1].isAvalible) {
      model.achievements![2].isAvalible = true;
      await _recordes.put('${album.title}both', true);
    }
  }
}
