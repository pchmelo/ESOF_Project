class Validity {
  final String uid;
  final String productId;
  final int quantity;
  late int day;
  late int month;
  late int year;

  Validity(this.productId, this.uid,
      {this.quantity = 0, int? day, int? month, int? year}) {
    var now = DateTime.now();
    this.day = day ?? now.day;
    this.month = month ?? now.month;
    this.year = year ?? now.year;
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'productId': productId,
      'quantity': quantity,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory Validity.fromJson(Map<String, dynamic> json) {
    return Validity(
      json['uid'],
      json['productId'],
      quantity: json['quantity'],
      day: json['day'],
      month: json['month'],
      year: json['year'],
    );
  }
}
