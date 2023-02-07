import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/components/game/game_option_button.component.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/utils/app_images.dart';

enum GameResult {
  bad('Não foi dessa vez', 'Você ainda não está pronto', AppImages.resultBad),
  regular(
    'Está melhorando',
    'Se você nunca errar você nunca vai crescer e ta tudo bem',
    AppImages.resultRegular,
  ),
  good('Você consegue fazer melhor', 'Continue tentando', AppImages.resultGood),
  great('Quase lá', 'Todos os erros são um passo que você toma', AppImages.resultGreat),
  excelentTS(
    'Parabéns!',
    ' Suas respostas foram perfeitas! Os outros desejam ser tão impecáveis quanto você',
    AppImages.resultTS,
  ),
  excelentFear('Parabéns!', 'Sr. Sempre Vence', AppImages.resultFear),
  excelentSN('Parabéns!', 'Sua pontuação foi encantadora', AppImages.resultSN),
  excelentRed('Parabéns!', 'Você se lembra de tudo muito bem', AppImages.resultRed),
  excelent1989('Parabéns!', ' Quanto estilo!', AppImages.result1989),
  excelentRep('Parabéns!', 'Você está se saindo melhor do que nunca!', AppImages.resultRep),
  excelentLover('Parabéns!', 'Você é o rei do nosso coração', AppImages.resultLover),
  excelentFolk('Parabéns!', 'Não foi divertido?', AppImages.resultFolk),
  excelentEver(
    'Parabéns!',
    'Esperamos que você não tenha trapaceado pra ganhar',
    AppImages.resultEver,
  ),
  excelentMid('Parabéns!', 'Cheque-mate!', AppImages.resultMid);

  const GameResult(this.title, this.message, this.image);

  final String title;
  final String message;
  final String image;

  factory GameResult.fromPercent(double percent, Album album) {
    GameResult result;
    if (percent <= 25) {
      result = GameResult.bad;
    } else if (percent > 25 && percent <= 50) {
      result = GameResult.regular;
    } else if (percent > 50 && percent <= 75) {
      result = GameResult.good;
    } else if (percent > 75 && percent <= 99) {
      result = GameResult.great;
    } else {
      result = GameResult.fromAlbum(album);
    }

    return result;
  }

  factory GameResult.fromAlbum(Album album) => <Album, GameResult>{
        Album.taylorSwift: GameResult.excelentTS,
        Album.fearless: GameResult.excelentFear,
        Album.speakNow: GameResult.excelentSN,
        Album.red: GameResult.excelentRed,
        Album.album1989: GameResult.excelent1989,
        Album.reputation: GameResult.excelentRep,
        Album.lover: GameResult.excelentLover,
        Album.folklore: GameResult.excelentFolk,
        Album.evermore: GameResult.excelentEver,
        Album.midnights: GameResult.excelentMid,
      }[album]!;
}

class GameResultDialog extends StatefulWidget {
  const GameResultDialog(this.callback, {super.key, required this.percent, required this.album});

  final VoidCallback callback;
  final Album album;
  final double percent;

  @override
  State<GameResultDialog> createState() => _GameResultDialogState();
}

class _GameResultDialogState extends State<GameResultDialog> {
  late GameResult gameResult;

  @override
  void initState() {
    super.initState();
    gameResult = GameResult.fromPercent(widget.percent, widget.album);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              gameResult.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainColor,
                  height: 1.1,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              gameResult.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.purple2,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 35.0),
            child: Image.asset(gameResult.image, scale: 2.2),
          ),
          Text(
            '${widget.percent.floor()}% de acerto',
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
                color: AppColors.mainColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: GameOptionButton(
              onTap: widget.callback,
              text: 'Jogar de novo',
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6),
              mainColor: AppColors.bgColor,
              buttonColor: AppColors.secondaryColor,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          GameOptionButton(
            onTap: (() => Navigator.of(context).pop()),
            text: 'Voltar ao incio',
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 6,
            ),
            mainColor: AppColors.secondaryColor,
            buttonColor: AppColors.bgColor,
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
