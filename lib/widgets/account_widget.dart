import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon _appIcon;
  BigText _bigText;

  AccountWidget({required AppIcon appIcon, required BigText bigText, Key? key})
      : _appIcon = appIcon,
        _bigText = bigText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(offset: const Offset(0, 5), color: Colors.grey.withOpacity(0.2), blurRadius: 1),
      //   ],
      // ),
      padding: EdgeInsets.only(
        left: Dimensions.dimen20,
        top: Dimensions.dimen10,
        bottom: Dimensions.dimen10,
      ),
      child: Row(
        children: [
          _appIcon,
          SizedBox(
            width: Dimensions.dimen20,
          ),
          Flexible(child: _bigText)
        ],
      ),
    );
  }
}
