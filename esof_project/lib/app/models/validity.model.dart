class Validity {
  final String productId;
  final int quantity;
  late int day;
  late int month;
  late int year;

  Validity(this.productId,
      {this.quantity = 0, int? day, int? month, int? year}) {
    var now = DateTime.now();
    this.day = day ?? now.day;
    this.month = month ?? now.month;
    this.year = year ?? now.year;
  }
}
