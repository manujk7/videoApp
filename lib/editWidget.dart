import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'AppColor.dart';
import 'AppConstant.dart';

class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var maxLine = 1;
  var minLine = 1;
  Function validator;
  TextEditingController mController;
  TextInputType keyboardType;
  VoidCallback onPressed;
  var hintText;
  var labelText;
  Function onSubmitted;
  TextInputAction textInputAction;
  List<TextInputFormatter> inputFormatter;
  FocusNode focusNode;
  String type;
  TextAlign textAlign;
  bool autoValidate = false;
  Function onChanged;

  EditText(
      {var this.fontSize = textSizeMedium,
      var this.textColor = color_text_secondary,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.isSecure = false,
      var this.mController,
      var this.maxLine = 1,
      var this.minLine = 1,
      this.validator,
      this.keyboardType,
      this.hintText,
      this.labelText,
      this.textInputAction,
      this.inputFormatter,
      this.focusNode,
      this.type,
      this.onSubmitted,
      this.onChanged,
      this.textAlign = TextAlign.start,
      this.autoValidate});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword,
        controller: widget.mController,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatter,
        textCapitalization: TextCapitalization.none,
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          isDense: true,
          hintStyle: TextStyle(fontSize: textSizeSMedium, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1.2, style: BorderStyle.none, color: colorBorderGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1.2, style: BorderStyle.solid, color: colorBorderGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1.2, style: BorderStyle.solid, color: colorPrimary),
          ),
          contentPadding: EdgeInsets.all(0.0),
          prefixIcon: new IconButton(
            icon: new Icon(
              Icons.email,
              color: Colors.black,
            ),
            onPressed: null,
            color: Colors.black,
          ),
        ),
        style: TextStyle(fontSize: textSizeSMedium, color: Colors.black),
        validator: widget.validator,
      );
    } else {
      return TextFormField(
        style: TextStyle(
            fontSize: textSizeMedium,
            fontFamily: fontRegular,
            color: Colors.black),
        obscureText: widget.isPassword,
        controller: widget.mController,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatter,
        focusNode: widget.focusNode,
        textAlign: widget.textAlign,
        minLines: widget.minLine,
        onFieldSubmitted: widget.onSubmitted,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.hintText,
          isDense: true,
          hintStyle: TextStyle(fontSize: textSizeSMedium, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1.2, style: BorderStyle.none, color: colorBorderGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1.2, style: BorderStyle.solid, color: colorBorderGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1.2, style: BorderStyle.solid, color: colorPrimary),
          ),
          prefixIcon: new IconButton(
            onPressed: () {
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            icon: Icon(
                !widget.isPassword
                    ? Icons.visibility_sharp
                    : Icons.visibility_off_sharp,
                color: Colors.black),
          ),
          contentPadding: EdgeInsets.all(4.0),
        ),
        validator: widget.validator,
      );
    }
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}
