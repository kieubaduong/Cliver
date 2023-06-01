// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequest _$ServiceRequestFromJson(Map<String, dynamic> json) =>
    ServiceRequest(
      id: json['id'] as int?,
      description: json['description'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      categoryId: json['categoryId'] as int?,
      subcategoryId: json['subcategoryId'] as int?,
      subcategory: json['subcategory'] == null
          ? null
          : SubCategory.fromJson(json['subcategory'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      budget: json['budget'] as int?,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      doneAt: json['doneAt'] == null
          ? null
          : DateTime.parse(json['doneAt'] as String),
    );

Map<String, dynamic> _$ServiceRequestToJson(ServiceRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'user': instance.user?.toJson(),
      'category': instance.category?.toJson(),
      'categoryId': instance.categoryId,
      'subcategoryId': instance.subcategoryId,
      'subcategory': instance.subcategory?.toJson(),
      'tags': instance.tags,
      'budget': instance.budget,
      'deadline': instance.deadline?.toIso8601String(),
      'doneAt': instance.doneAt?.toIso8601String(),
    };
