import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/database.dart';
import 'editProduct.widget.dart';

class ProducDetailsPage extends StatelessWidget {
  final Function controller;
  final Product product;
  const ProducDetailsPage(
      {super.key, required this.product, required this.controller});

  @override
  Widget build(BuildContext context) {
    Future<void> deleteProduct() async {
      User user = FirebaseAuth.instance.currentUser!;
      DatabaseService dbService = DatabaseService(uid: user.uid);

      if (product.id != null) {
        await dbService.deleteProductById(product.id!);
      } else {
        // Handle the case where product.id is null
        print('Error: product.id is null');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Info'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem<int>(
                value: 0,
                child: Text('Edit'),
              onTap: ()async{
                await ProductForm(product: product, context: context)
                    .EditProductForm(controller);
                Navigator.pop(context);
              },
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Text('Delete'),
              onTap: (){
                deleteProduct();
              },
            ),
          ], onSelected: (item)=>SelectedItem(context, item),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          Container(
            height: 100,
            width: 100,
            child: Placeholder(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Center(
                    child: Text('${product.name}',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Center(
                    child: Text('Threshold: ${product.threshold}',
                      style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text('Quantity: ${product.quantity}',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                FloatingActionButton(
                    onPressed: () async {
                    },
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.amber,
                    child: const Text('IN PROGRESS')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

SelectedItem(BuildContext context, item){
  switch(item){
    case 0:
      print('Edit');
      break;
    case 1:
      Navigator.pop(context);
      break;
  }
}