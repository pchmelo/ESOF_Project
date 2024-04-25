import 'dart:ui';

import 'package:esof_project/app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../services/database_product.dart';
import '../../../models/product.model.dart';
import '../../../shared/filter.dart';
import 'ProductListBuilder.dart';

class ProductList extends StatefulWidget {
  final Function controller;
  final Function handleProductTap;
  Function filter = ProductFilter().emptyFilter;

  ProductList(
      {super.key, required this.handleProductTap, required this.controller});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late User user;
  late DatabaseForProducts _dbService;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseForProducts(uid: user.uid);
  }

  List<Map<String, dynamic>> _allProducts = [];
  final ValueNotifier<List<Map<String, dynamic>>> _foundProducts =
      ValueNotifier([]);

  String _searchText = '';

  void _runFilter() {
    List<Map<String, dynamic>> results = [];
    _allProducts = widget.filter(_allProducts);
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
    ValueNotifier<bool> quantityDesc = ValueNotifier(true);
    ValueNotifier<bool> alphaDesc = ValueNotifier(true);
    bool switchQuantity = true;
    bool switchAlpha = true;

    return Expanded(
      child: StreamBuilder<List<Product>>(
        stream: _dbService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            _allProducts =
                snapshot.data!.map((product) => product.toJson()).toList();
            _foundProducts.value = List.from(_allProducts);

            return Column(children: [
              Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      child: TextField(
                        onChanged: (value) => _searchText = value,
                        cursorColor: Colors.grey[600],
                        decoration: InputDecoration(
                          labelText: 'Search',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min, // This is important
                            children: <Widget>[
                              IconButton(
                                onPressed: _runFilter,
                                icon: const Icon(Icons.search),
                              ),
                          PopupMenuButton(
                            icon: const Icon(Icons.filter_list_alt),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                                      child: Icon(Icons.sort_by_alpha),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: alphaDesc,
                                      builder: (context, alphaDesc, child) {
                                        return Text(alphaDesc ? 'Sort Alphabetically Asc' : 'Sort Alphabetically Desc');
                                      },
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  if (switchAlpha) {
                                    widget.filter = ProductFilter().sortAlphabeticallyAsc;
                                    alphaDesc = ValueNotifier(false);
                                    switchAlpha = false;
                                  }
                                  else {
                                    widget.filter = ProductFilter().sortAlphabeticallyDesc;
                                    alphaDesc = ValueNotifier(true);
                                    switchAlpha = true;
                                  }

                                  _runFilter();
                                },
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                                      child: ValueListenableBuilder<bool>(
                                        valueListenable: quantityDesc,
                                        builder: (context, quantityDesc, child) {
                                          return Icon(quantityDesc ? Icons.arrow_downward : Icons.arrow_upward);
                                        },
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: quantityDesc,
                                        builder: (context, quantityDesc, child) {
                                          return Text(quantityDesc ? 'Sort by Quantity Desc' : 'Sort by Quantity Asc');
                                        },
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  if (switchQuantity) {
                                    widget.filter = ProductFilter().sortByQuantityDesc;
                                    quantityDesc = ValueNotifier(false);
                                    switchQuantity = false;
                                  }
                                  else {
                                    widget.filter = ProductFilter().sortByQuantityAsc;
                                    quantityDesc = ValueNotifier(true);
                                    switchQuantity = true;
                                  }

                                  _runFilter();
                                },
                              ),
                            ],
                          ),
                            ],
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ), const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: _foundProducts,
                builder: (BuildContext context,
                    List<Map<String, dynamic>> value, Widget? child) {
                  return ProductListBuilder(
                      foundProducts: value,
                      handleProductTap: widget.handleProductTap,
                      controller: widget.controller);
                },
              )),
            ]);
          }
        },
      ),
    );
  }
}
