import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cashie/models/items/items_model.dart';
import 'package:cashie/services/items/items_service.dart';
import 'package:cashie/widgets/items/items_tile.dart';
import 'itemsform.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<Item> _items = [];
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedCompany;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    setState(() {
      _items = ItemsService.getAllItems();
    });
  }

  void _searchItems(String query) {
    setState(() {
      _searchQuery = query;
      _items = ItemsService.searchItems(query);
    });
  }

  void _filterItems() {
    setState(() {
      _items = ItemsService.getAllItems();
      if (_selectedCategory != null) {
        _items = _items
            .where((item) => item.itemCategory == _selectedCategory)
            .toList();
      }
      if (_selectedCompany != null) {
        _items = _items
            .where((item) => item.itemCompany == _selectedCompany)
            .toList();
      }
      if (_searchQuery.isNotEmpty) {
        _items = _items
            .where((item) => item.itemName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  void _deleteItem(Item item) {
    setState(() {
      ItemsService.deleteItem(item);
      _loadItems();
    });
  }

  void _navigateToItemForm([Item? item]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemsForm(item: item)),
    );
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'LIST BARANG',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Icon Filter
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Filter'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButtonFormField<String>(
                              value: _selectedCategory,
                              items: [
                                DropdownMenuItem(
                                  child: Text('All Category'),
                                  value: null,
                                ),
                                ...ItemsService.getCategories()
                                    .map((category) => DropdownMenuItem(
                                          child: Text(category),
                                          value: category,
                                        )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                                _filterItems();
                              },
                              decoration:
                                  InputDecoration(labelText: 'Kategori'),
                            ),
                            SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedCompany,
                              items: [
                                DropdownMenuItem(
                                  child: Text('All Company'),
                                  value: null,
                                ),
                                ...ItemsService.getCompanies()
                                    .map((company) => DropdownMenuItem(
                                          child: Text(company),
                                          value: company,
                                        )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCompany = value;
                                });
                                _filterItems();
                              },
                              decoration: InputDecoration(labelText: 'Company'),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedCategory = null;
                                _selectedCompany = null;
                              });
                              _filterItems();
                              Navigator.pop(context);
                            },
                            child: Text('Reset'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // TextField untuk Search
                Expanded(
                  child: TextField(
                    onChanged: _searchItems,
                    decoration: InputDecoration(
                      hintText: 'Search ...',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Garis pembatas
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 2,
            color: Colors.lightBlueAccent,
          ),
          // Grid View untuk menampilkan item
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return GestureDetector(
                  onTap: () => _navigateToItemForm(item),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Hapus Item'),
                        content:
                            Text('Apakah Anda yakin ingin menghapus item ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteItem(item);
                              Navigator.pop(context);
                            },
                            child: Text('Hapus'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      // Gambar item
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(item.imagePath)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Overlay nama dan harga item di atas gambar
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            color: Colors.black54,
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemName,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Rp ${_formatNumber(item.itemPrice.toStringAsFixed(0))}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToItemForm,
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatNumber(String value) {
    final number = value.replaceAll('.', '');
    final result = StringBuffer();

    for (var i = 0; i < number.length; i++) {
      result.write(number[i]);
      if ((number.length - i - 1) % 3 == 0 && i != number.length - 1) {
        result.write('.');
      }
    }

    return result.toString();
  }
}
