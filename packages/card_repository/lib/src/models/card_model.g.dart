// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
  cardNumber: json['cardNumber'] as String? ?? '',
  validThru: json['validThru'] as String? ?? '',
  id: json['id'] as String?,
  cardName: json['cardName'] as String?,
  backGroundImage: (json['backGroundImage'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  blurAmount: (json['blurAmount'] as num?)?.toDouble(),
  gradient: json['gradient'] == null
      ? null
      : GradientModel.fromJson(json['gradient'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
  'id': instance.id,
  'cardName': instance.cardName,
  'cardNumber': instance.cardNumber,
  'validThru': instance.validThru,
  'backGroundImage': instance.backGroundImage,
  'blurAmount': instance.blurAmount,
  'gradient': instance.gradient,
};

GradientModel _$GradientModelFromJson(Map<String, dynamic> json) =>
    GradientModel(
      colors: (json['colors'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$GradientModelToJson(GradientModel instance) =>
    <String, dynamic>{'colors': instance.colors};
