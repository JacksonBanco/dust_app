import 'package:dust_app/const/status_level.dart';
import 'package:dust_app/model/state_model.dart';
import 'package:dust_app/model/status_model.dart';

class DataUtils {
  static String getTimeFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year} / ${dateTime.month} / ${dateTime.day}'
        '${getTimeFormat(dateTime.hour)}/ ${getTimeFormat(dateTime.minute)}';
  }

  static String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }

  static String getUnitFromItem({
    required ItemCode itemCode,
  }) {
    switch(itemCode){
      case ItemCode.PM10:
        return "PM10";

      case ItemCode.PM25:
        return 'PM2.5';

      default:
        return 'ppm';
    }
  }

  static String getItemCodeKRString({
    required ItemCode itemCode,
  }) {
    switch(itemCode){
      case ItemCode.PM10:
        return 'PM10(微細 ほこり)';

      case ItemCode.PM25:
        return '㏘2.5';

      case ItemCode.NO2:
        return '二酸化硫黄(SO2)';

      case ItemCode.CO:
        return '一酸化窒素(NO)';
    }
  }

  static StatusModel getStatusFromItemCodeAndValue({
    required double value,
    required ItemCode itemCode,
    }) {
    return statusLevel.where(
            (status) {
              if(itemCode == ItemCode.PM10){
                return status.minFineDust < value;
              }else if(itemCode == ItemCode.PM25){
                return status.minUltraFineDust < value;
              }else if(itemCode == ItemCode.CO){
                return status.minCO < value;
              }
              else if(itemCode == ItemCode.NO2){
                return status.minNO2 < value;
              }else{
                throw Exception('알수없는 정보입니다');
              }
            },
    ).last;
  }
}
