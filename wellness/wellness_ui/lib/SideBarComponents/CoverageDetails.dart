import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'CustonDropdown.dart';

enum SingingCharacter { fixed1, fixed2, fixed3, lafayette, jefferson }

class CoverageDetails extends StatefulWidget {
  const CoverageDetails({Key? key}) : super(key: key);

  @override
  State<CoverageDetails> createState() => _CoverageDetailsState();
}

class _CoverageDetailsState extends State<CoverageDetails> {
  //SingingCharacter? _character = SingingCharacter.lafayette;
  bool _radioValue1 = true;
  bool _radioValue2 = false;
  SingingCharacter? _character;
  List<String> selectedFiles = [];
  String? policyType;
  List<String> productCategories = ['Floater', 'Non-Floater'];
  String? familyDefination;
  List<String> Definations = ['Fixed', 'Varied'];
  String? SumInsureded;
  List<String> insured = ['Fixed', 'Varied'];
  List<String> addedItems = ['']; // Initialize with an empty item
  SingingCharacter? _character1;
  List<String> selectedFiles1 = [];
  List<String> selectedFiles2 = [];
  List<String> selectedFiles3 = [];
  List<String> selectedFiles4 = [];
  List<String> selectedFiles5 = [];
  List<String> selectedFiles6 = [];
  List<String> str = [
    "Fill details of the employee only along with email ID and phone number.",
    "Mentioning Family definition is important (ex: 1+3 or 1+5 or Parents only).",
    "Please do not forget to upload other files (claims MIS, policy copy, mandate letter, etc...).",
    "Please upload the data as per the downloaded template."
  ];

  late TextEditingController _controller;
  final TextEditingController PolicyType = TextEditingController();
  final TextEditingController FamilyDefination = TextEditingController();
  final TextEditingController SumInsured = TextEditingController();
  List<List<dynamic>> csvData = [];

  Future<void> _selectFiles(List<String> selectedFiles) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      selectedFiles.clear();
      selectedFiles.addAll(result.files.map((file) => file.path!).toList());
      setState(() {});
    }
  }

  void createCoverageDetails() async {
    var apiUrl =
        'http://192.168.2.239:9763/rfq/coverage/createCoverage'; // Replace with your API endpoint

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    var coverageDto = {
      'rfqId': 'ae1304d8-be5b-4661-9244-5bb8e281dd39',
      'policyType': policyType,
      'familyDefination': familyDefination,
      'sumInsured': SumInsureded,
    };

    var requestBody = jsonEncode(coverageDto);

    request.headers['Content-Type'] = 'application/json';
    request.fields['coverageDto'] = requestBody;

    for (String filePath in selectedFiles1) {
      File file = File(filePath);
      var mimeType = lookupMimeType(file.path);

      var multipartFile = await http.MultipartFile.fromPath(
        'empDepDataFile', // Field name in the API
        file.path,
        contentType: MediaType.parse(mimeType!),
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      // Request successful
      var responseData = await response.stream.bytesToString();
      // Process the response data here
    } else {
      // Handle error
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    // SingingCharacter? _character;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10),
          child: Row(
            children: [
              Text(
                "Details",
                style: TextStyle(
                  color: Color.fromRGBO(113, 114, 111, 1),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: CustomDropdown(
                      value: policyType,
                      onChanged: (String? newValue) {
                        setState(() {
                          policyType = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('product category'), // default label
                        ),
                        ...productCategories.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: CustomDropdown(
                      value: familyDefination,
                      onChanged: (String? newValue) {
                        setState(() {
                          familyDefination = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('Family Defination'), // default label
                        ),
                        ...Definations.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: CustomDropdown(
                      value: SumInsureded,
                      onChanged: (String? newValue) {
                        setState(() {
                          SumInsureded = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('Sum Insured'), // default label
                        ),
                        ...insured.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: createCoverageDetails,
                  child: Text('Save CorporateDetails'),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('I have employee data'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.lafayette,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('I need to get the data from employees'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.jefferson,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (_character == SingingCharacter.lafayette) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectFiles(selectedFiles1),
                      child: Text('Employee data'),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectFiles(selectedFiles1),
                      child: Text('Mandate letter'),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectFiles(selectedFiles1),
                      child: Text('Coverage Sought'),
                    ),
                  ),
                ],
              ),
              if (selectedFiles1.isNotEmpty ||
                  selectedFiles2.isNotEmpty ||
                  selectedFiles3.isNotEmpty) ...[
                Column(
                  children: [
                    if (selectedFiles1.isNotEmpty) ...[
                      Text('Selected Files 1:'),
                      for (String filePath in selectedFiles1) Text(filePath),
                      SizedBox(height: 8),
                    ],
                    if (selectedFiles2.isNotEmpty) ...[
                      Text('Selected Files 2:'),
                      for (String filePath in selectedFiles2) Text(filePath),
                      SizedBox(height: 8),
                    ],
                    if (selectedFiles3.isNotEmpty) ...[
                      Text('Selected Files 3:'),
                      for (String filePath in selectedFiles3) Text(filePath),
                      SizedBox(height: 8),
                    ],
                  ],
                ),
              ],
            ],
            if (_character == SingingCharacter.jefferson) ...[
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Please download the template",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        style: style,
                        onPressed: () {},
                        child: const Text('Download'),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: str.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Text('•'), // Bullet point character
                        title: Text(str[index]),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectFiles(selectedFiles4),
                          child: Text('Filled Template'),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectFiles(selectedFiles5),
                          child: Text('Dependent Data'),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectFiles(selectedFiles6),
                          child: Text('Coverage Sought'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            if (selectedFiles4.isNotEmpty ||
                selectedFiles5.isNotEmpty ||
                selectedFiles6.isNotEmpty) ...[
              Column(
                children: [
                  if (selectedFiles4.isNotEmpty) ...[
                    Text('Selected Files 4:'),
                    for (String filePath in selectedFiles4) Text(filePath),
                    SizedBox(height: 8),
                  ],
                  if (selectedFiles5.isNotEmpty) ...[
                    Text('Selected Files 5:'),
                    for (String filePath in selectedFiles5) Text(filePath),
                    SizedBox(height: 8),
                  ],
                  if (selectedFiles6.isNotEmpty) ...[
                    Text('Selected Files 6:'),
                    for (String filePath in selectedFiles6) Text(filePath),
                    SizedBox(height: 8),
                  ],
                ],
              ),
            ],
          ],
        ),
        if (familyDefination == 'Fixed' && SumInsureded == 'Fixed')
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Family Defination",
                  style: TextStyle(
                    color: Color.fromRGBO(113, 114, 111, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('1 + 3'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.fixed1,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('1+5'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.fixed2,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Parents Only'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.fixed3,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Sum Insured",
                  style: TextStyle(
                    color: Color.fromRGBO(113, 114, 111, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_character == SingingCharacter.fixed1) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "1+3",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(113, 114, 111, 1)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Expanded(
                            child: SizedBox(
                              height: 60.0,
                              width: 245.0,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: Material(
                                  elevation: 5,
                                  shadowColor: Color.fromRGBO(113, 114, 111, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: TextField(
                                    // controller: ,
                                    decoration: InputDecoration(
                                      labelText: 'Sum Insured',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(113, 114, 111, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                if (_character == SingingCharacter.fixed2) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "1+5",
                            style: TextStyle(
                              color: Color.fromRGBO(113, 114, 111, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Expanded(
                            child: SizedBox(
                              height: 60.0,
                              width: 245.0,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: Material(
                                  elevation: 5,
                                  shadowColor: Color.fromRGBO(113, 114, 111, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: TextField(
                                    // controller: ,
                                    decoration: InputDecoration(
                                      labelText: 'Sum Insured',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(113, 114, 111, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                if (_character == SingingCharacter.fixed3) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "Parents only",
                            style: TextStyle(
                              color: Color.fromRGBO(113, 114, 111, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Expanded(
                            child: SizedBox(
                              height: 60.0,
                              width: 245.0,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: Material(
                                  elevation: 5,
                                  shadowColor: Color.fromRGBO(113, 114, 111, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: TextField(
                                    // controller: ,
                                    decoration: InputDecoration(
                                      labelText: 'Sum Insured',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(113, 114, 111, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ],
            )),
          )
        else if (familyDefination == 'Varied' && SumInsureded == 'Varied')
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Family Defination",
                  style: TextStyle(
                    color: Color.fromRGBO(113, 114, 111, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          '1 + 3',
                          style: TextStyle(
                              color: Color.fromRGBO(113, 114, 111, 1)),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.fixed1,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('1+5',
                            style: TextStyle(
                                color: Color.fromRGBO(113, 114, 111, 1))),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.fixed2,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Parents Only',
                            style: TextStyle(
                                color: Color.fromRGBO(113, 114, 111, 1))),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.fixed3,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Sum Insured",
                  style: TextStyle(
                    color: Color.fromRGBO(113, 114, 111, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_character == SingingCharacter.fixed1) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "1+3",
                            style: TextStyle(
                              color: Color.fromRGBO(113, 114, 111, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: addedItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  SizedBox(
                                    height: 60.0,
                                    width: 245.0,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 14),
                                      child: Material(
                                        elevation: 5,
                                        shadowColor:
                                            Color.fromRGBO(113, 114, 111, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              addedItems[index] =
                                                  value; // Update item value
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Sum Insured',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    113, 114, 111, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        addedItems
                                            .add(''); // Add a new empty item
                                      });
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                if (_character == SingingCharacter.fixed2) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "1+5",
                            style: TextStyle(
                              color: Color.fromRGBO(113, 114, 111, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: addedItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  SizedBox(
                                    height: 60.0,
                                    width: 245.0,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 14),
                                      child: Material(
                                        elevation: 5,
                                        shadowColor:
                                            Color.fromRGBO(113, 114, 111, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              addedItems[index] =
                                                  value; // Update item value
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Sum Insured',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    113, 114, 111, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        addedItems
                                            .add(''); // Add a new empty item
                                      });
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                if (_character == SingingCharacter.fixed3) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "Parents only",
                            style: TextStyle(
                              color: Color.fromRGBO(113, 114, 111, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: addedItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  SizedBox(
                                    height: 60.0,
                                    width: 245.0,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 14),
                                      child: Material(
                                        elevation: 5,
                                        shadowColor:
                                            Color.fromRGBO(113, 114, 111, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              addedItems[index] =
                                                  value; // Update item value
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Sum Insured',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    113, 114, 111, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        addedItems
                                            .add(''); // Add a new empty item
                                      });
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              ],
            )),
          )
      ],
    );
  }
}
