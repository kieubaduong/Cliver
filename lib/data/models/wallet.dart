import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'wallet.g.dart';

@JsonSerializable(explicitToJson: true)
class Wallet {
  int? id;
  int? balance;
  int? netIncome;
  int? withdrawn;
  int? usedForPurchases;
  int? pendingClearance;
  int? availableForWithdrawal;
  int? expectedEarnings;
  User? user;

  Wallet({
    this.id,
    this.balance,
    this.netIncome,
    this.withdrawn,
    this.usedForPurchases,
    this.pendingClearance,
    this.availableForWithdrawal,
    this.expectedEarnings,
    this.user,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
