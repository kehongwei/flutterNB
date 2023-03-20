import 'package:rive/rive.dart';

class RiveAsset {
  final String artBoard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artBoard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [

  RiveAsset("assets/rive/icons.riv",
      artBoard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Home"),
  RiveAsset("assets/rive/icons.riv",
      artBoard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"),
  RiveAsset("assets/rive/icons.riv",
      artBoard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "History"),
  RiveAsset("assets/rive/icons.riv",
      artBoard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
];
