import 'package:dust_app/model/status_model.dart';
import 'package:flutter/material.dart';

final statusLevel = [
  //최고등급
  StatusModel(
      level: 0,
      label: '良い - Good',
      primaryColor: Color(0xFF2196F3),
      darkColor: Color(0xFF0069C0),
      lightColor: Color(0xFF6EC6FF),
      detailFontColor: Colors.black,
      imagePath: 'asset/img/best.png',
      comment: '通常の活動が可能!',
      minFineDust: 0,
      minUltraFineDust: 0,
      minNO2: 0,
      minCO: 0,
  ),
  StatusModel(
      level: 1,
      label: '並',
      primaryColor: Color(0xFF03a9f4),
      darkColor: Color(0xFF007ac1),
      lightColor: Color(0xFF67daff),
      detailFontColor: Colors.black,
      imagePath: 'asset/img/good.png',
      comment: '特に敏感な者は、長時間又は激しい屋外活動の減少を検討!',
      minFineDust: 16,
      minUltraFineDust: 9,
      minNO2: 0.02,
      minCO: 1,
  ),
/*  StatusModel(
    level: 2,
    label: '양호',
    primaryColor: Color(0xFF00bcd4),
    darkColor: Color(0xFF008ba3),
    lightColor: Color(0xFF62efff),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/ok.png',
    comment: '밖에 놀기나쁘지않음',
    minFineDust: 31,
    minUltraFineDust: 16,
    minNO2: 0.03,
    minCO: 2,
  ),
    StatusModel(
    level: 3,
    label: '보통',
    primaryColor: Color(0xFF009688),
    darkColor: Color(0xFF00675b),
    lightColor: Color(0xFF52c7b8),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/mediocre.png',
    comment: '그냥 저냥',
    minFineDust: 41,
    minUltraFineDust: 21,
    minNO2: 0.05,
    minCO: 5.5,
  ),*/
  StatusModel(
    level: 3,
    label: '敏感なグループにとっては健康に良くない',
    primaryColor: Color(0xFFffc107),
    darkColor: Color(0xFFc79100),
    lightColor: Color(0xFFfff350),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/bad.png',
    comment: '공心臓・肺疾患患者、高齢者及び子供は、長時間又は激しい屋外活動を減少',
    minFineDust: 51,
    minUltraFineDust: 26,
    minNO2: 0.06,
    minCO: 9,
  ),
  StatusModel(
    level: 4,
    label: '健康に良くない ',
    primaryColor: Color(0xFFff9800),
    darkColor: Color(0xFFc66900),
    lightColor: Color(0xFFffc947),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/very_bed.png',
    comment: '上記の者は、長時間又は激しい屋外活動を中止すべての者は、長時間又は激しい屋外活動を減少',
    minFineDust: 76,
    minUltraFineDust: 38,
    minNO2: 0.13,
    minCO: 12,
  ),
  StatusModel(
    level: 5,
    label: '極めて健康に良くない',
    primaryColor: Color(0xFFff4336),
    darkColor: Color(0xFFba000d),
    lightColor: Color(0xFFff7961),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/worse.png',
    comment: 'すべての者は、長時間又は激しい屋外活動を中止',
    minFineDust: 101,
    minUltraFineDust: 51,
    minNO2: 0.2,
    minCO: 15,
  ),
  StatusModel(
    level: 6,
    label: '危険',
    primaryColor: Color(0xFF212121),
    darkColor: Color(0xFF000000),
    lightColor: Color(0xFF484848),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/worst.png',
    comment: 'すべての者は、屋外活動を中止',
    minFineDust: 151,
    minUltraFineDust: 76,
    minNO2: 1.1,
    minCO: 32,
  ),
];
