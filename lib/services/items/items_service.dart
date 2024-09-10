import 'package:hive/hive.dart';
import 'package:cashie/models/items/items_model.dart';

class ItemsService {
  static final Box<Item> _box = Hive.box<Item>('items');

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
}
