import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loginapp/Service.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/Colours.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:html' as html;
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class Master {
  final String employeeNo;
  final String name;
  final String relationShip;
  final String email;
  final String phoneNumber;
  final int sumInsured;
  final String month;

  Master({
    required this.employeeNo,
    required this.name,
    required this.relationShip,
    required this.email,
    required this.phoneNumber,
    required this.sumInsured,
    required this.month,
  });
}

class Claims_PendingList extends StatefulWidget {
  int clientId;
  String productId;
  Claims_PendingList({Key? key, required this.clientId, required this.productId})
      : super(key: key);
  @override
  State<Claims_PendingList> createState() => _Claims_PendingListState();
}

class _Claims_PendingListState extends State<Claims_PendingList> {
  String? _selectedFilter;

  List<String> _filterOptions = [' ', ' ', ' ', ' '];
   List<String> _allOptions = ['All','January', 'February ', 'March ', 
   'April','May','June','July','August','September'
   ,'October','November','December'];
  TextEditingController _searchController = TextEditingController();

  void _handleFilterByChange(String? newValue) {
    setState(() {});
  }

  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      var headers = await ApiServices.getHeaders();

      final uploadApiUrl =
          Uri.parse(ApiServices.baseUrl + ApiServices.getAllMasterList_EndPoint)
              .replace(queryParameters: {
        "clientListId": (widget.clientId).toString(),
        "productId": widget.productId,
      });

      final response = await http.get(uploadApiUrl, headers: headers);

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        if (data != null && data.isNotEmpty) {
          final List<Master> masterList = data
              .map((item) => Master(
                    employeeNo: item['employeeNo'] ?? '',
                    name: item['name'] ?? '',
                    relationShip: item['relationShip'] ?? '',
                    email: item['email'] ?? '',
                    phoneNumber: item['phoneNumber'] ?? '',
                    sumInsured: item['sumInsured'] ?? '',
                    month: item['month'] ?? '',
                  ))
              .toList();

          setState(() {
            _masterList = masterList;
          });
        } else {
          print('Unexpected response format: $data');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (exception) {
      print('Exception: $exception');
    }
  }

  Map<String, dynamic> fileResponses = {};

  void _handleSearch(String value) {}
  http.MultipartRequest jsonToFormData(
      http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  List<Master> _masterList = [];

  final ScrollController _horizontalScrollController = ScrollController();

  List<DataRow> dataRows = [];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context as BuildContext).size.height;
    int? indexNumber;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Pending Claims: "),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "0",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Pending Amount: "),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "0",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),              
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 250,
                        height: 38,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<String>(
                            value: _selectedFilter,
                            onChanged: _handleFilterByChange,
                            items: _allOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child:
                                    Text(value, style: GoogleFonts.poppins()),
                              );
                            }).toList(),
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down),
                            hint:
                                Text('All', style: GoogleFonts.poppins()),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),                   
                    Flexible(
                      child: Container(
                        width: 250,
                        height: 38,
                        child: TextField(
                          controller: _searchController,
                          onChanged: _handleSearch,
                          decoration: InputDecoration(
                            labelText: 'Search',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black26,
                              ),
                              onPressed: () {
                                _handleSearch(_searchController.text);
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Container(
                        width: 250,
                        height: 38,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<String>(
                            value: _selectedFilter,
                            onChanged: _handleFilterByChange,
                            items: _filterOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child:
                                    Text(value, style: GoogleFonts.poppins()),
                              );
                            }).toList(),
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down),
                            hint:
                                Text('Filter By', style: GoogleFonts.poppins()),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Spacer(),
                    Align(
                      child: Container(
                        height: 40,
                        child: ElevatedButton(
                          style: SecureRiskColours.customButtonStyle(),
                          onPressed: () {
                            // exportActiveMemberDetails("member_details_active");
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  'Export',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      child: Container(
                        height: 40,
                        child: ElevatedButton(
                          style: SecureRiskColours.customButtonStyle(),
                          onPressed: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  'upload',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      child: Container(
                        height: 37,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                SecureRiskColours.Button_Color),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.settings, size: 20),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Scrollbar(
                controller:
                    _horizontalScrollController, // Assign the ScrollController
                thickness: 10,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    // width: MediaQuery.of(context).size.width - 32,
                    height: MediaQuery.of(context).size.height - 200,
                    child: DataTable(
                      // columnSpacing: (MediaQuery.of(context).size.width) / 50,
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return SecureRiskColours.Table_Heading_Color;
                      }),
                      columns: [
                        buildDataColumn('S.No'),
                        buildDataColumn('TPA Claim_DetaildId'),
                        buildDataColumn('TPA TPADetailedID'),
                        buildDataColumn('Insurance Company_Name'),
                        buildDataColumn('Policy No'),
                        buildDataColumn('Patient Name'),
                        buildDataColumn('Employee Name'),
                        buildDataColumn('Employee No'),
                        buildDataColumn('Patient Realtion'),
                        buildDataColumn('Date Of_Birth'),
                        buildDataColumn('Sum Insured'),
                        buildDataColumn('Claim ID'),
                      
                        buildDataColumn('Claim Registered_Date'),
                        buildDataColumn('Pre Auth_Sent'),
                        buildDataColumn('Pre Auth_Req_Date'),
                        buildDataColumn('Pre Auth_Sent_Date'),

                        buildDataColumn('Pre Auth_Amount'),
                        buildDataColumn('Claim Amount'),
                        buildDataColumn('Hospital NO'),
                        buildDataColumn('Hospital Name'),
                        buildDataColumn('Hospital City'),
                        buildDataColumn('Hospital State'),
                        buildDataColumn('Ailment'),
                        buildDataColumn('Final Diagnosis'),
                        buildDataColumn('ICD Code'),
                        buildDataColumn('Date Of_Admission'),
                        buildDataColumn('Date Of_Discharge'),
                        buildDataColumn('Deduction Reasons'),
                        buildDataColumn('Date Of_Settlement'),
                        buildDataColumn('Date Of_Payment_To_Provider'),
                        buildDataColumn('Amount_Paid_To_Provider'),
                        buildDataColumn('Amount'),
                        buildDataColumn('Paid Amount'),
                        buildDataColumn('Paid Date'),
                        buildDataColumn('Type Of_Claim'),
                        buildDataColumn('Claim Status'),
                        buildDataColumn('Outstanding Claim Status'),
                        buildDataColumn('Claim Rejection Date'),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('1')),
                          DataCell(Text('Claim Detail ID 1')),
                          DataCell(Text('TPA Detail ID 1')),
                          DataCell(Text('Insurance Company 1')),
                          DataCell(Text('Policy No 1')),
                          DataCell(Text('Patient Name 1')),
                          DataCell(Text('Employee Name 1')),
                          DataCell(Text('Employee No 1')),
                          DataCell(Text('Patient Relation 1')),
                          DataCell(Text('DOB 1')),
                          DataCell(Text('Sum Insured 1')),                        
                          DataCell(Text('Claim ID 1')),

                          DataCell(Text('Registered Date 1')),
                          DataCell(Text('Pre Auth Sent 1')),
                          DataCell(Text('Pre Auth Req Date 1')),
                           DataCell(Text('Pre Auth Sent Date 1')),

                           DataCell(Text('Pre Auth_Amount')),
                           DataCell(Text('Claim Amount')),
                           DataCell(Text('Hospital NO')),
                           DataCell(Text('Hospital Name')),
                           DataCell(Text('Hospital City')),
                           DataCell(Text('Hospital State')),
                           DataCell(Text('Ailment')),
                           DataCell(Text('Final Diagnosis')),
                           DataCell(Text('ICD Code')),
                           DataCell(Text('Date Of_Admission')),
                           DataCell(Text('Date Of_Discharge')),
                           DataCell(Text('Deduction Reasons')),
                           DataCell(Text('Date Of_Settlement')),
                           DataCell(Text('Date Of_Payment_To_Provider')),
                           DataCell(Text('Amount_Paid_To_Provider')),
                           DataCell(Text('Amount')),
                           DataCell(Text('Paid Amount')),
                           DataCell(Text('Paid Date')),
                           DataCell(Text('Type Of_Claim')),
                           DataCell(Text('Claim Status')),
                           DataCell(Text('Outstanding Claim Status')),
                           DataCell(Text('Claim Rejection Date')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('2')),
                          DataCell(Text('Claim Detail ID 1')),
                          DataCell(Text('TPA Detail ID 1')),
                          DataCell(Text('Insurance Company 1')),
                          DataCell(Text('Policy No 1')),
                          DataCell(Text('Patient Name 1')),
                          DataCell(Text('Employee Name 1')),
                          DataCell(Text('Employee No 1')),
                          DataCell(Text('Patient Relation 1')),
                          DataCell(Text('DOB 1')),
                          DataCell(Text('Sum Insured 1')),
                          DataCell(Text('Claim ID 1')),
                         
                          DataCell(Text('Registered Date 1')),
                          DataCell(Text('Pre Auth Sent 1')),
                          DataCell(Text('Pre Auth Req Date 1')),
                           DataCell(Text('Pre Auth Sent Date 1')),

                            DataCell(Text('Pre Auth_Amount')),
                           DataCell(Text('Claim Amount')),
                           DataCell(Text('Hospital NO')),
                           DataCell(Text('Hospital Name')),
                           DataCell(Text('Hospital City')),
                           DataCell(Text('Hospital State')),
                           DataCell(Text('Ailment')),
                           DataCell(Text('Final Diagnosis')),
                           DataCell(Text('ICD Code')),
                           DataCell(Text('Date Of_Admission')),
                           DataCell(Text('Date Of_Discharge')),
                           DataCell(Text('Deduction Reasons')),
                           DataCell(Text('Date Of_Settlement')),
                           DataCell(Text('Date Of_Payment_To_Provider')),
                           DataCell(Text('Amount_Paid_To_Provider')),
                           DataCell(Text('Amount')),
                           DataCell(Text('Paid Amount')),
                           DataCell(Text('Paid Date')),
                           DataCell(Text('Type Of_Claim')),
                           DataCell(Text('Claim Status')),
                           DataCell(Text('Outstanding Claim Status')),
                           DataCell(Text('Claim Rejection Date')),

                        ]),
                      ],
                      // rows:dataRows,
                    ),
                  ),
                ),
              ),
            ])),
      ),
    ));
  }

  DataColumn buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
