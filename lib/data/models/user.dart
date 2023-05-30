import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  String? description;
  int? walletId;
  Wallet? wallet;
  String? type;
  bool? isVerified;
  bool? isSaved;
  double? ratingAvg;
  int? ratingCount;
  String? avatar;
  List<Language>? languages;
  List<String>? skills;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.isActive,
    this.description,
    this.walletId,
    this.wallet,
    this.type,
    this.isVerified,
    this.isSaved,
    this.ratingCount,
    this.ratingAvg,
    this.avatar,
    this.languages,
    this.skills,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Language {
  String? name;
  String? level;
  Language({this.name, this.level});

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}