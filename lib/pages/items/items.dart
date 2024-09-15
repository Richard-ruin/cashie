import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cashie/models/items/items_model.dart';
import 'package:cashie/services/items/items_service.dart';
import 'itemsform.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

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
        title: const Text(
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
                        title: const Text('Filter'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButtonFormField<String>(
                              value: _selectedCategory,
                              items: [
                                const DropdownMenuItem(
                                  value: null,
                                  child: Text('All Category'),
                                ),
                                ...ItemsService.getCategories()
                                    .map((category) => DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                                _filterItems();
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Kategori'),
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedCompany,
                              items: [
                                const DropdownMenuItem(
                                  value: null,
                                  child: Text('All Company'),
                                ),
                                ...ItemsService.getCompanies()
                                    .map((company) => DropdownMenuItem(
                                          value: company,
                                          child: Text(company),
                                        )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCompany = value;
                                });
                                _filterItems();
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Company'),
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
                            child: const Text('Reset'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Tutup'),
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
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // TextField untuk Search
                Expanded(
                  child: TextField(
                    onChanged: _searchItems,
                    decoration: const InputDecoration(
                      hintText: 'Search ...',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
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
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 2,
            color: Colors.lightBlueAccent,
          ),
          // Grid View untuk menampilkan item
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        title: const Text('Hapus Item'),
                        content: const Text(
                            'Apakah Anda yakin ingin menghapus item ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteItem(item);
                              Navigator.pop(context);
                            },
                            child: const Text('Hapus'),
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            color: Colors.black54,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemName,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rp ${_formatNumber(item.itemPrice.toStringAsFixed(0))}',
                                style: const TextStyle(
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
        child: const Icon(Icons.add),
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
