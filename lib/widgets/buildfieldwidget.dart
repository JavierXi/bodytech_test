import 'package:flutter/material.dart';

class BuildFieldWidget extends StatefulWidget {
  final dynamic controller;
  final bool obscureText;
  final dynamic capitalization;
  final dynamic suffixIcon;
  final dynamic hintText;
  final dynamic hintColor;
  final dynamic validator;
  final dynamic keyboardType;
  final dynamic textInputAction;

  const BuildFieldWidget({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.capitalization,
    required this.suffixIcon,
    required this.hintText,
    required this.hintColor,
    required this.validator,
    required this.keyboardType,
    required this.textInputAction,
  }) : super(key: key);

  @override
  _BuildFieldWidgetState createState() => _BuildFieldWidgetState();
}

class _BuildFieldWidgetState extends State<BuildFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return (buildField());
  }

  Widget buildField() => TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        textCapitalization: widget.capitalization,
        decoration: InputDecoration(
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade900,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            color: widget.hintColor,
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.red,
          ),
          suffixIcon: widget.suffixIcon,
          border: const OutlineInputBorder(),
        ),
        style: TextStyle(
          color: Colors.grey.shade900,
          fontSize: 15,
        ),
        cursorColor: Colors.grey.shade900,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
      );
}
