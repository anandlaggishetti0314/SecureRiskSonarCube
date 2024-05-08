import 'dart:async';
import 'dart:io';
import 'dart:html' as html;
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:toastification/toastification.dart';
import 'dart:convert';
import 'CustonDropdown.dart';
import 'package:http_parser/http_parser.dart';

enum SingingCharacter { fixed1, fixed2, fixed3, lafayette, jefferson }

class HorizontalStepperExampleApp extends StatefulWidget {
  @override
  _HorizontalStepperExampleAppState createState() =>
      _HorizontalStepperExampleAppState();
}

class _HorizontalStepperExampleAppState
    extends State<HorizontalStepperExampleApp> {
  int currentStep = 0;
  SingingCharacter? _character;
  String? policyType;
  List<String> productCategories = ['Floater', 'Non-Floater'];
  String? familyDefination;
  List<String> Definations = ['Fixed', 'Varied'];
  String? SumInsureded;
  List<String> insured = ['Fixed', 'Varied'];
  List<String> str = [
    "Fill details of the employee only along with email ID and phone number.",
    "Mentioning Family definition is important (ex: 1+3 or 1+5 or Parents only).",
    "Please do not forget to upload other files (claims MIS, policy copy, mandate letter, etc...).",
    "Please upload the data as per the downloaded template."
  ];

  List<String> selectedFiles1 = [];
  List<String> selectedFiles2 = [];
  List<String> selectedFiles3 = [];
  List<String> selectedFiles4 = [];
  List<String> selectedFiles5 = [];
  List<String> selectedFiles6 = [];

  // Corporaate Details
  final TextEditingController NameOftheInsurer = TextEditingController();
  final TextEditingController NameOfTheBussiness = TextEditingController();
  final TextEditingController NameOfTheBusiness = TextEditingController();
  final TextEditingController Address = TextEditingController();
  final TextEditingController EmailId = TextEditingController();
  final TextEditingController PhoneNumber = TextEditingController();
  final TextEditingController NameOfTheIntermediary = TextEditingController();
  final TextEditingController IntermediateEmailId = TextEditingController();
  final TextEditingController IntermediateContactName = TextEditingController();
  final TextEditingController ContactName = TextEditingController();
  final TextEditingController IntermediatePhoneNumber = TextEditingController();

  Future<void> saveCorporateDetails() async {
    var body = {
      "rfqId": "ae1304d8-be5b-4661-9244-5bb8e281dd39",
      "insuredName": NameOftheInsurer.text,
      "address": Address.text,
      "nob": NameOfTheBusiness.text,
      "contactName": ContactName.text,
      "email": EmailId.text,
      "phNo": PhoneNumber.text,
      "intermediaryName": NameOfTheIntermediary.text,
      "intermediaryContactName": IntermediateContactName.text,
      "intermediaryEmail": IntermediateEmailId.text,
      "intermediaryPhNo": IntermediatePhoneNumber.text,
      "tpaName": null,
      "tpaContactName": null,
      "tpaEmail": null,
      "tpaPhNo": null
    };

    Response response = await post(
        Uri.parse(
            'http://192.168.2.239:9763/rfq/corporateDetails/createCorporateDetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('CorporateDetails saved successfully');
    } else {
      print('Failed to save CorporateDetails');
    }
  }

  // CoverageDetails
  String fileName = "";
  List<int>? _selectedFile;
  Uint8List? _bytesData;
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
    final data = {
      'rfqId': 'ae1304d8-be5b-4661-9244-5bb8e281dd39',
      'policyType': policyType,
      'familyDefination': familyDefination,
      'sumInsured': SumInsureded,
    };

    var url =
        Uri.parse("http://192.168.2.239:9763/rfq/coverage/createCoverage");
    var request = http.MultipartRequest("POST", url);
    request = jsonToFormData(request, data);

    Random rnd;
    int min = 1000;
    int max = 5000;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      http.MultipartFile.fromBytes('empDepDataFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      http.MultipartFile.fromBytes('mandateLetterFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      http.MultipartFile.fromBytes('coveragesFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('claimsMiscFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('claimsSummaryFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('templateFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('empDepDataWithFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('policyCopyFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('claimsMiscWithFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes(
          'claimsSummaryWithFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('claimsMiscWithFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.files.add(
      await http.MultipartFile.fromBytes('coveragesWithFile', _selectedFile!,
          contentType: MediaType('application', 'json'), filename: fileName),
    );
    r = min + rnd.nextInt(max - min);
    fileName = "sam_" + r.toString() + ".jpg";

    request.send().then((response) {
      print('Response From Server : ');
      print(response.toString());
      if (response.statusCode == 200) {
        print("File uploaded successfully");
      } else {
        print('file upload failed');
      }
    });
  }

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  // policy properties
  List<List<TextEditingController>> tableData = [];
  int rowCounter = 1;

  void removeRow(int index) {
    setState(() {
      tableData[index][0].clear();
      tableData[index][1].clear();
      tableData.removeAt(index);
      rowCounter--;
    });
  }

  //Policy Terms
  Future<void> sendDataToApi() async {
    try {
      Map<String, dynamic> requestData = {
        'rfqId': '9537705c-cced-4ea1-b113-ae90563e1a11',
        'policyDetails': [],
      };

      for (var data in tableData) {
        String coverageName = data[0].text;
        String remark = data[1].text;

        Map<String, String> policyDetails = {
          'coverageName': coverageName,
          'remark': remark,
        };
        requestData['policyDetails'].add(policyDetails);
      }

      String requestBody = json.encode(requestData);

      final response = await http.post(
        Uri.parse(
            'http://192.168.2.239:9760/rfq/policyTerms/createPolicyTerms'),
        body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        toastification.showSuccess(
          context: context,
          autoCloseDuration: const Duration(seconds: 2),
          title: 'Policy Details sent successfully..',
        );
        print('Data sent successfully');
      } else {
        toastification.showError(
          context: context,
          autoCloseDuration: const Duration(seconds: 2),
          title: 'Something went wrong..',
        );
        print('API error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Corporate Details"),
        content: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.0),
                child: Row(
                  children: [
                    Material(
                      child: Text(
                        "Details",
                        style: TextStyle(
                          color: Color.fromRGBO(113, 114, 111, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: NameOftheInsurer,
                                decoration: InputDecoration(
                                  labelText: 'Name of Insurer/Proposer',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: Address,
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: NameOfTheBusiness,
                                decoration: InputDecoration(
                                  labelText: 'Name of Business',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: ContactName,
                                decoration: InputDecoration(
                                  labelText: 'Contact Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: EmailId,
                                decoration: InputDecoration(
                                  labelText: 'Email Id',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: PhoneNumber,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1),
                      child: Text(
                        "Intermediary Details",
                        style: TextStyle(
                          color: Color.fromRGBO(113, 114, 111, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 1, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: NameOfTheIntermediary,
                                decoration: InputDecoration(
                                  labelText: 'Name of the Intermediary',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(113, 114, 111, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: IntermediateContactName,
                                decoration: InputDecoration(
                                  labelText: 'Contact Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(113, 114, 111, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: IntermediateEmailId,
                                decoration: InputDecoration(
                                  labelText: 'Email Id',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(113, 114, 111, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Expanded(
                        child: SizedBox(
                          height: 60.0,
                          width: 245.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 14),
                            child: Material(
                              elevation: 5,
                              shadowColor: Color.fromRGBO(113, 114, 111, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: TextField(
                                controller: IntermediatePhoneNumber,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
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
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Coverage Details"),
        content: Container(
          color: Colors.white,
          child: Column(
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
                                child:
                                    Text('product category'), // default label
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
                                child:
                                    Text('Family Defination'), // default label
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
                          title: const Text(
                              'I need to get the data from employees'),
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
                            onPressed: () {
                              startWebFilePicker();
                            },
                            child: Text('Employee data'),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              startWebFilePicker();
                            },
                            child: Text('Mandate letter'),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              startWebFilePicker();
                            },
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
                            for (String filePath in selectedFiles1)
                              Text(filePath),
                            SizedBox(height: 8),
                          ],
                          if (selectedFiles2.isNotEmpty) ...[
                            Text('Selected Files 2:'),
                            for (String filePath in selectedFiles2)
                              Text(filePath),
                            SizedBox(height: 8),
                          ],
                          if (selectedFiles3.isNotEmpty) ...[
                            Text('Selected Files 3:'),
                            for (String filePath in selectedFiles3)
                              Text(filePath),
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
                          for (String filePath in selectedFiles4)
                            Text(filePath),
                          SizedBox(height: 8),
                        ],
                        if (selectedFiles5.isNotEmpty) ...[
                          Text('Selected Files 5:'),
                          for (String filePath in selectedFiles5)
                            Text(filePath),
                          SizedBox(height: 8),
                        ],
                        if (selectedFiles6.isNotEmpty) ...[
                          Text('Selected Files 6:'),
                          for (String filePath in selectedFiles6)
                            Text(filePath),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (_character == SingingCharacter.fixed1) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1+3",
                                style: TextStyle(fontSize: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Expanded(
                                  child: SizedBox(
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
                              Text("1+5"),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Expanded(
                                  child: SizedBox(
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (_character == SingingCharacter.fixed3) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Parents only"),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Expanded(
                                  child: SizedBox(
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
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (_character == SingingCharacter.fixed1) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1+3",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Expanded(
                                    child: SizedBox(
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
                                Text("1+5"),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Expanded(
                                    child: SizedBox(
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
                                Text("Parents only"),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Expanded(
                                    child: SizedBox(
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Policy Terms"),
        content: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Coverage',
                          style: TextStyle(
                            color: Color.fromARGB(255, 249, 249, 249),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 590,
                        ),
                        Text(
                          'Limits/Remarks',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 249, 249, 249),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 400),
                        Text(
                          'Actions',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 249, 249, 249),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < tableData.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        width: 450,
                        height: 33,
                        child: TextField(
                          controller: tableData[i][0],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a coverage name',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        width: 450,
                        height: 33,
                        child: TextField(
                          controller: tableData[i][1],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Links/Remarks',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_note),
                    ),
                    IconButton(
                      onPressed: () {
                        removeRow(i);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 252, 0, 0),
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 450,
                      height: 33,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a coverage name',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 450,
                      height: 33,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Links/Remarks',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 85,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        tableData.add([
                          TextEditingController(),
                          TextEditingController(),
                        ]);
                        rowCounter++;
                      });
                    },
                    icon: Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Send Rfq"),
        content: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset("assets/images/success.png"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 400.0,
                          child: const Center(
                            child: Text(
                              "Thank You",
                              style: TextStyle(
                                  color: Color(0xFF3EB655), fontSize: 45.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 400.0,
                          child: const Center(
                            child: Text(
                              "Successfully Registered RFQ",
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Color(0xFF747474),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  void onStepBack() {
    if (currentStep == 0) {
      return;
    }
    setState(() {
      currentStep -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepCancel: onStepBack,
          onStepContinue: () {
            bool isLastStep = (currentStep == getSteps().length - 1);
            if (isLastStep) {
            } else {
              setState(() {
                currentStep += 1;
                if (currentStep == 0) {
                  print("0");
                } else if (currentStep == 1) {
                  saveCorporateDetails();
                  Timer timer = Timer(const Duration(seconds: 1), () {
                    toastification.showSuccess(
                      context: context,
                      autoCloseDuration: const Duration(seconds: 2),
                      title: 'Corporate Details sent successfully..',
                    );
                  });
                } else if (currentStep == 2) {
                  createCoverageDetails();
                } else if (currentStep == 3) {
                  print("3: $currentStep");
                  sendDataToApi();
                  Timer timer = Timer(const Duration(seconds: 5), () {
                    Navigator.pushReplacementNamed(context, '/dashboard_page');
                  });
                } else {}
              });
            }
          },
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          steps: getSteps(),
        ),
      ),
    );
  }

  http.MultipartRequest jsonToFormData(
      http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedFile = _bytesData;
        });
      });
      reader.readAsDataUrl(file);
    });
  }
}
