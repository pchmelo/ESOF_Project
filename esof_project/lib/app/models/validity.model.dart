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
}
