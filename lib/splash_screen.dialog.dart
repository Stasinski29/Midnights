// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:midnights/controllers/main.controller.dart';
import 'package:midnights/providers/records.provider.dart';
import 'package:midnights/stores/user.store.dart';
import 'package:midnights/utils/app_colors.dart';
import 'package:midnights/utils/app_images.dart';
import 'package:midnights/views/home/home.view.dart';
import 'package:midnights/views/login/login.view.dart';
import 'package:provider/provider.dart';

class SplashScreenDialog extends StatefulWidget {
  const SplashScreenDialog({super.key});

  @override
  _SplashScreenDialogState createState() => _SplashScreenDialogState();
}

class _SplashScreenDialogState extends State<SplashScreenDialog> {
  bool loading = true;
  UserStore? _uStore;
  RecordesRepository? _recordes;
  MainController? _controller;

  Future<void> _initialFetch() async {
    if (mounted) setState(() => _controller!.loading = false);
  }

  @override
  void didChangeDependencies() {
    _recordes ??= Provider.of<RecordesRepository>(context);

    _uStore ??= Provider.of<UserStore>(context);
    _controller ??= MainController(_uStore!, _recordes!);

    Timer(const Duration(seconds: 2), () {
      _initialFetch().then((void value) {
        hasSession().then(
          (bool session) {
            if (session) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeView()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginView()),
              );
            }
          },
        );
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: MediaQuery.of(context).size.height * 0.12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                  image: DecorationImage(image: AssetImage(AppImages.logo), fit: BoxFit.fitHeight),
                ),
              ),
              const SizedBox(height: 50.0),
              if (loading) const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> hasSession() async => _uStore!.user != null;
}
