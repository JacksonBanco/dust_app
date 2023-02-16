import 'package:dust_app/component/card_title.dart';
import 'package:dust_app/component/main_card.dart';
import 'package:dust_app/component/main_state.dart';
import 'package:dust_app/model/state_model.dart';
import 'package:dust_app/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    required this.region,
    required this.darkColor,
    required this.lightColor,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    children: ItemCode.values
                        .map(
                        (ItemCode itemCode) =>
                        ValueListenableBuilder<Box>(
                          valueListenable: Hive.box<StateModel>(itemCode.name).listenable(),
                          builder: (context, box, widget) {
                            final state = (box.values.toList().last as StateModel);
                            final status = DataUtils.getStatusFromItemCodeAndValue(
                              value: state.getLevelFromRegion(region),
                              itemCode: itemCode,
                            );

                            return MainState(
                              width: constraint.maxWidth / 3,
                              category: DataUtils.getItemCodeKRString(
                                itemCode: itemCode,
                              ),
                              imgPath: status.imagePath,
                              level: status.label,
                              state:
                              '${state.getLevelFromRegion(
                                region,
                              )}${DataUtils.getUnitFromItem(
                                  itemCode: itemCode
                              )}',
                            );
                          },
                        ),
                   ).toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
