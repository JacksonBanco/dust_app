import 'package:flutter/material.dart';

class MainState extends StatelessWidget {
  final String category;
  final String imgPath;
  final String level;
  final String state;
  final double width;

  const MainState(
      {Key? key,
      required this.category,
      required this.imgPath,
      required this.level,
      required this.state,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.black,
    );

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
          ),
          const SizedBox(height: 8.0,),
          Image.asset(
            imgPath,
            width: 50.0,
          ),
          const SizedBox(height: 8.0,),
          Text(
            level,
            style: ts,
          ),
          Text(
            state,
            style: ts,
          ),
        ],
      ),
    );
  }
}
