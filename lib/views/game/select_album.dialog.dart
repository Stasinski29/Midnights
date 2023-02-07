import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/components/game/bottom_buttons.component.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/utils/app_colors.dart';

class SelectAlbumDialog extends StatefulWidget {
  const SelectAlbumDialog({super.key});

  @override
  State<SelectAlbumDialog> createState() => _SelectAlbumDialogState();
}

class _SelectAlbumDialogState extends State<SelectAlbumDialog> {
  List<Album> albuns = Album.values;
  Album? selectedAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: const Center(child: Text('Selecione um album')),
      ),
      body: Center(
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
                    bool selected = currentAlbum == selectedAlbum;
                    return GestureDetector(
                      onTap: () => setState(() => selectedAlbum = currentAlbum),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected ? AppColors.secondaryColor : Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        ),
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
      bottomNavigationBar: BottomButtonsComponent(
        cancelAction: () => Navigator.of(context).pop(),
        cancelText: 'Voltar',
        confirmAction: () => Navigator.of(context).pop<Album>(selectedAlbum),
        confirmText: 'Selecionar',
        disabled: selectedAlbum == null,
      ),
    );
  }
}
