import 'package:hive/hive.dart';
import 'package:cashie/models/items/items_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ItemsService {
  static final Box<Item> _box = Hive.box<Item>('items');
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addItem(Item item) async {
    await _box.put(item.itemId, item);
  }

  static Future<void> updateItem(Item item) async {
    await _box.put(item.itemId, item);
  }

  static Future<void> deleteItem(Item item) async {
    await _box.delete(item.itemId);
  }

  static List<Item> getAllItems() {
    return _box.values.toList();
  }

  static List<Item> searchItems(String query) {
    return _box.values
        .where(
            (item) => item.itemName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static List<String> getCategories() {
    return _box.values.map((item) => item.itemCategory).toSet().toList();
  }

  static List<String> getCompanies() {
    return _box.values.map((item) => item.itemCompany).toSet().toList();
  }

  static List<String> getTypes() {
    return _box.values.map((item) => item.itemType).toSet().toList();
  }

  static Future<void> backupItemsToFirebase() async {
    final items = getAllItems();
    final batch = _firestore.batch();

    for (var item in items) {
      final itemDoc = _firestore.collection('items').doc(item.itemId);
      batch.set(itemDoc, item.toMap());
    }

    await batch.commit();
  }

  static Future<void> restoreItemsFromFirebase() async {
    final snapshot = await _firestore.collection('items').get();

    for (var doc in snapshot.docs) {
      final itemData = doc.data();
      final item = Item.fromMap(itemData);
      await addItem(item);
    }
  }
}
