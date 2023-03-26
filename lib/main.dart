import 'package:dust_app/model/state_model.dart';
import 'package:dust_app/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  //어뎁터 등록 담부터는 신경안써도됨
  Hive.registerAdapter<StateModel>(StateModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());


  for(ItemCode itemCode in ItemCode.values){
    await Hive.openBox<StateModel>(itemCode.name);
  }
  
  runApp(
      MaterialApp(
        theme: ThemeData(
          fontFamily: 'sunflower',
        ),
        home: HomeScreen(),
  ));
}
