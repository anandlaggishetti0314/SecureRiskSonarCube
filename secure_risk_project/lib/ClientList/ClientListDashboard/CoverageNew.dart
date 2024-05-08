import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/Colours.dart';
import 'package:loginapp/Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'dart:html' as html;

class PolicyType extends StatefulWidget {
  int clientId;
  String productIdvar;

  PolicyType({Key? key, required this.clientId, required this.productIdvar})
      : super(key: key);
  // final String? selectedProductName;
  // final String? rfqID;
  // const PolicyType(
  //     {super.key, required this.selectedProductName, required this.rfqID});
  static final GlobalKey<_PolicyTypeState> policy_key =
      GlobalKey<_PolicyTypeState>();

  @override
  _PolicyTypeState createState() => _PolicyTypeState();
}

class CoverageItems {
  String? coverage;
  String? remarks;
  CoverageItems({
    required this.coverage,
    required this.remarks,
  });
}

class _PolicyTypeState extends State<PolicyType> {
  List<Map<String, dynamic>> tableData = [];
  List<CoverageItems> tableData1 = [];
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int rowCounter = 1;
  bool status = true;
  TextEditingController coverageDatacontroller = TextEditingController();
  TextEditingController limitsDatacontroller = TextEditingController();
  List<Map<String, dynamic>> intermerdiaryCoverages = [];

  @override
  void initState() {
    super.initState();
    getCoveragesByProductId();
    //  fetchCoveragesInter();
  }

  bool validate() {
    setState(() {
      status = _formKey.currentState!.validate();
    });
    return status;
  }

  Future<void> getCoveragesByProductId() async {
    final prefs = await SharedPreferences.getInstance();

    final localStorageProdId = widget.productIdvar; //prefs.getInt('productId');
    var headers = await ApiServices.getHeaders();
    if (localStorageProdId == null) {
      ('Product ID not found in SharedPreferences.');
      return;
    }

    try {
      final res = await http.get(
        Uri.parse(ApiServices.baseUrl +
            ApiServices.getPloicyTermsByProductId_Endpoint +
            '$localStorageProdId'),
        headers: headers,
      );

      (res.body);
      final List<dynamic> data = json.decode(res.body);
      if (data != null) {
        setState(() {
          intermerdiaryCoverages =
              (data as List<dynamic>).cast<Map<String, dynamic>>();
        });
      }
      populateTableData();
      print('iter coverages :$intermerdiaryCoverages');
      // for (var coverageName in responseData) {
      //   // tableData.add([
      //   //   TextEditingController(text: coverageName['coverage']),
      //   //   TextEditingController(text: ""),
      //   // ]);
      // }
      //rowEnabledStates = List.generate(tableData.length, (index) => false);
    } catch (e) {
      ('Error: $e');
    }
  }

//   final HttpLink httpLink6 = HttpLink(
//     httpApi.graphqlEndpointApi,
//   );
//   void fetchCoveragesInter() async {
//     final graphQLClient = GraphQLClient(
//       cache: GraphQLCache(),
//       link: httpLink6,
//     );

//     final QueryOptions options = QueryOptions(document: gql('''
//  query GetAllCoveragesByProductName(\$pName:String){
//  getAllCoveragesByProductName(productName:\$pName){

//     id
//     coverage
//     productId
//   }
//   }
// '''), variables: {'pName': widget.selectedProductName});
//     final QueryResult response = await graphQLClient.query(options);
//     if (!response.hasException) {
//       if (mounted) {
//         final dynamic data = response.data;
//         print("Response Data: $data");
//         if (data != null && data['getAllCoveragesByProductName'] != null) {
//           setState(() {
//             intermerdiaryCoverages =
//                 (data['getAllCoveragesByProductName'] as List<dynamic>)
//                     .cast<Map<String, dynamic>>();
//           });
//           print('coveragessdsj@@@@@@@@@@@@@');
//           print(intermerdiaryCoverages.length);
//           populateTableData();
//         }
//       }
//     } else {
//       final errorMessage = response.exception?.graphqlErrors.first.message;
//       print(errorMessage);
//     }
//   }

  void populateTableData() {
    if (intermerdiaryCoverages.isNotEmpty) {
      for (var i = 0; i < intermerdiaryCoverages.length; i++) {
        tableData.add({
          'isEdit': false,
          'data1': intermerdiaryCoverages[i]['coverage'] ?? '',
          'data2': intermerdiaryCoverages[i]['coverageId'].toString() ?? '',
        });
      }
    }
  }

  Future<void> generateCoveragePdf(String fileName) async {
    int clientListId = widget.clientId;
    int? productId = int.tryParse(widget.productIdvar);

    final List<Map<String, dynamic>> pdfData =intermerdiaryCoverages;
    //  [
    //   {"coverageName": "coverage 1", "remark": "remarks 1"},
    //   {"coverageName": "coverage 2", "remark": "remarks 2"},
    //   // Add more payloads as needed
    // ];
    // print('request body details :$pdfData');

    // (pdfData);
    try {
      var headers = await ApiServices.getHeaders();

      final response = await http.post(
        Uri.parse(
            "${ApiServices.baseUrl}${ApiServices.generatePdfMemberdetailsApiEndpoint}?clientListId=$clientListId&productId=$productId"),
        body: jsonEncode(intermerdiaryCoverages), //intermerdiaryCoverages),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final blob = html.Blob([response.bodyBytes], 'application/pdf');
        //  final blob = html.Blob([response.bodyBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);

        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download = fileName;

        anchor.click();
        html.Url.revokeObjectUrl(url);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xFFFFFFFF),
              surfaceTintColor: Colors.white,
              title:
                  Text('Failed', style: GoogleFonts.poppins(color: Colors.red)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.close_rounded, color: Colors.red, size: 48.0),
                  SizedBox(height: 16.0),
                  Text(
                    'Failed to download...!',
                    style: GoogleFonts.poppins(fontSize: 18.0),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text(
                    'close',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('Failed', style: GoogleFonts.poppins(color: Colors.red)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.close_rounded, color: Colors.red, size: 48.0),
                SizedBox(height: 16.0),
                Text(
                  'Failed to download...!',
                  style: GoogleFonts.poppins(fontSize: 18.0),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text(
                  'close',
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Future<void> generateCoveragePdf(String fileName) async {
  //   // int clientListId = widget.clientId;
  //   // int? productId = int.tryParse(widget.productId);

  //   final rfqId = "100Fresh10012024-03-1912:28:20";//widget.rfqId;//prefs.getString('responseBody');
  //   String urlString =
  //       "${ApiServices.baseUrl}${ApiServices.generatePdfMemberdetailsApiEndpoint}$rfqId";

  //   try {
  //     var headers = await ApiServices.getHeaders();
  //     final response = await http.get(
  //       Uri.parse(urlString),
  //       headers: headers,
  //     );

  //     if (response.statusCode == 200) {
  //      final blob = html.Blob([response.bodyBytes], 'application/pdf');
  //     //  final blob = html.Blob([response.bodyBytes]);
  //       final url = html.Url.createObjectUrlFromBlob(blob);

  //       final anchor = html.AnchorElement(href: url)
  //         ..target = 'blank'
  //         ..download = fileName;

  //       anchor.click();
  //       html.Url.revokeObjectUrl(url);
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             backgroundColor: Color(0xFFFFFFFF),
  //             surfaceTintColor: Colors.white,
  //             title:
  //                 Text('Failed', style: GoogleFonts.poppins(color: Colors.red)),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Icon(Icons.close_rounded, color: Colors.red, size: 48.0),
  //                 SizedBox(height: 16.0),
  //                 Text(
  //                   'Failed to download...!',
  //                   style: GoogleFonts.poppins(fontSize: 18.0),
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 child: Text(
  //                   'close',
  //                   style: GoogleFonts.poppins(
  //                     color: Colors.red,
  //                     fontSize: 16.0,
  //                   ),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // Close the dialog
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title:
  //               Text('Failed', style: GoogleFonts.poppins(color: Colors.red)),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Icon(Icons.close_rounded, color: Colors.red, size: 48.0),
  //               SizedBox(height: 16.0),
  //               Text(
  //                 'Failed to download...!',
  //                 style: GoogleFonts.poppins(fontSize: 18.0),
  //               ),
  //             ],
  //           ),
  //           actions: [
  //             TextButton(
  //               child: Text(
  //                 'close',
  //                 style: GoogleFonts.poppins(
  //                   color: Colors.red,
  //                   fontSize: 16.0,
  //                 ),
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // Future<void> createPolicyTerms() async {
  //   // Create a list to hold coverage items
  //   List<CoverageItems> coverageItems = [];
  //   print("Calling creta Policy Terms-----------------**********");

  //   // Iterate through the tableData list to collect data from text fields
  //   for (var i = 0; i < tableData.length; i++) {
  //     // Extract data from text fields in each row
  //     String coverageField = tableData[i]['data1'];
  //     String remark = tableData[i]['data2'];

  //     // Create a CoverageItems object and add it to the list
  //     CoverageItems coverageItem =
  //         CoverageItems(coverage: coverageField, remarks: remark);
  //     coverageItems.add(coverageItem);
  //   }

  //   // String? rfqId = "RFQ320";
  //   final HttpLink httpLink = HttpLink(
  //     httpApi.graphqlEndpointApi,
  //   );
  //   final graphQLClient = GraphQLClient(
  //     cache: GraphQLCache(),
  //     link: httpLink,
  //   );
  //   final MutationOptions options = MutationOptions(
  //     document: gql('''
  //     mutation CreatePolicyTerms(\$policyTerms: PolicyTermsInput!) {
  //       createPolicyTerms(policyTerms: \$policyTerms) {
  //         rfqId
  //         coverageItems {
  //           coverageField
  //           remark
  //         }
  //       }
  //     }
  //   '''),
  //     variables: {
  //       'policyTerms': {
  //         'rfqId': widget.rfqID,
  //         'coverageItems': coverageItems.map((item) {
  //           return {
  //             'coverageField': item.coverage,
  //             'remark': item.remarks,
  //           };
  //         }).toList(),
  //       },
  //     },
  //   );

  //   final QueryResult result = await graphQLClient.mutate(options);

  //   if (result.hasException) {
  //     print('GraphQL Error: ${result.exception}');
  //   } else {
  //     print('Mutation Result: ${result.data}');
  //   }
  // }

  void showCustomAlertDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 80, right: 20),
            child: Material(
              type: MaterialType.transparency,
              child: AlertDialog(
                title: Text(
                  'Error',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.normal),
                ),
                content: Text(errorMessage),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(maxHeight: double.infinity),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Proposed Scope of Cover",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                //  color: SecureRiskColours.blueshade,
                height: 30,
                width: 1500,
                child: Row(
                  children: [
                    Text(
                      'Coverage',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                    Text(
                      'Limits/Remarks',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                    Text(
                      'Actions',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              for (var i = 0; i < tableData.length; i++) buildDataRow(i),
              Scrollbar(
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(right: 48, bottom: 10),
                            child: TextFormField(
                              controller: coverageDatacontroller,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 38),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: 'Type of Policy',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              validator: (value) {
                                if (value!.length > 100) {
                                  return 'Exceeded character limit';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(right: 48, bottom: 10),
                            child: TextFormField(
                              controller: limitsDatacontroller,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 38),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: 'Limits/Remarks',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 67,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
// Extract the text from the controllers
                            String textFromData1 = coverageDatacontroller.text;
                            String textFromData2 = limitsDatacontroller.text;

// Create a new row with empty 'data1' and 'data2' fields
                            Map<String, dynamic> newRow = {
                              'isEdit': false,
                              'data1': textFromData1,
                              'data2': textFromData2
                            };

// Add the new row to tableData
                            tableData.add(newRow);

// Clear the controllers for next input
                            coverageDatacontroller.clear();
                            limitsDatacontroller.clear();
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                child: Container(
                  height: 40,
                  width: 220,
                  child: ElevatedButton(
                    style: SecureRiskColours.customButtonStyle(),
                    onPressed: () {
                      generateCoveragePdf("member_details_coverage");
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 5),
                          Text(
                            'Generate PDF',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ],
                      ),
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

  Widget buildDataRow(int i) {
    // Create controllers for the text fields
    TextEditingController data1Controller = TextEditingController();
    TextEditingController data2Controller = TextEditingController();

    // Initialize the controllers with the current values if needed
    data1Controller.text = tableData[i]['data1'];
    data2Controller.text = tableData[i]['data2'];

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 16, bottom: 10),
            child: TextField(
              enabled: tableData[i]['isEdit'],
              controller: data1Controller, // Assign the controller
              onChanged: (value) {
                tableData[i]['data1'] = value;
              },
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Type of Policy',
                hintStyle: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 16, bottom: 10),
            child: TextField(
              enabled: tableData[i]['isEdit'],
              controller: data2Controller, // Assign the controller
              onChanged: (value) {
                tableData[i]['data2'] = value;
              },
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Limits/Remarks',
                hintStyle: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              tableData[i]['isEdit'] = !tableData[i]['isEdit'];
            });
          },
          icon: Icon(tableData[i]['isEdit']
              ? Icons.edit_calendar_rounded
              : Icons.edit_note),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              tableData.removeAt(i);
            });
          },
          icon: Icon(
            Icons.delete,
            color: Color.fromARGB(255, 252, 0, 0),
          ),
        ),
      ],
    );
  }
}
