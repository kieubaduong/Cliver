// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateResource _$CreateResourceFromJson(Map<String, dynamic> json) =>
    CreateResource(
      name: json['name'] as String?,
      size: json['size'] as int?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$CreateResourceToJson(CreateResource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'url': instance.url,
    };
