import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustonDropdown.dart';
import 'Stepper.dart';
import 'package:provider/provider.dart';

import 'Stepper1.dart';

class GeneratedIdProvider extends ChangeNotifier {
  String? generatedId;

  void updateGeneratedId(String? id) {
    generatedId = id;
    notifyListeners();
  }
}

class CreateRFQ extends StatefulWidget {
  const CreateRFQ({Key? key}) : super(key: key);

  @override
  State<CreateRFQ> createState() => _CreateRFQState();
}

class _CreateRFQState extends State<CreateRFQ>
    with SingleTickerProviderStateMixin {
  String? selectedProductCategory;
  List<Map<String, dynamic>> productCategories = [];

  String? selectedProductType;
  List<String> productTypes = [];

  String? selectedPolicyType;
  List<String> policyTypes = ['Fresh', 'Renewal', 'Both'];

  late TabController _tabController;

  bool isVisible = false;
  bool isDropdownEmpty = false;

  Future<void> fetchDropdownOptionsProductCategories() async {
    try {
      var response = await http
          .get(Uri.parse('http://192.168.4.58:9763/rfq/category/prodCategory'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        setState(() {
          productCategories = List<Map<String, dynamic>>.from(data);
        });
      } else {
        print('Failed to fetch dropdown options');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> fetchDropdownOptionsProductList() async {
    try {
      var selectedCategory = productCategories.firstWhere(
          (category) => category['categoryName'] == selectedProductCategory);
      var categoryId = int.parse(selectedCategory['categoryId'].toString());

      var response = await http
          .get(Uri.parse('http://192.168.4.58:9763/products/get/$categoryId'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        // print("ajaryya");

        setState(() {
          productTypes = List<String>.from(data.map((item) => item.toString()));
        });
      } else {
        print('Failed to fetch dropdown options');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _toggleVisibility() {
    if (selectedProductCategory == null ||
        selectedProductType == null ||
        selectedPolicyType == null) {
      setState(() {
        isDropdownEmpty = true;
      });
    } else {
      setState(() {
        isVisible = !isVisible;
        isDropdownEmpty = false;
        _createRFQ();
      });
    }
  }

  void _createRFQ() async {
    var requestBody = {
      'prodCategoryId': selectedProductCategory,
      'productId': selectedProductType,
      'policyType': selectedPolicyType,
    };

    var apiUrl = 'http://192.168.4.58:9763/rfq/createRfq';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = json.decode(response.body);
      var generatedId = responseData['id'];

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('myData', responseData);

      Provider.of<GeneratedIdProvider>(context, listen: false)
          .updateGeneratedId(generatedId);

      setState(() {
        isVisible = true;
        isDropdownEmpty = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  // final LocalStorage storage = new LocalStorage('localstorage_app');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
    fetchDropdownOptionsProductCategories();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Tab> myTabs = [
    const Tab(
      child: Text(
        "Corporate Details",
        style: TextStyle(
          color: Color.fromRGBO(113, 114, 111, 1),
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const Tab(
      child: Text(
        "Coverage Details",
        style: TextStyle(
          color: Color.fromRGBO(113, 114, 111, 1),
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const Tab(
      child: Text(
        "Policy terms",
        style: TextStyle(
          color: Color.fromRGBO(113, 114, 111, 1),
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const Tab(
      child: Text(
        "Send RFQ",
        style: TextStyle(
          color: Color.fromRGBO(113, 114, 111, 1),
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double _progressValue = 0.5;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color.fromRGBO(239, 247, 251, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20),
                child: Text(
                  "Add RFQ",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(113, 114, 111, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Container(
                  width: screenWidth * 1.5,
                  height: screenHeight * 0.80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 15,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30, left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 1),
                                  child: Text(
                                    'Product Category',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(113, 114, 111, 1),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Select Product',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(113, 114, 111, 1),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 200.0),
                                  child: Text(
                                    'Policy Type',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(113, 114, 111, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: CustomDropdown(
                                    value: selectedProductCategory,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedProductCategory = newValue;
                                        fetchDropdownOptionsProductList();
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: null,
                                        child:
                                            Text('Select a product category'),
                                      ),
                                      ...productCategories.map((category) {
                                        return DropdownMenuItem<String>(
                                          value: category['categoryName'],
                                          child: Text(category['categoryName']),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: CustomDropdown(
                                    value: selectedProductType,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedProductType = newValue;
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: null,
                                        child: Text('Select a product'),
                                      ),
                                      ...productTypes.map((option) {
                                        return DropdownMenuItem<String>(
                                          value: option,
                                          child: Text(option),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: CustomDropdown(
                                    value: selectedPolicyType,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedPolicyType = newValue;
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: null,
                                        child: Text('Select policy type'),
                                      ),
                                      ...policyTypes.map((option) {
                                        return DropdownMenuItem<String>(
                                          value: option,
                                          child: Text(option),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Expanded(
                                  child: SizedBox(
                                    width: 100,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: _toggleVisibility,
                                      child: const Text('Submit'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isDropdownEmpty)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Please select all dropdowns',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        if (selectedPolicyType == "Fresh" && isVisible)
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, top: 10),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: HorizontalStepperExampleApp(),
                              ),
                            ),
                          ),
                        if (selectedPolicyType == "Renewal" && isVisible)
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, top: 10),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: HorizontalStepperExampleApp1(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
