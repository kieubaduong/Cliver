import 'package:json_annotation/json_annotation.dart';

part 'create_resource.g.dart';

@JsonSerializable()
class CreateResource {
  String? name;
  int? size;
  String? url;
  CreateResource({
    this.name,
    this.size,
    this.url,
  });

  factory CreateResource.fromJson(Map<String, dynamic> json) =>
      _$CreateResourceFromJson(json);

  Map<String, dynamic> toJson() => _$CreateResourceToJson(this);
}
