import 'package:dust_app/utils/data_utils.dart';
import 'package:flutter/material.dart';

import '../model/state_model.dart';
import '../model/status_model.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status;
  final StateModel state;
  final String region;
  final DateTime dateTime;

  const MainAppBar({
    required this.region,
    required this.state,
    required this.status,
    required this.dateTime,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      backgroundColor: status.primaryColor,
      pinned: true,
      title: Text(
          '$region ${DataUtils.getTimeFromDateTime(dateTime: dateTime)}'
      ),
      centerTitle: true,
      expandedHeight: 700,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  region,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: state.dataTime),
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  status.comment,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
