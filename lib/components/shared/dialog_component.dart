import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({
    super.key,
    this.content,
    this.title,
    this.cancelAction,
    this.confirmAction,
    this.actions,
    this.cancelText,
    this.confirmText,
    this.mustHideCancelButton = false,
    this.confirmColor,
    this.child,
  }) : assert(content != null || child != null, 'A mensagem ou um widget deve ser especificado.');

  final String? title, cancelText, confirmText;
  final String? content;
  final Function? cancelAction, confirmAction;
  final List<Widget>? actions;
  final Color? confirmColor;
  final Widget? child;
  final bool mustHideCancelButton;

  @override
  // ignore: library_private_types_in_public_api
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: widget.title != null
          ? Text(
              widget.title!,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#3C3F4C'),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            )
          : null,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      content: SizedBox(
        width: double.maxFinite,
        child: widget.child ??
            Text(
              widget.content!,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#3C3F4C'),
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
              ),
              softWrap: true,
            ),
      ),
      actions: widget.actions ?? _defaultActions(),
    );
  }

  List<Widget> _defaultActions() {
    return <Widget>[
      if (!widget.mustHideCancelButton)
        TextButton(
          child: Text(
            widget.cancelText?.toUpperCase() ?? 'CANCELAR',
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                color: HexColor('#6A6F86'),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onPressed: () {
            if (widget.cancelAction == null) {
              return Navigator.of(context).pop(false);
            } else {
              // ignore: void_checks
              return widget.cancelAction!();
            }
          },
        ),
      TextButton(
        child: Text(
          widget.confirmText?.toUpperCase() ?? 'CONFIRMAR',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: widget.confirmColor ?? Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onPressed: () {
          if (widget.confirmAction == null) {
            return Navigator.of(context).pop(true);
          } else {
            widget.confirmAction!();
            Navigator.of(context).pop();
          }
        },
      ),
    ];
  }
}
