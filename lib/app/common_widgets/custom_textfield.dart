import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.secureText = false,
    this.maxLines = 1,
    this.type = "text",
    this.length = 0
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  bool secureText;
  String type;
  int length;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  void onValueChange() {
    setState(() {
      widget.controller.text;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onValueChange);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          obscureText: widget.secureText,
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            counterText: widget.length == 0
                ? ""
                : widget.type != "number"
                    ? "${widget.controller.text.length}/${widget.length}"
                    : "${widget.controller.text.replaceAll(".", "").replaceAll("VND(đ)", "").trim().length}/8",
          ),
          maxLength: widget.length == 0 ? TextField.noMaxLength : widget.length,
          maxLines: widget.maxLines,
          inputFormatters: widget.type == 'number'
              ? [
                  CurrencyTextInputFormatter(
                    locale: "vi",
                    symbol: 'VND(đ)',
                  )
                ]
              : null,
          keyboardType: widget.type == 'number'
              ? TextInputType.number
              : TextInputType.multiline,
        ),
        Visibility(
          visible: widget.type == "pass",
          child: Positioned(
            right: 10,
            top: 12,
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.secureText = !widget.secureText;
                });
              },
              child: AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                duration: const Duration(milliseconds: 200),
                child: widget.secureText
                    ? const Icon(Icons.visibility_sharp)
                    : const SizedBox(
                        child: Icon(Icons.visibility_off_sharp),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
