import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:just_audio/just_audio.dart';
import 'package:midnights/components/game/music_preview.component.dart';
import 'package:midnights/components/shared/game_album_appbar.dart';
import 'package:midnights/components/shared/loading.component.dart';
import 'package:midnights/controllers/game.controller.dart';
import 'package:midnights/models/game/music.model.dart';
import 'package:midnights/providers/records.provider.dart';
import 'package:midnights/utils/app_sounds.dart';
import 'package:midnights/views/game/game_result.dialog.dart';
import 'package:provider/provider.dart';

import '../../components/game/game_option_button.component.dart';
import '../../models/game/game.model.dart';
import '../../utils/app_colors.dart';

enum GameStatus { running, win, loss }

class GameView extends StatefulWidget {
  const GameView(this.model, {super.key});

  final GameModel model;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  GameController? _controller;
  MusicModel? selectedMusic;
  GameStatus status = GameStatus.running;
  RecordesRepository? _repository;
  GameModel get model => widget.model;
  GameController get controller => _controller!;
  bool get isCorrect => selectedMusic == controller.correctMusics[index];
  int get index => _controller!.currentMusic;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    preparePlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> preparePlayer() async {
    _player.playbackEventStream.listen((PlaybackEvent event) {},
        onError: (Object e, StackTrace stackTrace) {
      debugPrint('Ocorreu um erro: $e');
    });

    try {
      await _player.setUrl(AppSounds.goodSound);
      setState(() {});
    } catch (e) {
      debugPrint('Ocorreu um erro ao carregar o audio: $e');
    }
  }

  void nextMusic() {
    _controller!.currentMusic++;
    controller.getCurrentGameOptions();

    setState(() => resetCounters());
  }

  void resetCounters() {
    selectedMusic = null;
    _controller!.isRequesting = false;
  }

  @override
  void didChangeDependencies() {
    _repository ??= Provider.of<RecordesRepository>(context);
    _controller ??= GameController(model, _repository!);
    initialFetch();

    super.didChangeDependencies();
  }

  void initialFetch() async {
    if (controller.isLoading) {
      resetCounters();
      await controller.getMusics();
      controller.getCurrentGameOptions();
      if (mounted) setState(() => controller.isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(model.album!.color),
      body: SafeArea(
        child: status == GameStatus.running
            ? Container(
                color: AppColors.bgColor,
                height: double.maxFinite,
                child: controller.isLoading
                    ? LoadingScreen(model.album!)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GameAlbumAppBar(model.album!, '${index + 1}/${_controller!.totalMusics}'),
                          const Spacer(),
                          _controller!.isRequesting && model.type == GameType.time
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 100,
                                      icon: Icon(
                                        Icons.circle_rounded,
                                        color: HexColor(model.album!.secondaryColor),
                                      ),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      tooltip: 'Carregando',
                                    ),
                                    const CircularProgressIndicator(
                                      color: AppColors.bgColor,
                                      strokeWidth: 5.0,
                                    ),
                                  ],
                                )
                              : MusicPreviewFactory(
                                  model.type!,
                                  controller.correctMusics[index],
                                  model.album!,
                                  _controller!.isRequesting,
                                ),
                          const Spacer(),
                          ...getOptions(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.1)
                        ],
                      ),
              )
            : GameResultDialog(
                () {
                  setState(() {
                    status = GameStatus.running;
                    controller.isLoading = true;
                    initialFetch();
                  });
                },
                percent: _controller!.getGamePerformance(),
                album: model.album!,
              ),
      ),
    );
  }

  List<Widget> getOptions() {
    List<Widget> optionButtons = [];

    for (MusicModel music in _controller!.options) {
      bool selected = selectedMusic == music;
      Color answerColor = HexColor(music.isCorrect ? '#66bb69' : '#bb6666');
      optionButtons.add(
        AbsorbPointer(
          absorbing: selectedMusic != null,
          child: GameOptionButton(
            text: music.title,
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            buttonColor: selected
                ? answerColor
                : HexColor(
                    model.album!.useSecondary ? model.album!.secondaryColor : model.album!.color,
                  ),
            textSize: 22.0,
            textColor: Colors.white,
            onTap: () async {
              _controller!.isRequesting = true;
              setState(() => selectedMusic = music);

              await _player.setAsset(isCorrect ? AppSounds.goodSound : AppSounds.badSound);

              _player.play();
              _controller!.setAnswer = isCorrect;

              Timer(const Duration(milliseconds: 1500), () {
                setState(() {
                  if (_controller!.endGame) {
                    status = isCorrect ? GameStatus.win : GameStatus.loss;
                  } else {
                    nextMusic();
                  }
                });
              });
            },
          ),
        ),
      );
    }

    return optionButtons;
  }
}
