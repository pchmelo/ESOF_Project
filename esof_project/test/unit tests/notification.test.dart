import 'package:esof_project/app/models/notication.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationModel', () {
    test('NotificationModel constructor', () {
      var notification = NotificationModel(
        uid: '1',
        productId: '1',
        unitTime: 'hour',
        time: 5,
      );

      expect(notification.uid, '1');
      expect(notification.productId, '1');
      expect(notification.unitTime, 'hour');
      expect(notification.time, 5);
    });

    test('toJson', () {
      var notification = NotificationModel(
        uid: '1',
        productId: '1',
        unitTime: 'hour',
        time: 5,
      );

      expect(notification.toJson(), {
        'uid': '1',
        'productId': '1',
        'unitTime': 'hour',
        'time': 5,
      });
    });

    test('fromJson', () {
      var json = {
        'uid': '1',
        'productId': '1',
        'unitTime': 'hour',
        'time': 5,
      };

      var notification = NotificationModel.fromJson(json);

      expect(notification.uid, '1');
      expect(notification.productId, '1');
      expect(notification.unitTime, 'hour');
      expect(notification.time, 5);
    });
  });
}
