import 'package:ecommerce_flutter/Services/Api/AddressScreenApis.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/ManageAccountScreen.dart';
import 'package:flutter/material.dart';

class AddressSubmitionScreen extends StatefulWidget {
  const AddressSubmitionScreen({super.key});

  @override
  State<AddressSubmitionScreen> createState() => _AddressSubmitionScreenState();
}

class _AddressSubmitionScreenState extends State<AddressSubmitionScreen> {
  List<String> addressType = ["Home", "Work", "Hotel", "Other"];
  String title = "Home";
  int selectedIndex = 0;
  bool isLoading = false; // Loader state

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _numberFieldController = TextEditingController();
  final TextEditingController _addressFieldController = TextEditingController();
  final TextEditingController _cityFieldController = TextEditingController();
  final TextEditingController _stateFieldController = TextEditingController();
  final TextEditingController _pincodeFieldController = TextEditingController();
  final TextEditingController _countryFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Add Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey, // Attach form key
              child: Column(
                children: [
                  _buildTextField(
                    controller: _nameFieldController,
                    hintText: "Name",
                    validator: (value) => value == null || value.isEmpty
                        ? "Name is required"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _numberFieldController,
                    hintText: "Mobile Number",
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.isEmpty
                        ? "Mobile Number is required"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _addressFieldController,
                    hintText: "Address",
                    validator: (value) => value == null || value.isEmpty
                        ? "Address is required"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _cityFieldController,
                    hintText: "City",
                    validator: (value) => value == null || value.isEmpty
                        ? "City is required"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _stateFieldController,
                    hintText: "State/Province/Region",
                    validator: (value) => value == null || value.isEmpty
                        ? "State is required"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _pincodeFieldController,
                    hintText: "Pin Code/Zip Code",
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? "Pin Code is required"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _countryFieldController,
                    hintText: "Country",
                    validator: (value) => value == null || value.isEmpty
                        ? "Country is required"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(addressType.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            title = addressType[index]; // Update title here
                          });
                          print(
                              "Title updated: $title"); // Debugging line to check title change
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selectedIndex == index
                                  ? Colors.red
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            addressType[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        String fullname = _nameFieldController.text;
                        String mobile = _numberFieldController.text;
                        String city = _cityFieldController.text;
                        String state = _stateFieldController.text;
                        String pincode = _pincodeFieldController.text;
                        String country = _countryFieldController.text;
                        String address = _addressFieldController.text;
                        print("Title is $title");
                        int success = await AddressScreenApis.addAddress(
                            title,
                            fullname,
                            mobile,
                            city,
                            state,
                            pincode,
                            country,
                            address);
                        if (success == 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to add address"),
                            ),
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 2),
        ),
      ),
      validator: validator,
    );
  }
}
