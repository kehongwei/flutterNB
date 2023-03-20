import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController _textEditingController;
  final String _hintText;
  final IconData _iconData;
  int maxLines;

  AppTextField(
      {required String hintText,
      IconData iconData =
          Icons.tag_faces_rounded,
      this.maxLines = 1,
      required TextEditingController textEditingController,
      Key? key})
      : _hintText = hintText,
        _iconData = iconData,
        _textEditingController = textEditingController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.dimen20, right: Dimensions.dimen20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.dimen15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2)),
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        obscureText: (_hintText == "Password") ? true : false,
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: _hintText,
          prefixIcon: Icon(
            _iconData,
            color: AppColors.yellowColor,
          ),
          // focused Border,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.dimen15),
              borderSide:
                  const BorderSide(width: 1.0, color: Colors.cyanAccent)),
          // enabled Border,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.dimen15),
              borderSide:
                  const BorderSide(width: 1.0, color: Colors.cyanAccent)),
        ),
      ),
    );
  }
}
