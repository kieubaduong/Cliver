import 'package:cliver_mobile/data/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int? id;
  String? name;
  String? icon;
  List<SubCategory>? subcategories;

  Category({
    this.id,
    this.name,
    this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
