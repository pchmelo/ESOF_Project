import 'package:esof_project/app/controllers/productControllers.dart';
import 'package:esof_project/app/shared/loading.dart';
import 'package:esof_project/app/views/extra_pages/product/product.view.dart';
import 'package:flutter/material.dart';
import '../../../controllers/notificationController.dart';
import '../../../models/notication.model.dart';
import '../../../models/product.model.dart';
import '../../../models/validity.model.dart';

class NotificationsList extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsList> {
  late Future<Map<Validity, NotificationModel>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture =
        NotificationController().getAllNotificationsFiltered();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<Map<Validity, NotificationModel>>(
      future: _notificationsFuture,
      builder: (BuildContext context,
          AsyncSnapshot<Map<Validity, NotificationModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<NotificationModel> notifications =
              snapshot.data!.values.toList();
          List<Validity> validities = snapshot.data!.keys.toList();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              NotificationModel notification = notifications[index];
              Validity validity = validities[index];
              return Padding(
                padding: EdgeInsets.all(screenWidth * 0.02), // Adjust as needed
                child: Container(
                  height: screenHeight * 0.1, // Adjust as needed
                  child: ListTile(
                    leading: Icon(Icons.notifications,
                        color: Colors.blue,
                        size: screenWidth * 0.06), // Adjust as needed
                    title: Text(
                      validity.name,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05, // Adjust as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity: ${validity.quantity.toString()}',
                          style: TextStyle(
                              fontSize: screenWidth * 0.04), // Adjust as needed
                        ),
                        Text(
                          'Expiration Date: ${validity.day}/${validity.month}/${validity.year}',
                          style: TextStyle(
                              fontSize: screenWidth * 0.04), // Adjust as needed
                        ),
                        Text(
                          'Notification Time: ${notification.time} ${notification.unitTime}',
                          style: TextStyle(
                              fontSize: screenWidth * 0.04), // Adjust as needed
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: screenWidth * 0.06), // Adjust as needed
                      onPressed: () async {
                        ProductControllers productControllers =
                            ProductControllers();
                        Product product = await productControllers
                            .getProductById(validity.productId);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProducDetailsPage(
                                      product: product,
                                      controller:
                                          ProductControllers().EditProduct,
                                    )));
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
