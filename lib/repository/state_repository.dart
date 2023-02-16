import 'package:dio/dio.dart';
import 'package:dust_app/model/state_model.dart';

import '../const/data.dart';

class StateRepository{
  static Future<List<StateModel>> fetchData({
  required ItemCode itemCode,
}) async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureList',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'numOfRows': 30,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    return response.data['response']['body']['items']
      .map<StateModel>(
        (item) => StateModel.fromJson(json: item),
      ).toList;
  }
}
