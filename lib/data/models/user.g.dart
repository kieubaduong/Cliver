// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool?,
      description: json['description'] as String?,
      walletId: json['walletId'] as int?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      type: json['type'] as String?,
      isVerified: json['isVerified'] as bool?,
      isSaved: json['isSaved'] as bool?,
      ratingCount: json['ratingCount'] as int?,
      ratingAvg: (json['ratingAvg'] as num?)?.toDouble(),
      avatar: json['avatar'] as String?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'isActive': instance.isActive,
      'description': instance.description,
      'walletId': instance.walletId,
      'wallet': instance.wallet?.toJson(),
      'type': instance.type,
      'isVerified': instance.isVerified,
      'isSaved': instance.isSaved,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'avatar': instance.avatar,
      'languages': instance.languages?.map((e) => e.toJson()).toList(),
      'skills': instance.skills,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      name: json['name'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'name': instance.name,
      'level': instance.level,
    };
