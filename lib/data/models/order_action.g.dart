// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAction _$OrderActionFromJson(Map<String, dynamic> json) => OrderAction(
      action: $enumDecodeNullable(_$ActionEnumMap, json['action']),
      resource: json['resource'] == null
          ? null
          : CreateResource.fromJson(json['resource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderActionToJson(OrderAction instance) =>
    <String, dynamic>{
      'action': _$ActionEnumMap[instance.action],
      'resource': instance.resource?.toJson(),
    };

const _$ActionEnumMap = {
  Action.Start: 'Start',
  Action.Cancel: 'Cancel',
  Action.Delivery: 'Delivery',
  Action.Receive: 'Receive',
  Action.Revision: 'Revision',
};
