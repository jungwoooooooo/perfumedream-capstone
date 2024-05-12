// models/model_item_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model_item.dart';

class ItemProvider with ChangeNotifier {
  late CollectionReference itemsReference;
  List<Item> items = [];
  List<Item> searchItem = [];

  ItemProvider({reference}) {
    itemsReference = reference ?? FirebaseFirestore.instance.collection('items');
  }

  Future<void> fetchItems() async {
    items = await itemsReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return Item.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }

  //새로 추가 한 것임 !!
  Future<Item> fetchItemById(String id) async {
    DocumentSnapshot snapshot = await itemsReference.doc(id).get();
    return Item.fromSnapshot(snapshot);
  }

  Future<void> search(String query) async {
    searchItem = [];
    if (query.length == 0) {
      return;
    }
    for (Item item in items) {
      if (item.title.contains(query)) {
        searchItem.add(item);
      }
    }
    notifyListeners();
  }
}