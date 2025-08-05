import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'card_model.g.dart';

@immutable
@JsonSerializable()
class CardModel extends Equatable {
  CardModel({
    required this.cardNumber,
    required this.validThru,
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
  final int cardNumber;
  final int validThru;
  final List<int>? backGroundImage;
  final double? blurAmount;
  final Gradient? gradient;

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

  CardModel copyWith({
    String? id,
    int? cardNumber,
    String? cardName,
    int? validThru,
    List<int>? backGroundImage,
    double? blurAmount,
    Gradient? gradient,
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

  @override
  bool get stringify => true;
}

@JsonSerializable()
class Gradient extends Equatable {
  const Gradient({
    required this.begin,
    required this.end,
  });

  factory Gradient.fromJson(Map<String, dynamic> json) =>
      _$GradientFromJson(json);

  final int begin;
  final int end;

  Map<String, dynamic> toJson() => _$GradientToJson(this);

  @override
  List<Object> get props => [begin, end];

  Gradient copyWith({int? begin, int? end}) {
    return Gradient(
      begin: begin ?? this.begin,
      end: end ?? this.end,
    );
  }

  @override
  bool get stringify => true;
}
