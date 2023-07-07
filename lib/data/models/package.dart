import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'package.g.dart';

@JsonSerializable()
class Package {
  late int? id;
  late String? name;
  late String? description;
  late int? postId;
  late SimplePost? post;
  late int? deliveryDays;
  late int? numberOfRevisions;
  late int? price;
  late String? type;

  Package({
    this.id,
    this.name,
    this.description,
    this.postId,
    this.post,
    this.deliveryDays,
    this.numberOfRevisions,
    this.price,
    this.type,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
