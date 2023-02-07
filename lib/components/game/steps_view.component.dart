import 'package:flutter/material.dart';
import 'package:midnights/components/game/bottom_buttons.component.dart';
import 'package:midnights/components/game/step_appbar.component.dart';

class StepViewComponent extends StatefulWidget {
  const StepViewComponent({
    super.key,
    required this.title,
    required this.subtitles,
    required this.pages,
    this.confirmText,
    this.cancelText,
    this.cancelAction,
    this.onNavigateFoward,
    this.canNavigateFoward,
    this.onSubmit,
  });

  final String title;
  final String? confirmText, cancelText;
  final List<String> subtitles;
  final List<Widget> pages;
  final Function? onNavigateFoward;
  final Function? canNavigateFoward;
  final Function? onSubmit;
  final Function? cancelAction;

  @override
  // ignore: library_private_types_in_public_api
  _StepViewComponentState createState() => _StepViewComponentState();
}

class _StepViewComponentState extends State<StepViewComponent> {
  late PageController _pageController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: StepsAppBarComponent(
        subtitles: widget.subtitles,
        title: widget.title,
        stepsLenght: widget.pages.length,
        currentStep: currentPage,
        closeIcon: true,
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: widget.pages,
        ),
      ),
      bottomNavigationBar: BottomButtonsComponent(
        disabled: _isDisabled(currentPage),
        cancelAction: () {
          setState(() {
            if (currentPage == 1) {
              widget.cancelAction != null ? widget.cancelAction!() : Navigator.of(context).pop();
            } else {
              currentPage--;
              _pageController.previousPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              );
            }
          });
        },
        confirmAction: () {
          if (currentPage != widget.pages.length) {
            setState(() {
              currentPage++;
              _pageController.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              );
            });

            if (widget.onNavigateFoward != null) widget.onNavigateFoward!(currentPage);
          } else {
            if (widget.onSubmit != null) widget.onSubmit!();
          }
        },
        cancelText: currentPage == 1 ? widget.cancelText ?? 'Cancelar' : 'voltar',
        confirmText: currentPage == widget.pages.length ? widget.confirmText ?? 'Jogar' : 'Avançar',
      ),
    );
  }

  bool _isDisabled(int currentPage) {
    bool disabled = false;

    if (widget.canNavigateFoward != null) disabled = !widget.canNavigateFoward!(currentPage);

    return disabled;
  }
}
