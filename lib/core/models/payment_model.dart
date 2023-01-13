import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'payment_model.g.dart';

@HiveType(typeId: HiveTypesIds.paymentTypeId)
class Payment {
  @HiveField(0, defaultValue: false)
  bool payment;

  @HiveField(1, defaultValue: 0)
  int paymentDate;

  @HiveField(2, defaultValue: 0)
  int paymentExpire;

  Payment({
    required this.payment,
    required this.paymentDate,
    required this.paymentExpire,
  });

  factory Payment.none() => Payment(
        payment: false,
        paymentDate: 0,
        paymentExpire: 0,
      );

  Payment copyWith({
    bool? payment,
    int? paymentDate,
    int? paymentExpire,
  }) {
    return Payment(
      payment: payment ?? this.payment,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentExpire: paymentExpire ?? this.paymentExpire,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payment': payment,
      'paymentDate': paymentDate,
      'paymentExpire': paymentExpire,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      payment: map['payment'] as bool,
      paymentDate: map['paymentDate'] as int,
      paymentExpire: map['paymentExpire'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) => Payment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Payment(payment: $payment, paymentDate: $paymentDate, paymentExpire: $paymentExpire)';

  @override
  bool operator ==(covariant Payment other) {
    if (identical(this, other)) return true;

    return other.payment == payment && other.paymentDate == paymentDate && other.paymentExpire == paymentExpire;
  }

  @override
  int get hashCode => payment.hashCode ^ paymentDate.hashCode ^ paymentExpire.hashCode;
}
