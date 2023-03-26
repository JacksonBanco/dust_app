import 'package:dio/dio.dart';
import 'package:dust_app/container_hive_data//Hourly_card.dart';
import 'package:dust_app/container_hive_data//category_card.dart';
import 'package:dust_app/model/state_model.dart';
import 'package:dust_app/repository/state_repository.dart';
import 'package:dust_app/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../component/main_app_bar.dart';
import '../component/main_drawer.dart';
import '../const/regions.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpanded = true;

  @override
  initState(){
    super.initState();

    //FutureBuilder를 사용하지않고 ValueListenableBuilder를 사용하기때문에
    //fetchData를 initState에 넣어서 초기화될때 실행시킨다
    fetchData();
  }

  @override
  dispose(){
    super.dispose();
  }


  Future<void> fetchData() async {
    try{
      //다중비동기 요청 병렬식
      //6개를 요청하기때문에 느린다 하지만 다중 비동기처리를 하면 동시에 다중으로 하기때문에빠르다
      final now = DateTime.now();
      final fetchTime = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
      );

      final box = Hive.box<StateModel>(ItemCode.PM10.name);

      if(box.values.isNotEmpty &&
          (box.values.last).dataTime.isAtSameMomentAs(fetchTime)){
        return;
      }

      List<Future> futures = [];

      for (ItemCode itemCode in ItemCode.values) {
        futures.add(
          //이게 요청이 될때 동시에 나가지만
            StateRepository.fetchData(
              itemCode: itemCode,
            ),
        );
      }

      //List<Future>에 퓨처값을 넣게되면 다끝날때까지 한번에 기다린다
      //요청은 동시에
      final results = await Future.wait(futures);

      //Hive에 데이터 넣기
      for (int i = 0; i < results.length; i++) {
        //실제로 itemCode를 가져오는 키 :값
        final key = ItemCode.values[i];
        //List<StateModel> 값
        final value = results[i];

        final box = Hive.box<StateModel>(key.name);

/*        //List<StateModel> 값
        box.values.toList();*/

        for (StateModel state in value) {
          box.put(state.dataTime.toString(), state);
        }
        final allKeys = box.keys.toList();

        if(allKeys.length >24){
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24);

          box.deleteAll(deleteKeys);
        }
      }
    } on DioError catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('인터넷 연결이 원활하지않습니다.'),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //최상의 위젯에서 상태관리를 하기때문에 pm10(미세먼지)가 갱신될때마다 build됨
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box<StateModel>(ItemCode.PM10.name).listenable(),
        builder: (context, box, widget) {
          if(box.values.isEmpty){
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final recentState = box.values.toList().last as StateModel;

          //미세먼지 최근 데이터의 현재 상태
          //box.value.toList().last
          final status = DataUtils.getStatusFromItemCodeAndValue(
            value: recentState.getLevelFromRegion(region),
            //위에 regin[0]선언함 그러니 지역의 첫번째 값을 가져옴
            itemCode: ItemCode.PM10,
          );

          return Scaffold(
            drawer: MainDrawer(
              darkColor: status.darkColor,
              lightColor: status.lightColor,
              selectedRegion: region,
              onRegionTap: (String region) {
                setState(() {
                  this.region = region;
                });
                Navigator.of(context).pop();
              },
            ),
            body: Container(
              color: status.primaryColor,
              child: RefreshIndicator(
                onRefresh: () async {
                  await fetchData();
                },
                child: CustomScrollView(
                  slivers: [
                    MainAppBar(
                      dateTime: recentState.dataTime,
                      state: recentState,
                      status: status,
                      region: region,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CategoryCard(
                            region: region,
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                          ),
                          const SizedBox(height: 16.0),
                          ...ItemCode.values.map((itemCode) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HourlyCard(
                                darkColor: status.darkColor,
                                lightColor: status.lightColor,
                                region: region,
                                itemCode: itemCode,
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
       }
    );
  }
}