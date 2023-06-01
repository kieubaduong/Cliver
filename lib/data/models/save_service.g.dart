// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveService _$SaveServiceFromJson(Map<String, dynamic> json) => SaveService(
      id: json['id'] as int?,
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      serviceCount: json['serviceCount'] as int?,
      sellerCount: json['sellerCount'] as int?,
      isSaved: json['isSaved'] as bool?,
      thumnail: json['thumnail'] as String?,
    );

Map<String, dynamic> _$SaveServiceToJson(SaveService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'serviceCount': instance.serviceCount,
      'sellerCount': instance.sellerCount,
      'isSaved': instance.isSaved,
      'thumnail': instance.thumnail,
    };
