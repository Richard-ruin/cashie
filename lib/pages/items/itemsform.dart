import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cashie/models/items/items_model.dart';
import 'package:cashie/services/items/items_service.dart';

class ItemsForm extends StatefulWidget {
  final Item? item;

  const ItemsForm({this.item});

  @override
  _ItemsFormState createState() => _ItemsFormState();
}

class _ItemsFormState extends State<ItemsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  File? _imageFile;
  late TextEditingController _typeController;
  late TextEditingController _categoryController;
  late TextEditingController _companyController;
  late TextEditingController _capitalPriceController;
  late TextEditingController _itemPriceController;
  late TextEditingController _packagedPriceController;

  List<String> _suggestedTypes = [];
  List<String> _suggestedCategories = [];
  List<String> _suggestedCompanies = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.itemName ?? '');
    _typeController = TextEditingController(text: widget.item?.itemType ?? '');
    _categoryController =
        TextEditingController(text: widget.item?.itemCategory ?? '');
    _companyController =
        TextEditingController(text: widget.item?.itemCompany ?? '');
    _capitalPriceController = TextEditingController(
        text: _formatNumber(widget.item?.capitalPrice.toString() ?? ''));
    _itemPriceController = TextEditingController(
        text: _formatNumber(widget.item?.itemPrice.toString() ?? ''));
    _packagedPriceController = TextEditingController(
        text: _formatNumber(widget.item?.packagedPrice.toString() ?? ''));

    _suggestedTypes = ItemsService.getTypes();
    _suggestedCategories = ItemsService.getCategories();
    _suggestedCompanies = ItemsService.getCompanies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _categoryController.dispose();
    _companyController.dispose();
    _capitalPriceController.dispose();
    _itemPriceController.dispose();
    _packagedPriceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
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

  String _unformatNumber(String value) {
    return value.replaceAll('.', '');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        itemId: widget.item?.itemId ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        itemName: _nameController.text,
        imagePath: _imageFile != null
            ? _imageFile!.path
            : widget.item?.imagePath ?? 'assets/images/items_icon.jpg',
        itemType: _typeController.text,
        itemCategory: _categoryController.text,
        itemCompany: _companyController.text,
        capitalPrice:
            double.parse(_unformatNumber(_capitalPriceController.text)),
        itemPrice: double.parse(_unformatNumber(_itemPriceController.text)),
        packagedPrice:
            double.parse(_unformatNumber(_packagedPriceController.text)),
      );

      if (widget.item == null) {
        ItemsService.addItem(item);
      } else {
        ItemsService.updateItem(item);
      }

      Navigator.pop(context, item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Tambah Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nama Item'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nama item';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.cover)
                        : widget.item?.imagePath != null
                            ? Image.file(File(widget.item!.imagePath),
                                fit: BoxFit.cover)
                            : Icon(Icons.image, size: 100),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    labelText: 'Tipe Item',
                    suffixIcon: PopupMenuButton<String>(
                      onSelected: (value) {
                        _typeController.text = value;
                      },
                      itemBuilder: (context) {
                        return _suggestedTypes.map((type) {
                          return PopupMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    suffixIcon: PopupMenuButton<String>(
                      onSelected: (value) {
                        _categoryController.text = value;
                      },
                      itemBuilder: (context) {
                        return _suggestedCategories.map((category) {
                          return PopupMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _companyController,
                  decoration: InputDecoration(
                    labelText: 'Perusahaan',
                    suffixIcon: PopupMenuButton<String>(
                      onSelected: (value) {
                        _companyController.text = value;
                      },
                      itemBuilder: (context) {
                        return _suggestedCompanies.map((company) {
                          return PopupMenuItem<String>(
                            value: company,
                            child: Text(company),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _capitalPriceController,
                  decoration: InputDecoration(labelText: 'Harga Modal'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsSeparatorInputFormatter(),
                  ],
                ),
                TextFormField(
                  controller: _itemPriceController,
                  decoration: InputDecoration(labelText: 'Harga Item'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsSeparatorInputFormatter(),
                  ],
                ),
                TextFormField(
                  controller: _packagedPriceController,
                  decoration: InputDecoration(labelText: 'Harga Paket'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsSeparatorInputFormatter(),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final value = newValue.text.replaceAll('.', '');
    final result = StringBuffer();

    for (var i = 0; i < value.length; i++) {
      result.write(value[i]);
      if ((value.length - i - 1) % 3 == 0 && i != value.length - 1) {
        result.write('.');
      }
    }

    return TextEditingValue(
      text: result.toString(),
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}
