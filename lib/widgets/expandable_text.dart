import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String headText; // Head Text that will appear when minimized
  late String
      tailText; // Additional Text that will be added to headText when expanded

  bool isHiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      // need to be expanded
      headText = widget.text.substring(0, textHeight.toInt());
      tailText = widget.text.substring(textHeight.toInt(), widget.text.length);
    } else {
      // do need to be expanded
      headText = widget.text;
      tailText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tailText == ""
          ? SmallText(text: widget.text)
          : Column(
              children: [
                isHiddenText
                    ? SmallText(
                        text: headText + "...",
                        size: Dimensions.dimen16,
                        color: AppColors.paraColor,
                        height: 1.8)
                    : SmallText(
                        text: widget.text,
                        size: Dimensions.dimen16,
                        color: AppColors.paraColor,
                        height: 1.8),
                SizedBox(height: Dimensions.dimen10 / 2),
                InkWell(
                  onTap: () {
                    setState(() {
                      isHiddenText = !isHiddenText;
                    });
                  },
                  child: Row(
                      children: isHiddenText
                          ? [
                              SmallText(
                                  text: "Show more",
                                  color: AppColors.mainColor,
                                  size: Dimensions.dimen16),
                              Icon(Icons.arrow_drop_down,
                                  color: AppColors.mainColor,
                                  size: Dimensions.dimen16),
                            ]
                          : [
                              SmallText(
                                  text: "Show less",
                                  color: AppColors.mainColor,
                                  size: Dimensions.dimen16),
                              Icon(Icons.arrow_drop_up,
                                  color: AppColors.mainColor,
                                  size: Dimensions.dimen16),
                            ]),
                ),
              ],
            ),
    );
  }
}
