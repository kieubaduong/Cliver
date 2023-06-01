import 'package:json_annotation/json_annotation.dart';
import 'package:cliver_mobile/data/models/user.dart';

import 'category.dart';
import 'sub_category.dart';

part 'service_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceRequest {
  int? id;
  String? description;
  User? user;
  Category? category;
  int? categoryId;
  int? subcategoryId;

  ServiceRequest(
      {this.id,
      this.description,
      this.user,
      this.category,
      this.categoryId,
      this.subcategoryId,
      this.subcategory,
      this.tags,
      this.budget,
      this.deadline,
      this.doneAt});

  SubCategory? subcategory;
  List<String>? tags;
  int? budget;
  DateTime? deadline;
  DateTime? doneAt;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestToJson(this);
}
