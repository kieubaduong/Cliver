import 'package:json_annotation/json_annotation.dart';

part 'save_service.g.dart';

@JsonSerializable()
class SaveService {
  int? id;
  String? name;
  String? userId;
  String? createdAt;
  int? serviceCount;
  int? sellerCount;
  bool? isSaved;
  String? thumnail;

  SaveService(
      {this.id,
        this.name,
        this.userId,
        this.createdAt,
        this.serviceCount,
        this.sellerCount,
        this.isSaved,
        this.thumnail
      });

  factory SaveService.fromJson(Map<String, dynamic> json) => _$SaveServiceFromJson(json);
  Map<String, dynamic> toJson() => _$SaveServiceToJson(this);
}