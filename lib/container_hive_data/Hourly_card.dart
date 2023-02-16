import 'package:dust_app/component/main_card.dart';
import 'package:dust_app/model/state_model.dart';
import 'package:dust_app/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:dust_app/component/card_title.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String region;
  final ItemCode itemCode;

  const HourlyCard({
      required this.darkColor,
      required this.lightColor,
      required this.region,
      required this.itemCode,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 ${DataUtils.getItemCodeKRString(itemCode:  itemCode)}',
            backgroundColor: darkColor,
          ),
          ValueListenableBuilder<Box>(
              valueListenable: Hive.box<StateModel>(itemCode.name).listenable(),
              builder: (context, box, widget) =>
                 Column(
                  children: box.values
                    .toList()
                    .reversed
                    .map(
                      (state) => renderRow(states: state),
                  ).toList(),
                ),
          ),
        ],
      ),
    );
  }

  Widget renderRow({required StateModel states}) {
    final status = DataUtils.getStatusFromItemCodeAndValue(
      value: states.getLevelFromRegion(region),
      itemCode: states.itemCode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text('${states.dataTime.hour}시'),
          ),
          Expanded(
            child: Image.asset(
              status.imagePath,
              height: 20.0,
            ),
          ),
          Expanded(
            child: Text(
              status.label,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
