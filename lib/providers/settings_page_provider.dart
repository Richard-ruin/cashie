import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class SettingsPageProvider with ChangeNotifier {
  static const String settingsBoxName = 'settingsBox';
  static const String notesKey = 'notes';
  static const String membershipKey = 'membership';
  static const String purchaseOrderKey = 'purchaseOrder';
  static const String discountKey = 'discount';
  static const String debtsKey = 'debts';
  static const String dataKey = 'data';

  String _notes;
  String _membership;
  String _purchaseOrder;
  String _discount;
  String _debts;
  String _data;

  SettingsPageProvider()
      : _notes = _getSavedNotes() ?? '',
        _membership = _getSavedMembership() ?? '',
        _purchaseOrder = _getSavedPurchaseOrder() ?? '',
        _discount = _getSavedDiscount() ?? '',
        _debts = _getSavedDebts() ?? '',
        _data = _getSavedData() ?? '';

  String get notes => _notes;
  String get membership => _membership;
  String get purchaseOrder => _purchaseOrder;
  String get discount => _discount;
  String get debts => _debts;
  String get data => _data;

  static String? _getSavedNotes() {
    final box = Hive.box(settingsBoxName);
    return box.get(notesKey);
  }

  static String? _getSavedMembership() {
    final box = Hive.box(settingsBoxName);
    return box.get(membershipKey);
  }

  static String? _getSavedPurchaseOrder() {
    final box = Hive.box(settingsBoxName);
    return box.get(purchaseOrderKey);
  }

  static String? _getSavedDiscount() {
    final box = Hive.box(settingsBoxName);
    return box.get(discountKey);
  }

  static String? _getSavedDebts() {
    final box = Hive.box(settingsBoxName);
    return box.get(debtsKey);
  }

  static String? _getSavedData() {
    final box = Hive.box(settingsBoxName);
    return box.get(dataKey);
  }

  Future<void> setNotes(String notes) async {
    final box = Hive.box(settingsBoxName);
    _notes = notes;
    await box.put(notesKey, notes);
    notifyListeners();
  }

  Future<void> setMembership(String membership) async {
    final box = Hive.box(settingsBoxName);
    _membership = membership;
    await box.put(membershipKey, membership);
    notifyListeners();
  }

  Future<void> setPurchaseOrder(String purchaseOrder) async {
    final box = Hive.box(settingsBoxName);
    _purchaseOrder = purchaseOrder;
    await box.put(purchaseOrderKey, purchaseOrder);
    notifyListeners();
  }

  Future<void> setDiscount(String discount) async {
    final box = Hive.box(settingsBoxName);
    _discount = discount;
    await box.put(discountKey, discount);
    notifyListeners();
  }

  Future<void> setDebts(String debts) async {
    final box = Hive.box(settingsBoxName);
    _debts = debts;
    await box.put(debtsKey, debts);
    notifyListeners();
  }

  Future<void> setData(String data) async {
    final box = Hive.box(settingsBoxName);
    _data = data;
    await box.put(dataKey, data);
    notifyListeners();
  }
}
