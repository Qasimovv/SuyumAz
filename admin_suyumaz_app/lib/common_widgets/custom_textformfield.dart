import 'package:flutter/material.dart';

// Custom Text field component to be used
// for anytype of textfield
class CustomTextField extends StatefulWidget {
  final Function validatorFunction;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final TextEditingController controller;
  final Function onSaved;
  final Function onTap;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String labelText;
  final String hintText;
  final TextStyle textStyle;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextInputType textInputType;
  final bool obscureText;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onFieldSubmit;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final int maxLines;
  final int maxLength;
  final bool readOnly;
  final TextInputType keyboardType;
  final String countterText;


  CustomTextField({this.onSaved,
    @required this.onTap,

    this.controller,
    this.padding,
    this.contentPadding,
    this.prefixIcon,
    this.textStyle,
    this.labelText,
    this.hintStyle,
    this.hintText,
    this.labelStyle,
    this.suffixIcon,
    this.textInputType,
    this.obscureText = false,
    this.textAlign,
    this.validatorFunction,
    this.onFieldSubmit,
    this.focusNode,
    this.textInputAction,
    this.maxLines = 1,
    this.autoFocus = false,
    this.readOnly = false,
    this.maxLength,
    this.keyboardType,
    this.countterText=""
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        color: Color(0xffFBFBFF),
        child: TextFormField(
          onSaved: widget.onSaved,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          textAlign: widget.textAlign ?? TextAlign.start,
          style: widget.textStyle,
          obscureText: widget.obscureText,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmit,
          validator: widget.validatorFunction,
          keyboardType: widget.keyboardType,
          controller: widget.controller,


          cursorColor: Theme
              .of(context)
              .primaryColor,
          decoration: InputDecoration(

            contentPadding: widget.contentPadding,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            labelStyle: widget.labelStyle,
            counterText: widget.countterText,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)),


          ),
        ),
      ),
    );
  }
}
