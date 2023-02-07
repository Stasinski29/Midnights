import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:just_audio/just_audio.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/models/game/music.model.dart';

abstract class MusicPreviewFactory extends Widget {
  factory MusicPreviewFactory(GameType type, MusicModel music, Album album, bool needUpdate) =>
      <GameType, MusicPreviewFactory>{
        GameType.lyrics: MusicPreviewByLyrics(music, album),
        GameType.time: MusicPreviewByTime(music, album, needUpdate),
      }[type]!;
}

class MusicPreviewByTime extends StatefulWidget implements MusicPreviewFactory {
  const MusicPreviewByTime(this.music, this.album, this.needUpdate, {super.key});

  final MusicModel music;
  final Album album;
  final bool needUpdate;

  @override
  State<MusicPreviewByTime> createState() => _MusicPreviewByTimeState();
}

class _MusicPreviewByTimeState extends State<MusicPreviewByTime> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    preparePlayer();
  }

  @override
  void didChangeDependencies() {
    if (widget.needUpdate) {
      setState(() => preparePlayer());
    }

    super.didChangeDependencies();
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
      await _player.setUrl(widget.music.url);
      setState(() {});
    } catch (e) {
      debugPrint('Ocorreu um erro ao carregar o audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = HexColor(widget.album.secondaryColor);
    const double iconSize = 100.0;
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        final dynamic playerState = snapshot.data;
        final dynamic processingState = playerState?.processingState;
        final dynamic playing = playerState?.playing;
        if (widget.needUpdate) {
          return IconButton(
            iconSize: iconSize,
            icon: Icon(Icons.circle_rounded, color: iconColor),
            onPressed: () {},
            padding: EdgeInsets.zero,
            tooltip: 'Carregando',
          );
        }
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return IconButton(
            iconSize: iconSize,
            icon: Icon(Icons.circle_rounded, color: iconColor),
            onPressed: () {},
            padding: EdgeInsets.zero,
            tooltip: 'Carregando',
          );
        } else if (playing != true) {
          return IconButton(
            iconSize: iconSize,
            icon: Icon(Icons.play_circle, color: iconColor),
            onPressed: _player.play,
            padding: EdgeInsets.zero,
            tooltip: 'Reproduzir',
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            iconSize: iconSize,
            icon: Icon(Icons.pause_circle, color: iconColor),
            onPressed: _player.pause,
            padding: EdgeInsets.zero,
            tooltip: 'Pausar',
          );
        } else {
          return IconButton(
            iconSize: iconSize,
            icon: Icon(Icons.replay_circle_filled_outlined, color: iconColor),
            onPressed: () => _player.seek(Duration.zero),
            padding: EdgeInsets.zero,
            tooltip: 'Tocar denovo',
          );
        }
      },
    );
  }
}

class MusicPreviewByLyrics extends StatelessWidget implements MusicPreviewFactory {
  const MusicPreviewByLyrics(this.music, this.album, {super.key});

  final MusicModel music;
  final Album album;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        music.lyrics,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          textStyle: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w400,
            color: HexColor(album.secondaryColor),
          ),
        ),
      ),
    );
  }
}
