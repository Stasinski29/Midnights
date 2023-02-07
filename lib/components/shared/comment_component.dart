import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent({
    super.key,
    required this.readOnly,
    this.callback,
    this.initialValue = '',
    this.padding,
    this.hint = 'Comentário...',
    this.minLines = 1,
    this.filled = true,
    this.borderColor,
    this.readOnlyWithoutTextField = false,
    this.debounceMilliseconds = 2000,
  });

  const CommentComponent.transparentBox({
    super.key,
    required this.callback,
    required this.readOnly,
    this.padding,
    this.initialValue = '',
    this.hint = 'Comentário...',
    this.minLines = 4,
    this.filled = false,
    this.borderColor = '#DDDEE4',
    this.readOnlyWithoutTextField = true,
    this.debounceMilliseconds = 2000,
  });

  final Function(String value)? callback;
  final EdgeInsets? padding;
  final String initialValue;
  final String hint;
  final int minLines;
  final int debounceMilliseconds;
  final bool filled;
  final bool readOnly;
  final bool readOnlyWithoutTextField;
  final String? borderColor;

  @override
  // ignore: library_private_types_in_public_api
  _CommentComponentState createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  late TextEditingController _controller;
  late bool _emptyText;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _emptyText = widget.initialValue == '';

    if (widget.initialValue != '') {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasBorder = widget.borderColor != null;
    final InputBorder border = OutlineInputBorder(
      gapPadding: 0.0,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: hasBorder ? HexColor('${widget.borderColor}') : const Color(0xFF000000),
        width: hasBorder ? 1 : 0,
        style: hasBorder ? BorderStyle.solid : BorderStyle.none,
      ),
    );

    return !(widget.readOnly && widget.readOnlyWithoutTextField)
        ? Container(
            padding: widget.padding ?? EdgeInsets.zero,
            child: TextField(
              textInputAction: TextInputAction.done,
              minLines: widget.minLines,
              enableSuggestions: true,
              controller: _controller,
              readOnly: widget.readOnly,
              maxLines: 5,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#3C3F4C'),
                  fontSize: 14.0,
                  fontFamily: 'Nunito',
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: widget.hint,
                fillColor: HexColor('#F2F2F2'),
                filled: widget.filled,
                focusedBorder: border,
                border: border,
                hintStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    color: widget.readOnly ? HexColor('#B7B9C7') : HexColor('#6A6F86'),
                    fontSize: 14.0,
                    fontFamily: 'Nunito',
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              onChanged: (String value) {
                if (debounce?.isActive ?? false) debounce!.cancel();

                debounce = Timer(Duration(milliseconds: widget.debounceMilliseconds), () {
                  if (widget.callback != null) widget.callback!(value);
                });
              },
            ),
          )
        : Text(
            !_emptyText ? widget.initialValue : 'Nenhum comentário foi adicionado',
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                fontStyle: _emptyText ? FontStyle.italic : FontStyle.normal,
                color: _emptyText ? HexColor('#B7B9C7') : HexColor('#3C3F4C'),
                fontSize: 14.0,
                fontFamily: 'Nunito',
              ),
            ),
          );
  }
}
