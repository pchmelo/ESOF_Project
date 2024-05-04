class NotificationModel {
  String uid;
  String productId;
  String unitTime;
  int time;

  NotificationModel(
      {required this.uid,
      required this.productId,
      required this.unitTime,
      required this.time});

  NotificationModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        productId = json['productId'],
        unitTime = json['unitTime'],
        time = json['time'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = uid;
    data['productId'] = productId;
    data['unitTime'] = unitTime;
    data['time'] = time;
    return data;
  }
}
