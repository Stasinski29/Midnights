import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/components/game/game_option_button.component.dart';
import 'package:midnights/components/logon/input_decoration.dart';
import 'package:midnights/components/utils/keyboard_hider.component.dart';
import 'package:midnights/models/shared/user.model.dart';
import 'package:midnights/stores/user.store.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/utils/app_images.dart';
import 'package:midnights/views/home/home.view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final UserModel _user = UserModel();
  final List<UserIcon> icons = UserIcon.values.sublist(0, 3);
  UserStore? _uStore;

  @override
  void didChangeDependencies() {
    _uStore ??= Provider.of<UserStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: KeyboardHider(
          child: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Bem vindo ao',
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 35.0),
                    child: Image.asset(AppImages.title, scale: 1.5),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Como gostaria de ser chamado?',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            decoration: InputDecorationComponent('swiftie129...'),
                            onChanged: (String? newName) => _user.name = newName,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
                    child: Text(
                      'Selecione seu avatar',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buildInitialAvatars(),
                  ),
                  const Spacer(),
                  GameOptionButton(
                    onTap: () {
                      _uStore!.setUser(_user);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomeView()),
                      );
                    },
                    text: 'Confirmar',
                    disabled: _user.name == null || _user.icon == null,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    mainColor: AppColors.bgColor,
                    buttonColor: AppColors.mainColor,
                    fontSize: 34.0,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInitialAvatars() {
    List<Widget> result = [];

    for (UserIcon icon in icons) {
      bool isSelected = _user.icon == icon;
      result.add(GestureDetector(
        onTap: () => setState(() => _user.icon = isSelected ? null : icon),
        child: CircleAvatar(
          radius: isSelected ? 40.0 : 35.0,
          backgroundColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.all(2.5),
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: AppColors.purple2,
                      width: 2.5,
                      //strokeAlign: StrokeAlign.outside,
                    )
                  : null,
              image: DecorationImage(
                image: AssetImage(icon.image),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ));
    }

    return result;
  }
}
