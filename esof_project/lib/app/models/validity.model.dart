import 'package:flutter/cupertino.dart';

class Validity {
  final String name;
  final String uid;
  final String productId;
  final int quantity;
  late int day;
  late int month;
  late int year;

  Validity()
      : name = 'default',
        uid = 'default',
        productId = 'default',
        quantity = 0 {
    var now = DateTime.now();
    this.day = now.day;
    this.month = now.month;
    this.year = now.year;
  }

  Validity.withValues(this.name, this.productId, this.uid,
      {this.quantity = 0, int? day, int? month, int? year}) {
    var now = DateTime.now();
    this.day = day ?? now.day;
    this.month = month ?? now.month;
    this.year = year ?? now.year;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'productId': productId,
      'quantity': quantity,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory Validity.fromJson(Map<String, dynamic> json) {
    return Validity.withValues(
      json['name'],
      json['productId'],
      json['uid'],
      quantity: json['quantity'],
      day: json['day'],
      month: json['month'],
      year: json['year'],
    );
  }

  @override
  bool operator ==(Object other) {
    print('== operator called');
    if (identical(this, other)) return true;

    return other is Validity &&
        other.name == name &&
        other.uid == uid &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.day == day &&
        other.month == month &&
        other.year == year;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        productId.hashCode ^
        quantity.hashCode ^
        day.hashCode ^
        month.hashCode ^
        year.hashCode;
  }
}

class ValidityNotifier extends ValueNotifier<Validity> {
  ValidityNotifier(Validity value) : super(value);

  void updateValue(Validity newValue) {
    print('updateValue called');

    value = Validity.withValues(
      newValue.name,
      newValue.productId,
      newValue.uid,
      quantity: newValue.quantity,
      day: newValue.day,
      month: newValue.month,
      year: newValue.year,
    );
  }
}
