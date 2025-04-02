import 'dart:io';

import 'package:ecommerce_flutter/Services/Api/UpdateProductScreenApis.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/ItemManageScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Models/ItemManagedScreenModel.dart';

class UpdateItemScreen extends StatefulWidget {
  final ItemManagedScreenModel? product;

  const UpdateItemScreen({super.key, this.product});

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _priceFieldController = TextEditingController();
  final TextEditingController _shortDescriptionField = TextEditingController();
  final TextEditingController _fullDescriptionField = TextEditingController();
  final TextEditingController _chargesAndTaxController =
      TextEditingController();

  List<String> oldImages = []; // URLs of old images
  List<XFile> newImages = []; // Files of new images
  List<dynamic> displayImages = []; // Combined list for UI (URLs + Files)
  List<int> discountItem = [];
  int? _discountPercentageItem;

  @override
  void initState() {
    super.initState();
    addItemInDropDownList();

    // Pre-fill fields if product exists
    if (widget.product != null) {
      oldImages = List<String>.from(widget.product!.productImage!);
      displayImages = widget.product!.productImage!;
      _nameFieldController.text = widget.product!.productName ?? '';
      _priceFieldController.text = widget.product!.productPrice.toString();
      _shortDescriptionField.text = widget.product!.productShortDesc ?? '';
      _fullDescriptionField.text = widget.product!.productRichDesc ?? '';
      _chargesAndTaxController.text =
          widget.product!.taxOnProduct.toString() ?? '';

      _discountPercentageItem =
          int.tryParse(widget.product!.discountOnProduct.toString() ?? '0');
    }
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
        newImages.addAll(selectedFiles);
        displayImages.addAll(selectedFiles);
      });
    }
  }

  removeImageFromBothList(int index) {
    final image = displayImages[index];
    print(image);
    setState(() {
      if (image is String && oldImages.contains(image)) {
        oldImages.remove(image); // Remove from oldImages
      } else if (image is XFile) {
        // Compare by the path to find the matching file in newImages
        newImages.removeWhere((newImage) => newImage.path == image.path);
      }
      displayImages.removeAt(index); // Remove from displayImages
    });
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
          title: const Text(
            "Update Item",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              displayImages.isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: displayImages.length,
                        itemBuilder: (context, index) {
                          final file = displayImages[index];
                          final isNetworkImage = file is String;

                          return GestureDetector(
                            onTap: () async {
                              // Allow user to pick new images
                              final List<XFile>? selectedFiles =
                                  await _imagePicker.pickMultiImage();
                              if (selectedFiles != null &&
                                  selectedFiles.isNotEmpty) {
                                setState(() {
                                  displayImages.addAll(selectedFiles);
                                  newImages.addAll(selectedFiles);
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    height: double.infinity,
                                    width: 130,
                                    child: isNetworkImage
                                        ? Image.network(
                                            file,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                  child: Text(
                                                      "Error Loading Image"));
                                            },
                                          )
                                        : Image.file(
                                            File(file.path),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          removeImageFromBothList(
                                              index); // Remove the image from the list
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
              // ... Rest of the fields
              ElevatedButton(
                onPressed: () async {
                  final productName = _nameFieldController.text.toString();
                  final productPrice = _priceFieldController.text.toString();
                  final productShortDesc =
                      _shortDescriptionField.text.toString();
                  final productRichDesc = _fullDescriptionField.text;
                  final discountPercent = _discountPercentageItem.toString();
                  final taxPercent = _chargesAndTaxController.text;
                  final itemId = widget.product!.sId!;
                  print(newImages);
                  // Call the API for Add/Update
                  final response = await UpdateProductScreenApis.UpdateProduct(
                      itemId,
                      newImages,
                      oldImages,
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
                        builder: (context) => const ItemManageScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response.toString()),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  }
                },
                child:
                    Text(widget.product == null ? "Add Item" : "Update Item"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
