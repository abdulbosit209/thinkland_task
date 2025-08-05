// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
  cardNumber: (json['cardNumber'] as num).toInt(),
  validThru: (json['validThru'] as num).toInt(),
  id: json['id'] as String?,
  cardName: json['cardName'] as String?,
  backGroundImage: (json['backGroundImage'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  blurAmount: (json['blurAmount'] as num?)?.toDouble(),
  gradient: json['gradient'] == null
      ? null
      : Gradient.fromJson(json['gradient'] as Map<String, dynamic>),
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

Gradient _$GradientFromJson(Map<String, dynamic> json) => Gradient(
  begin: (json['begin'] as num).toInt(),
  end: (json['end'] as num).toInt(),
);

Map<String, dynamic> _$GradientToJson(Gradient instance) => <String, dynamic>{
  'begin': instance.begin,
  'end': instance.end,
};
