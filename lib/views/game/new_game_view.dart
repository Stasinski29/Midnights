import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/components/game/steps_view.component.dart';
import 'package:midnights/components/shared/default_card.component.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/views/game/game.view.dart';

import '../../models/game/game.model.dart';

class NewGameView extends StatefulWidget {
  const NewGameView({Key? key}) : super(key: key);

  @override
  State<NewGameView> createState() => _NewGameViewState();
}

class _NewGameViewState extends State<NewGameView> {
  late GameModel _model;

  @override
  void initState() {
    _model = GameModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StepViewComponent(
      title: 'Novo jogo',
      subtitles: const [
        'Selecione o album',
        'Selecione o tipo',
      ],
      canNavigateFoward: (int currentPage) {
        switch (currentPage) {
          case 1:
            return _model.album != null;

          case 2:
            return _model.type != null;
        }
      },
      pages: [firstStep(), secondStep()],
      onSubmit: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => GameView(_model)),
        );
      },
    );
  }

  Widget firstStep() {
    List<Album> albuns = Album.values;

    return Container(
      color: AppColors.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Com qual album quer jogar?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        color: AppColors.bgColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 50,
                      ),
                      padding: const EdgeInsets.all(15.0),
                      itemCount: albuns.length,
                      itemBuilder: (_, int index) {
                        Album currentAlbum = albuns[index];
                        bool selected = currentAlbum == _model.album;
                        return GestureDetector(
                          onTap: () => setState(() => _model.album = currentAlbum),
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                              color: selected ? AppColors.secondaryColor : Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            duration: const Duration(milliseconds: 250),
                            child: Center(
                              child: Text(
                                currentAlbum.title,
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                                    fontSize: 18.0,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // GridView.count(crossAxisCount: crossAxisCount),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget secondStep() {
    return Container(
      color: AppColors.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Adivinhar por...',
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: 28.0,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: DefaultCardComponent(
                      text: 'Trecho',
                      icon: Icons.timer,
                      selected: _model.type == GameType.time,
                      onTap: () => setState(() => _model.type = GameType.time)),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: DefaultCardComponent(
                    text: 'Verso',
                    icon: Icons.lyrics,
                    selected: _model.type == GameType.lyrics,
                    onTap: () => setState(() => _model.type = GameType.lyrics),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
