// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['id'] as int?,
      balance: json['balance'] as int?,
      netIncome: json['netIncome'] as int?,
      withdrawn: json['withdrawn'] as int?,
      usedForPurchases: json['usedForPurchases'] as int?,
      pendingClearance: json['pendingClearance'] as int?,
      availableForWithdrawal: json['availableForWithdrawal'] as int?,
      expectedEarnings: json['expectedEarnings'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'netIncome': instance.netIncome,
      'withdrawn': instance.withdrawn,
      'usedForPurchases': instance.usedForPurchases,
      'pendingClearance': instance.pendingClearance,
      'availableForWithdrawal': instance.availableForWithdrawal,
      'expectedEarnings': instance.expectedEarnings,
      'user': instance.user?.toJson(),
    };
