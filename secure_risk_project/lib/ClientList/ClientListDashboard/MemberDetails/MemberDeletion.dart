import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:loginapp/Colours.dart';
import 'package:loginapp/Service.dart';

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

class MemberDeletion extends StatefulWidget {
  int clientId;
  String productId;
  MemberDeletion({Key? key, required this.clientId, required this.productId})
      : super(key: key);

  @override
  State<MemberDeletion> createState() => _MemberDeletionState();
}

class _MemberDeletionState extends State<MemberDeletion> {
  String? _selectedFilter;
  void _handleSearch(String value) {}

  void _handleFilterByChange(String? newValue) {
    setState(() {});
  }

  TextEditingController _searchController = TextEditingController();
  List<String> _filterOptions = [
    'Employee No',
    'Name',
    'Relationship',
    'Email'
  ];
  List<Master> _masterList = [];
  void initState() {
    super.initState();
    _fetchData();
  }

  exportDeletionMemberDetails(String fileName) async {
    int clientListId = widget.clientId;
    int? productId = int.tryParse(widget.productId);

    String urlString =
        "${ApiServices.baseUrl}${ApiServices.exportMemberDetailsDeletionApi}clientListId=$clientListId&productId=$productId";

    try {
      var headers = await ApiServices.getHeaders();
      final response = await http.get(
        Uri.parse(urlString),
        headers: headers,
      );

      if (response.statusCode == 200) {
        //final blob = html.Blob([response.bodyBytes]);
        final blob = html.Blob([
          response.bodyBytes
        ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
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

  deletionMemberDetailsDownloadTemplate(String fileName) async {
    String urlString =
        "${ApiServices.baseUrl}${ApiServices.deletedListDownloadTemplate}";

    try {
      var headers = await ApiServices.getHeaders();
      final response = await http.get(
        Uri.parse(urlString),
        headers: headers,
      );

      if (response.statusCode == 200) {
        //final blob = html.Blob([response.bodyBytes]);
        final blob = html.Blob([
          response.bodyBytes
        ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
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

  Future<void> _fetchData() async {
    try {
      var headers = await ApiServices.getHeaders();

      final uploadApiUrl =
          Uri.parse(ApiServices.baseUrl + ApiServices.deletionMemberDetails)
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(20.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.5),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: Offset(0, 3),
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //           padding: EdgeInsets.all(15.0),
  //           child: Column(children: [
  //             Padding(
  //               padding: EdgeInsets.all(15.0),
  //               child: Row(
  //                 children: [
  //                   Flexible(
  //                     child: Container(
  //                       width: 300,
  //                       height: 38,
  //                       child: TextField(
  //                         controller: _searchController,
  //                         onChanged: _handleSearch,
  //                         decoration: InputDecoration(
  //                           labelText: 'Search',
  //                           suffixIcon: IconButton(
  //                             icon: Icon(
  //                               Icons.search,
  //                               color: Colors.black26,
  //                             ),
  //                             onPressed: () {
  //                               _handleSearch(_searchController.text);
  //                             },
  //                           ),
  //                           border: OutlineInputBorder(
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(5)),
  //                             borderSide: BorderSide(color: Colors.black),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Flexible(
  //                     child: Container(
  //                       width: 250,
  //                       height: 38,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(color: Colors.black26),
  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
  //                       ),
  //                       child: Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 8.0),
  //                         child: DropdownButton<String>(
  //                           value: _selectedFilter,
  //                           onChanged: _handleFilterByChange,
  //                           items: _filterOptions.map((String value) {
  //                             return DropdownMenuItem<String>(
  //                               value: value,
  //                               child:
  //                                   Text(value, style: GoogleFonts.poppins()),
  //                             );
  //                           }).toList(),
  //                           isExpanded: true,
  //                           underline: SizedBox(),
  //                           icon: Icon(Icons.arrow_drop_down),
  //                           hint:
  //                               Text('Filter By', style: GoogleFonts.poppins()),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Spacer(),
  //                   Spacer(),
  //                   Spacer(),
  //                   Spacer(),
  //                   Align(
  //                     child: Container(
  //                       height: 40,
  //                       child: ElevatedButton(
  //                         style: SecureRiskColours.customButtonStyle(),
  //                         onPressed: () {
  //                           exportDeletionMemberDetails("member_details_deletions");
  //                         },
  //                         child: Container(
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               SizedBox(width: 5),
  //                               Text(
  //                                 'Export',
  //                                 style:
  //                                     GoogleFonts.poppins(color: Colors.white),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   Align(
  //                     child: Container(
  //                       height: 40,
  //                       child: ElevatedButton(
  //                         style: SecureRiskColours.customButtonStyle(),
  //                         onPressed: () {},
  //                         child: Container(
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               SizedBox(width: 5),
  //                               Text(
  //                                 'upload',
  //                                 style:
  //                                     GoogleFonts.poppins(color: Colors.white),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   Align(
  //                     child: Container(
  //                       height: 40,
  //                       child: ElevatedButton(
  //                         style: SecureRiskColours.customButtonStyle(),
  //                         onPressed: () {},
  //                         child: Container(
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               SizedBox(width: 5),
  //                               Text(
  //                                 'Download Template',
  //                                 style:
  //                                     GoogleFonts.poppins(color: Colors.white),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   Align(
  //                     child: Container(
  //                       height: 37,
  //                       child: ElevatedButton(
  //                         style: ButtonStyle(
  //                           backgroundColor: MaterialStateProperty.all(
  //                               SecureRiskColours.Button_Color),
  //                           shape: MaterialStateProperty.all(
  //                             RoundedRectangleBorder(
  //                               side: BorderSide(
  //                                 color: Colors.black.withOpacity(0.2),
  //                               ),
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                           ),
  //                         ),
  //                         onPressed: () {},
  //                         child: IconButton(
  //                           onPressed: () {},
  //                           icon: Icon(Icons.settings, size: 20),
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
  //               child: SingleChildScrollView(
  //                 physics: AlwaysScrollableScrollPhysics(),
  //                 scrollDirection: Axis.vertical,
  //                   child: SizedBox(
  //     height: MediaQuery.of(context).size.height - 200,
  //                 child: DataTable(
  //                     columnSpacing: 105,
  //                     headingRowColor: MaterialStateProperty.resolveWith<Color>(
  //                         (Set<MaterialState> states) {
  //                       return SecureRiskColours.Table_Heading_Color;
  //                     }),
  //                     columns: [
  //                       buildDataColumn('No'),
  //                       buildDataColumn('Name'),
  //                       buildDataColumn('Relationship'),
  //                       buildDataColumn('Email'),
  //                       buildDataColumn('Phone'),
  //                       buildDataColumn('Sum'),
  //                       buildDataColumn('Status'),
  //                       buildDataColumn('Month'),
  //                     ],
  //                     rows: _masterList
  //                         .map((ends) => DataRow(cells: [
  //                               DataCell(Text(ends.employeeNo)),
  //                               DataCell(Text(ends.name)),
  //                               DataCell(Text(ends.relationShip)),
  //                               DataCell(Text(ends.email)),
  //                               DataCell(Text(ends.phoneNumber)),
  //                               DataCell(Text(ends.sumInsured.toString())),
  //                               DataCell(Text("Active")),
  //                               DataCell(Text("June")), //ends.month)),
  //                             ]))
  //                         .toList()),
  //               ),
  //               ),
  //             ),
  //           ])),
  //     ),
  //   ));
  // }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            padding: EdgeInsets.all(15.0),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 300,
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
                    // Spacer(),
                    // Spacer(),
                    // Spacer(),
                    Align(
                      child: Container(
                        height: 40,
                        child: ElevatedButton(
                          style: SecureRiskColours.customButtonStyle(),
                          onPressed: () {
                            exportDeletionMemberDetails(
                                "member_details_deletion");
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
                    Align(
                      child: Container(
                        height: 40,
                        child: ElevatedButton(
                          style: SecureRiskColours.customButtonStyle(),
                          onPressed: () {
                            deletionMemberDetailsDownloadTemplate(
                                "deletedList");
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  'Download Template',
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
                            color: Colors.white, //black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.8,
                width: screenWidth * 0.8,
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: DataTable(
                        columnSpacing: 65,
                        headingRowColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          return SecureRiskColours.Table_Heading_Color;
                        }),
                        columns: [
                          buildDataColumn('No'),
                          buildDataColumn('Name'),
                          buildDataColumn('Relationship'),
                          buildDataColumn('Email'),
                          buildDataColumn('Phone'),
                          buildDataColumn('Sum'),
                          buildDataColumn('Status'),
                          buildDataColumn('Month'),
                        ],
                        rows: _masterList
                            .map((ends) => DataRow(cells: [
                                  DataCell(Text(ends.employeeNo)),
                                  DataCell(Text(ends.name)),
                                  DataCell(Text(ends.relationShip)),
                                  DataCell(Text(ends.email)),
                                  DataCell(Text(ends.phoneNumber)),
                                  DataCell(Text(ends.sumInsured.toString())),
                                  DataCell(Text("Active")),
                                  DataCell(Text("June")), //ends.month)),
                                ]))
                            .toList()),
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
