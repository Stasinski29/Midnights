import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/components/shared/comment_component.dart';
import 'package:midnights/components/shared/dialog_component.dart';
import 'package:midnights/main.dart';
import 'package:midnights/models/achievements/achievement.model.dart';
import 'package:midnights/models/shared/user.model.dart';
import 'package:midnights/providers/records.provider.dart';
import 'package:midnights/stores/user.store.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(this.callback, {Key? key}) : super(key: key);

  final VoidCallback callback;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserStore? _uStore;
  RecordesRepository? records;
  List<UserIcon> icons = UserIcon.values.sublist(0, 3);
  bool loading = true;

  @override
  void didChangeDependencies() {
    _uStore ??= Provider.of<UserStore>(context);
    records ??= Provider.of<RecordesRepository>(context);

    getIcons();

    super.didChangeDependencies();
  }

  void getIcons() {
    for (AchievementAlbumModel album in records!.allAchievements) {
      for (AchievementModel icon in album.achievements!) {
        if (icon.isAvalible) {
          icons.add(icon.icon);
        }
      }
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.callback();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            color: AppColors.bgColor,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  height:
                      MediaQuery.of(context).size.height * 0.5 - MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              widget.callback();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.mainColor,
                              size: 32.0,
                            ),
                          ),
                          Text(
                            'Seu Perfil',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 34.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Atenção!'),
                                  content: const Text(
                                    'Deseja excluir a conta para começar do zero? não será possivel recuperar os dados!',
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('Cancelar')),
                                    TextButton(
                                      onPressed: () {
                                        _uStore!.unsetUser();
                                        records!.deleteRecords();
                                        RestartWidget.restartApp(context);
                                      },
                                      child: const Text('Confirmar'),
                                    )
                                  ],
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red[300],
                              size: 32.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.bgColor,
                          child: Image.asset(_uStore!.user!.icon!.image, fit: BoxFit.cover),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _uStore!.user!.name!,
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              String newName = '';
                              await showDialog<bool>(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => DialogComponent(
                                  title: 'Alterar nome',
                                  child: CommentComponent(
                                    readOnly: false,
                                    debounceMilliseconds: 250,
                                    hint: 'Seu novo nome...',
                                    initialValue: _uStore!.user!.name ?? '',
                                    callback: (String value) => newName = value,
                                  ),
                                  confirmAction: () async {
                                    if (newName != '') {
                                      setState(() => _uStore!.updateUserName(newName));
                                    }
                                  },
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: AppColors.mainColor,
                              size: 26.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                  ),
                  child: Column(
                    children: <Widget>[
                      if (icons.length <= 4)
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Consiga mais icones ao desbloquear conquistas!',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                color: AppColors.bgColor,
                                fontSize: 18.0,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Flexible(
                        child: loading
                            ? const Center(
                                child: SizedBox.square(
                                  dimension: 60,
                                  child: CircularProgressIndicator(
                                    color: AppColors.bgColor,
                                    strokeWidth: 3.5,
                                  ),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 25.0,
                                  mainAxisExtent: 60,
                                ),
                                padding: const EdgeInsets.all(15.0),
                                itemCount: icons.length,
                                itemBuilder: (_, int index) {
                                  UserIcon icon = icons[index];

                                  bool isSelected = _uStore!.user!.icon == icon;
                                  return Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!isSelected) {
                                          setState(() => _uStore!.updateUsericon(icon));
                                        }
                                      },
                                      child: Container(
                                        width: 60.0,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          shape: BoxShape.circle,
                                          border: isSelected
                                              ? Border.all(
                                                  color: AppColors.bgColor,
                                                  width: 2.0,
                                                  strokeAlign: StrokeAlign.outside,
                                                )
                                              : null,
                                          image: DecorationImage(
                                            image: AssetImage(icon.image),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
