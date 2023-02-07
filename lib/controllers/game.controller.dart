import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/models/game/music.model.dart';
import 'package:midnights/providers/firebase.provider.dart';
import 'package:midnights/providers/records.provider.dart';

class GameController {
  GameController(GameModel game, RecordesRepository repository) {
    _game = game;
    _repository = repository;
  }

  late GameModel _game;
  late RecordesRepository _repository;
  late List<MusicModel> allMusics;
  late List<MusicModel> correctMusics;
  List<MusicModel> options = <MusicModel>[];
  List<bool> answers = <bool>[];

  int currentMusic = 0;
  bool isLoading = true;
  bool isRequesting = false;

  bool get endGame => (currentMusic + 1) == correctMusics.length;
  int get totalMusics => correctMusics.length;

  set setAnswer(bool answer) {
    answers.add(answer);
  }

  void resetCounters() {
    currentMusic = 0;
    answers.clear();
  }

  Future<void> getMusics() async {
    allMusics = await FirebaseProvider().getRandomMusics(_game.album!);
    resetCounters();

    setCorrectMusicsOrder();
  }

  void setCorrectMusicsOrder() {
    correctMusics = allMusics.map((music) => MusicModel.clone(music)).toList();

    for (var music in correctMusics) {
      music.isCorrect = true;
    }

    correctMusics.shuffle();
  }

  List<MusicModel> getCurrentGameOptions() {
    options.clear();
    allMusics.shuffle();
    options = allMusics.map((music) => MusicModel.clone(music)).toList();
    options.removeWhere((MusicModel music) => music.title == correctMusics[currentMusic].title);
    options = options.sublist(0, 3);
    options.add(correctMusics[currentMusic]);
    options.shuffle();

    return options;
  }

  void updateGameAchievements(int score) {
    _repository.updateRecordes(album: _game.album!, type: _game.type!, score: score);
  }

  double getGamePerformance() {
    int correctAnswers = answers.where((bool answer) => answer == true).toList().length;
    int totalAnswers = answers.length;

    double percent = (correctAnswers * 100) / totalAnswers;

    updateGameAchievements(percent.floor());
    return percent;
  }
}
