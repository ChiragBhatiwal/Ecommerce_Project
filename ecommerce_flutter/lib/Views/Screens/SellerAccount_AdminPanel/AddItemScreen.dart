import 'dart:io';

import 'package:ecommerce_flutter/Services/Api/AddProductScreenApis.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/SellerAccount_AdminPanelScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _priceFieldController = TextEditingController();
  final TextEditingController _shortDescriptionField = TextEditingController();
  final TextEditingController _fullDescriptionField = TextEditingController();
  final TextEditingController _chargesAndTaxController =
      TextEditingController();

  List<XFile> files = [];
  List<int> discountItem = [];
  int? _discountPercentageItem;
  int? _taxPercentageItem;

  @override
  void initState() {
    super.initState();
    addItemInDropDownList();
  }

  void addItemInDropDownList() {
    for (int i = 0; i <= 100; i++) {
      discountItem.add(i);
    }
  }

  void _pickImages() async {
    final List<XFile>? selectedFiles = await _imagePicker.pickMultiImage();
    if (selectedFiles != null && selectedFiles.isNotEmpty) {
      setState(() {
        files.addAll(selectedFiles);
      });
    }
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _priceFieldController.dispose();
    _shortDescriptionField.dispose();
    _fullDescriptionField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Items"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              files.isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              height: double.infinity,
                              width: 130,
                              child: Image.file(
                                File(files[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : InkWell(
                      onTap: _pickImages,
                      child: Column(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Add Images",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: const Center(
                                child: Icon(Icons.add_a_photo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameFieldController,
                  decoration: const InputDecoration(
                    hintText: "Item Name",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _priceFieldController,
                  decoration: const InputDecoration(
                    hintText: "Item Price",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _shortDescriptionField,
                  maxLength: 150,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "Short Description",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _fullDescriptionField,
                  maxLines: 5,
                  maxLength: 500,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "Rich Description",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 125,
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        const Text(
                          "Discount (If Any)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 33.0),
                          child: DropdownButton<int>(
                            hint: const Text("Select Discount %"),
                            value: _discountPercentageItem,
                            items: discountItem.map((int item) {
                              return DropdownMenuItem<int>(
                                value: item,
                                child: Text("${item.toString()} %"),
                              );
                            }).toList(),
                            onChanged: (int? value) {
                              setState(() {
                                _discountPercentageItem = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Text(
                          "Charges & Taxes (If Any)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        TextField(
                          controller: _chargesAndTaxController,
                        )
                      ],
                    )),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final productName = _nameFieldController.text;
                  final productPrice = _priceFieldController.text;
                  final productShortDesc = _shortDescriptionField.text;
                  final productRichDesc = _fullDescriptionField.text;
                  final discountPercent = _discountPercentageItem.toString();
                  final taxPercent = _chargesAndTaxController.text;

                  final response = await AddProductScreenApis.addProduct(
                      files,
                      productName,
                      productPrice,
                      productShortDesc,
                      productRichDesc,
                      discountPercent,
                      taxPercent);

                  if (response == 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminPannelScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Operation Failed"),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  }
                },
                child: const Text("Add Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
