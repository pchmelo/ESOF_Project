import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/views/extra_pages/validity/validityListBuilder.dart';
import 'package:esof_project/app/views/extra_pages/validity/validityTile.dart';
import 'package:esof_project/services/database_validity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../controllers/validityControllers.dart';
import '../../../models/validity.model.dart';
import '../../../shared/filter.dart';
import '../../../shared/loading.dart';

class ValidityListWidget extends StatefulWidget {
  List<Map<String, bool>> list_delete = [];
  final Product product;
  final ValueNotifier<bool> editValidity;
  ValidityListWidget({
    Key? key,
    required this.product,
    required this.editValidity,
  });
  Function filter = ValidityFilter().emptyFilter;

  @override
  State<ValidityListWidget> createState() => _ValidityListWidgetState();
}

class _ValidityListWidgetState extends State<ValidityListWidget> {
  late User user;
  late DatabaseForValidity _dbService;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseForValidity(uid: user.uid);
  }

  List<Map<String, dynamic>> _allValidities = [];
  final ValueNotifier<List<Map<String, dynamic>>> _foundValidities =
      ValueNotifier([]);

  String _searchText = '';

  void _runFilter() {
    List<Map<String, dynamic>> results = [];
    _allValidities = widget.filter(_allValidities);
    if (_searchText.isEmpty) {
      results = List.from(_allValidities);
    } else {
      results = _allValidities
          .where((validity) => validity['name']
              .toLowerCase()
              .contains(_searchText.toLowerCase()))
          .toList();
    }
    _foundValidities.value = results;
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> quantityDesc = ValueNotifier(true);
    ValueNotifier<bool> alphaDesc = ValueNotifier(true);
    ValueNotifier<bool> sortMethod = ValueNotifier(true);
    bool switchQuantity = true;
    bool switchAlpha = true;

    return Expanded(
      child: Column(
        children: [
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
                                  return Text(alphaDesc
                                      ? 'Sort Alphabetically Asc'
                                      : 'Sort Alphabetically Desc');
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            if (switchAlpha) {
                              widget.filter =
                                  ValidityFilter().sortAlphabeticallyAsc;
                              alphaDesc = ValueNotifier(false);
                              switchAlpha = false;
                            } else {
                              widget.filter =
                                  ValidityFilter().sortAlphabeticallyDesc;
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: quantityDesc,
                                  builder: (context, quantityDesc, child) {
                                    return Icon(quantityDesc
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward);
                                  },
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: quantityDesc,
                                builder: (context, quantityDesc, child) {
                                  return Text(quantityDesc
                                      ? 'Sort by Quantity Desc'
                                      : 'Sort by Quantity Asc');
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            if (switchQuantity) {
                              widget.filter =
                                  ValidityFilter().sortByQuantityDesc;
                              quantityDesc = ValueNotifier(false);
                              switchQuantity = false;
                            } else {
                              widget.filter =
                                  ValidityFilter().sortByQuantityAsc;
                              quantityDesc = ValueNotifier(true);
                              switchQuantity = true;
                            }

                            _runFilter();
                          },
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: ValueListenableBuilder(
                            valueListenable: sortMethod,
                            builder: (context, value, child) {
                              return Row(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                                    child: Icon(Icons.calendar_today),
                                  ),
                                  Text(value
                                      ? 'Sort by Expiration Date Asc'
                                      : 'Sort by Expiration Date Desc'),
                                ],
                              );
                            },
                          ),
                          onTap: () {
                            if (!sortMethod.value) {
                              widget.filter = ValidityFilter().sortByValidityDateDesc;
                              sortMethod.value = true;
                            } else {
                              widget.filter = ValidityFilter().sortByValidityDateAsc;
                              sortMethod.value = false;
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
          ),
          Expanded(
            child: StreamBuilder<List<Validity>>(
              stream:
                  _dbService.getAllValiditiesOfProductStream(widget.product.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Validity>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  _allValidities = snapshot.data!
                      .map((product) => product.toJson())
                      .toList();
                  _foundValidities.value = List.from(_allValidities);

                  return Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                          child: ValueListenableBuilder(
                        valueListenable: _foundValidities,
                        builder: (BuildContext context,
                            List<Map<String, dynamic>> value, Widget? child) {
                          return ValidityListBuilder(
                              foundValidities: value,
                              editValidity: widget.editValidity);
                        },
                      )),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
