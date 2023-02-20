import 'package:flutter/material.dart';


class StatusModel{
  //단계
  final int level;

  //단계 이름
  final String label;

  //메인 색상
  final Color primaryColor;

  //어두운 색상
  final Color darkColor;

  //밝은 색상
  final Color lightColor;

  //폰트 색상
  final Color detailFontColor;

  //이모티콘 이미지
  final String imagePath;

  //코멘트
  final String comment;

  //미세먼지 최소치
  final double minFineDust;

  //초미세먼지 최소치
  final double minUltraFineDust;

  //이산화질소최소치
  final double minNO2;

  //일산화탄소최소치
  final double minCO;

  StatusModel({
    //단계
    required this.level,
    //단계 이름
    required this.label,
    //메인 색상
    required this.primaryColor,
    //어두운 색상
    required this.darkColor,
    //밝은 색상
    required this.lightColor,
    //폰트 색상
    required this.detailFontColor,
    //이모티콘 이미지
    required this.imagePath,
    //코멘트
    required this.comment,
    //미세먼지 최소치
    required this.minFineDust,
    //초미세먼지 최소치
    required this.minUltraFineDust,
    //이산화질소최소치
    required this.minNO2,
    //일산화탄소최소치
    required this.minCO,
  });

}