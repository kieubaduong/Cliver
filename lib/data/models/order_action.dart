import 'package:json_annotation/json_annotation.dart';

import 'package:cliver_mobile/data/models/create_resource.dart';

import '../enums/action.dart';

part 'order_action.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderAction {
  Action? action;
  CreateResource? resource;
  OrderAction({
    this.action,
    this.resource,
  });

  factory OrderAction.fromJson(Map<String, dynamic> json) =>
      _$OrderActionFromJson(json);

  Map<String, dynamic> toJson() => _$OrderActionToJson(this);
}
