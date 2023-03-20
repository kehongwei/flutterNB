import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = "assets/image/empty_cart.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Image.asset(
            imgPath,
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.height * 0.22,
          ),
          //SizedBox(height: MediaQuery.of(context).size.height*0.33,),
          Text(
            text,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.0175,
                color: Theme.of(context).disabledColor),
          )
        ],
      ),
    );
  }
}
