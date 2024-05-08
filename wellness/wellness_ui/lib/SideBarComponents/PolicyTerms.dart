import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PolicyTerms extends StatefulWidget {
  final VoidCallback onContinue;

  const PolicyTerms({super.key, required this.onContinue});

  @override
  _PolicyTermsState createState() => _PolicyTermsState();
}

class _PolicyTermsState extends State<PolicyTerms> {
  List<List<TextEditingController>> tableData = [];

  int rowCounter = 1;

  @override
  void initState() {
    super.initState();
    tableData.add([
      TextEditingController(),
      TextEditingController(),
    ]);
  }

  @override
  void dispose() {
    for (var i = 0; i < tableData.length; i++) {
      tableData[i][0].dispose();
      tableData[i][1].dispose();
    }
    super.dispose();
  }

  void removeRow(int index) {
    setState(() {
      tableData[index][0].clear();
      tableData[index][1].clear();
      tableData.removeAt(index);
      rowCounter--;
    });
  }

  Future<void> sendDataToApi() async {
    try {
      Map<String, dynamic> requestData = {
        'RFQ_ID': '9537705c-cced-4ea1-b113-ae90563e1a11',
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
        print('Data sent successfully');
      } else {
        print('API error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 20), // Add spacing between the table and the buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 75,
              height: 37,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Back'),
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 75,
              height: 37,
              child: ElevatedButton(
                onPressed: () {
                  sendDataToApi().then((_) {
                    widget.onContinue(); // Invoke the onContinue callback
                  });
                },
                child: Text('Next'),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
