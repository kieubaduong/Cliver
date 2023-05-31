import 'package:json_annotation/json_annotation.dart';

part 'sub_category.g.dart';

@JsonSerializable(explicitToJson: true)
class SubCategory {
  int? id;
  String? name;
  String? icon;

  SubCategory({
    this.id,
    this.name,
  });
  factory SubCategory.fromJson(Map<String, dynamic> json) => _$SubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
