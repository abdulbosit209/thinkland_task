import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'card_model.g.dart';

@immutable
@JsonSerializable()
class CardModel extends Equatable {
  CardModel({
    this.cardNumber = '',
    this.validThru = '',
    String? id,
    this.cardName,
    this.backGroundImage,
    this.blurAmount,
    this.gradient,
  }) : id = id ?? const Uuid().v4();

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  final String id;
  final String? cardName;
  final String cardNumber;
  final String validThru;
  final List<int>? backGroundImage;
  final double? blurAmount;
  final GradientModel? gradient;

  CardModel copyWith({
    String? id,
    String? cardName,
    String? cardNumber,
    String? validThru,
    List<int>? backGroundImage,
    double? blurAmount,
    GradientModel? gradient,
  }) {
    return CardModel(
      id: id ?? this.id,
      cardName: cardName ?? this.cardName,
      cardNumber: cardNumber ?? this.cardNumber,
      validThru: validThru ?? this.validThru,
      backGroundImage: backGroundImage ?? this.backGroundImage,
      blurAmount: blurAmount ?? this.blurAmount,
      gradient: gradient ?? this.gradient,
    );
  }

  Map<String, dynamic> toJson() => _$CardModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    cardName,
    cardNumber,
    validThru,
    backGroundImage,
    blurAmount,
    gradient,
  ];

}

@JsonSerializable()
class GradientModel extends Equatable {
  const GradientModel({required this.colors});

  factory GradientModel.fromJson(Map<String, dynamic> json) =>
      _$GradientModelFromJson(json);

  final List<int> colors;

  Map<String, dynamic> toJson() => _$GradientModelToJson(this);

  @override
  List<Object> get props => [colors];

  GradientModel copyWith({List<int>? colors}) {
    return GradientModel(colors: colors ?? this.colors);
  }
}
