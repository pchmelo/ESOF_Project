import 'dart:async';

import 'package:esof_project/app/views/main_pages/storage/productTile.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/database.dart';
import '../../../models/product.model.dart';
import 'ProductListBuilder.dart';

class ProductList extends StatefulWidget {
  ProductList({super.key, required this.handleProductTap});
  Function handleProductTap;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late User user;
  late DatabaseService _dbService;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseService(uid: user.uid);
  }

  List<Map<String, dynamic>> _allProducts = [];
  ValueNotifier<List<Map<String, dynamic>>> _foundProducts = ValueNotifier([]);

  String _searchText = '';

  void _runFilter() {
    List<Map<String, dynamic>> results = [];
    if (_searchText.isEmpty) {
      results = List.from(_allProducts);
    } else {
      results = _allProducts
          .where((product) =>
              product['name'].toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    }
    _foundProducts.value = results;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Product>>(
        stream: _dbService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            _allProducts =
                snapshot.data!.map((product) => product.toJson()).toList();
            _foundProducts.value = List.from(_allProducts);

            return Column(children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => _searchText = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              ElevatedButton(
                onPressed: _runFilter,
                child: const Text('Search'),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: _foundProducts,
                builder: (BuildContext context,
                    List<Map<String, dynamic>> value, Widget? child) {
                  return ProductListBuilder(
                      foundProducts: value,
                      handleProductTap: widget.handleProductTap);
                },
              )),
            ]);
          }
        },
      ),
    );
  }
}
