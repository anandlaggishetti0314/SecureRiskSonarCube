import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:loginapp/Colours.dart';
import 'package:loginapp/Service.dart';
import '../FreshPolicyFields/CustonDropdown.dart';
import 'package:intl/intl.dart';

final TextEditingController policyNumber = TextEditingController();
final TextEditingController startPeriod = TextEditingController();
final TextEditingController endPeriod = TextEditingController();
final TextEditingController premiumPaidInception = TextEditingController();
final TextEditingController premium = TextEditingController();
final TextEditingController additionPremium = TextEditingController();
final TextEditingController deletionPremium = TextEditingController();
final TextEditingController policyType = TextEditingController();
final TextEditingController activeYears = TextEditingController();
final TextEditingController membersNoInception = TextEditingController();
final TextEditingController additions = TextEditingController();
final TextEditingController deletions = TextEditingController();
final TextEditingController totalMembers = TextEditingController();
final TextEditingController membersNum = TextEditingController();
final TextEditingController familyDefination = TextEditingController();
final TextEditingController dependentMember = TextEditingController();
final TextEditingController familiesNum = TextEditingController();
final TextEditingController additionalRelationShip = TextEditingController();
final TextEditingController familyDefinationRevision = TextEditingController();
final TextEditingController createDate = TextEditingController();
final TextEditingController updateDate = TextEditingController();
final TextEditingController recordStatus = TextEditingController();
String? policyCoverage = "NO";
String? anyCoverage;

// ignore: must_be_immutable
class RenewalEditExpiryDetails extends StatefulWidget {
  late String rfid;
  RenewalEditExpiryDetails({super.key, required this.rfid});

  @override
  State<RenewalEditExpiryDetails> createState() =>
      RenewalEditExpiryDetailsState();

  Future<void> updateRenewalExpiryeDetails(BuildContext context) async {
    var body = {
      "policyNumber": policyNumber.text,
      "startPeriod": startPeriod.text,
      "endPeriod": endPeriod.text,
      "premiumPaidInception": premiumPaidInception.text,
      "premium": premium.text,
      "additionPremium": additionPremium.text,
      "deletionPremium": deletionPremium.text,
      "policyType": policyType.text,
      "activeYears": activeYears.text.isEmpty ? 0 : activeYears.text,
      "membersNoInception": membersNoInception.text,
      "additions": additions.text,
      "deletions": deletions.text,
      "totalMembers": totalMembers.text,
      "membersNum": membersNum.text,
      "dependentMember": dependentMember.text,
      "familyDefination": familyDefination.text,
      "familiesNum": familiesNum.text,
      "additionalRelationShip": policyCoverage,
      //additionalRelationShip.text,
      "familyDefinationRevision":anyCoverage,
      // familyDefinationRevision.text,
      "createDate": createDate.text,
      "updateDate": updateDate.text,
      "recordStatus": recordStatus.text
    };
    var headers = await ApiServices.getHeaders();
    Response response = await http.put(
      Uri.parse(ApiServices.baseUrl +
          ApiServices.update_Renewal_ExpiryDetails_EndPoint +
          rfid),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ('EditCorporateDetails saved successfully');
    } else {}
  }

  static void renewalEditExpiryDetailsclearFields() {
    policyNumber.text = "";
    startPeriod.text = "";
    endPeriod.text = "";
    premiumPaidInception.text = "";
    premium.text = "";
    additionPremium.text = "";
    deletionPremium.text = "";
    policyType.text = "";
    activeYears.text = "";
    membersNoInception.text = "";
    additions.text = "";
    deletions.text = "";
    totalMembers.text = "";
    membersNum.text = "";
    familyDefination.text = "";
    dependentMember.text = "";
    familiesNum.text = "";
  }
}

class RenewalEditExpiryDetailsState extends State<RenewalEditExpiryDetails> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // debugger();
    fetch();
    expiryDetails();
  }

  bool validateExpiryDetails() {
    if (formKey.currentState == null) {
      return false; // Handle the case when formKey or currentState is null
    }

    bool status = formKey.currentState!.validate();

    return status;
  }

  late final localstorageProductId;
  late final localstorageProdCategoryId;

  Future<void> fetch() async {
    String rfid = widget.rfid;
    var headers = await ApiServices.getHeaders();
    Response response = await http.get(
        Uri.parse(ApiServices.baseUrl +
            ApiServices.EditCorporate_Details_EndPoint +
            rfid),
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      localstorageProductId = jsonData["corporateDetails"]['productId'];
      localstorageProdCategoryId =
          jsonData["corporateDetails"]['prodCategoryId'];
    }
  }

  Future<void> expiryDetails() async {
    String rfid = widget.rfid;

    var headers = await ApiServices.getHeaders();
    Response response = await http.get(
      Uri.parse(ApiServices.baseUrl +
          ApiServices.Renewal_EditExpiry_Details_EndPoint +
          rfid),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      setState(() {
        policyNumber.text = jsonData['policyNumber'];
        startPeriod.text = jsonData['startPeriod'];
        endPeriod.text = jsonData['endPeriod'];
        policyType.text = jsonData['policyType'];

        double premiumPaidInceptionValue = jsonData['premiumPaidInception'];
        premiumPaidInception.text = premiumPaidInceptionValue.toString();

        // premium.text = jsonData['premium'];
        double premiumValue = jsonData['premium'];
        premium.text = premiumValue.toString();

        double additionPremiumValue = jsonData['additionPremium'];
        additionPremium.text = additionPremiumValue.toString();

        double deletionPremiumValue = jsonData['deletionPremium'];
        deletionPremium.text = deletionPremiumValue.toString();
        // deletionPremium.text = jsonData['deletionPremium'];

        policyType.text = jsonData['policyType'];

        double activeYearsValue = jsonData['activeYears'];
        activeYears.text = activeYearsValue.toString();
        // activeYears.text = jsonData['activeYears'];

        double membersNoInceptionValue = jsonData['membersNoInception'];
        membersNoInception.text = membersNoInceptionValue.toString();
        // membersNoInception.text = jsonData['membersNoInception'];

        double additionsValue = jsonData['additions'];
        additions.text = additionsValue.toString();
        // additions.text = jsonData['additions'];

        double deletionsValue = jsonData['deletions'];
        deletions.text = deletionsValue.toString();
        // deletions.text = jsonData['deletions'];

        double totalMembersValue = jsonData['totalMembers'];
        totalMembers.text = totalMembersValue.toString();

        double MembersValue = jsonData['membersNum'];
        membersNum.text = MembersValue.toString();

        dependentMember.text = jsonData['dependentMember'];

        familyDefination.text = jsonData['familyDefination'];

        double familiesNumValue = jsonData['familiesNum'];
        familiesNum.text = familiesNumValue.toString();
      });
      ('Expiring Detail saved successfully premium:');
    } else {
      ('Failed to save RenwalEditExpiry Details');
    }
  }

  String? policyError = "";

  String? startPeriodError = "";

  String? endPeriodError = "";

  String? premiumPaidInceptionError = "";

  String? premiumError = "";

  String? additionPremiumError = "";

  String? deletionPremiumError = "";

  String? policyTypeError = "";

  String? activeYearsError = "";

  String? membersNoInceptionError = "";

  String? additionsError = "";

  String? deletionsError = "";

  String? totalMembersError = "";

  String? membersNumError = "";

  String? familyDefinationError = "";

  String? dependentMemberError = "";

  String? familiesNumError = "";

  String? validateString(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Field is mandatory';
    }
    return null;
  }

  List<String> productCategories = [
    'YES',
    'NO',
  ];

  List<String> AnyCategory = [
    'YES',
    'NO',
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (localstorageProdCategoryId == 100 &&
                localstorageProductId == 1001) ...[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Align children to the left
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align children to the start of the cross axis (left)
                            children: [
                              Container(
                                width: screenWidth * 0.4,
                                child: AppBar(
                                  toolbarHeight: SecureRiskColours.AppbarHeight,
                                  backgroundColor:
                                      SecureRiskColours.Table_Heading_Color,
                                  title: Text(
                                    "Expiry Details",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  elevation: 5,
                                  automaticallyImplyLeading: false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Policy Number",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  height: policyError == null ||
                                          policyError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: policyNumber,
                                        decoration: InputDecoration(
                                          hintText: 'Policy Number',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            policyError = validateString(value);
                                          });
                                          return policyError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Start Date",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  height: startPeriodError == null ||
                                          startPeriodError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: startPeriod,
                                        readOnly:
                                            true, // Prevents manual text input
                                        decoration: InputDecoration(
                                          hintText: 'Start Date',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          suffixIcon: GestureDetector(
                                            // onTap: () async {
                                            //   DateTime? selectedDate =
                                            //       await showDatePicker(
                                            //     context: context,
                                            //     initialDate: DateTime.now(),
                                            //     firstDate: DateTime(2000),
                                            //     lastDate: DateTime(2101),
                                            //   );

                                            //   if (selectedDate != null) {
                                            //     String formattedDate =
                                            //         "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                            //     startPeriod.text =
                                            //         formattedDate;
                                            //   }
                                            // },
                                            onTap: () async {
                                              DateTime? selectedStartDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime
                                                    .now(), // Initial date for the picker
                                                firstDate: DateTime(
                                                    2000), // Earliest selectable date
                                                lastDate: DateTime(
                                                    2101), // Latest selectable date
                                              );

                                              if (selectedStartDate != null) {
                                                // Format and set the start date
                                                startPeriod.text =
                                                    // DateFormat('dd-MM-yyyy')
                                                    //     .format(selectedStartDate);
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(
                                                            selectedStartDate);

                                                // Calculate the end date (one year later, minus one day)
                                                DateTime endDate = DateTime(
                                                        selectedStartDate.year +
                                                            1,
                                                        selectedStartDate.month,
                                                        selectedStartDate.day)
                                                    .subtract(
                                                        Duration(days: 1));

                                                // Format and set the end date
                                                // endPeriod.text = DateFormat('dd-MM-yyyy')
                                                //     .format(endDate);
                                                endPeriod.text =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(endDate);
                                              }
                                            },
                                            child: Icon(
                                              Icons.calendar_month_sharp,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            startPeriodError =
                                                validateString(value);
                                          });
                                          return startPeriodError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("End Date",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  height: endPeriodError == null ||
                                          endPeriodError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: endPeriod,
                                        readOnly:
                                            true, // Prevents manual text input
                                        decoration: InputDecoration(
                                          hintText: 'End Date',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          suffixIcon: GestureDetector(
                                            // onTap: () async {
                                            //   DateTime? selectedDate =
                                            //       await showDatePicker(
                                            //     context: context,
                                            //     initialDate: DateTime.now(),
                                            //     firstDate: DateTime(2000),
                                            //     lastDate: DateTime(2101),
                                            //   );

                                            //   if (selectedDate != null) {
                                            //     String formattedDate =
                                            //         "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                            //     endPeriod.text = formattedDate;
                                            //   }
                                            // },
                                            child: Icon(
                                              Icons.calendar_month_sharp,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            endPeriodError =
                                                validateString(value);
                                          });
                                          return endPeriodError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding:  EdgeInsets.only(top: 15),
                              //   child: Text(
                              //     "Premium Details",
                              //     style: GoogleFonts.poppins(
                              //       color: Color.fromRGBO(0, 0, 0, 1),
                              //       fontSize: 15,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: AppBar(
                                  toolbarHeight: SecureRiskColours.AppbarHeight,
                                  backgroundColor:
                                      SecureRiskColours.Table_Heading_Color,
                                  title: Text(
                                    "Premium Details",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  elevation: 5,
                                  automaticallyImplyLeading: false,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Premium Paid at Inception",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  height: premiumPaidInceptionError == null ||
                                          premiumPaidInceptionError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: premiumPaidInception,
                                        decoration: InputDecoration(
                                          hintText: 'Premium Paid at Inception',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            premiumPaidInceptionError =
                                                validateString(value);
                                          });
                                          return premiumPaidInceptionError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("As on Date Premium",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  height: premiumError == null ||
                                          premiumError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: premium,
                                        decoration: InputDecoration(
                                          hintText: 'As on Date Premium',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            premiumError =
                                                validateString(value);
                                          });
                                          return premiumError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Addition Premium",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  height: additionPremiumError == null ||
                                          additionPremiumError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: additionPremium,
                                        decoration: InputDecoration(
                                          hintText: 'Addition Premium',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            additionPremiumError =
                                                validateString(value);
                                          });
                                          return additionPremiumError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Deletion Premium",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  height: deletionPremiumError == null ||
                                          deletionPremiumError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: deletionPremium,
                                        decoration: InputDecoration(
                                          hintText: 'Deletion Premium',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            deletionPremiumError =
                                                validateString(value);
                                          });
                                          return deletionPremiumError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Policy Type",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  height: policyTypeError == null ||
                                          policyTypeError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        controller: policyType,
                                        decoration: InputDecoration(
                                          hintText: 'Policy Type',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          setState(() {
                                            policyTypeError =
                                                validateString(value);
                                          });
                                          return policyTypeError;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text("Active Years",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Color.fromRGBO(25, 26, 25, 1))),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  height: activeYearsError == null ||
                                          activeYearsError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                                  width: screenWidth * 0.23,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Material(
                                      shadowColor: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly // Allow only numeric input
                                        ],
                                        onChanged: (value) {
                                          activeYears.text =
                                              value; // Update the value of the TextFormField
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Active Years',
                                          hintStyle:
                                              GoogleFonts.poppins(fontSize: 13),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        // Set the initial value to "N/A" if the field is empty
                                        // initialValue: !.isEmpty
                                        //     ? 'N/A'
                                        //     : _textFieldValue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.99,
                child: VerticalDivider(
                  color: Color.fromARGB(255, 82, 81, 81),
                  thickness: 1,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Align children to the left
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align children to the start of the cross axis (left)
                          children: [
                            // Padding(
                            //   padding:  EdgeInsets.all(0),
                            //   child: Text(
                            //     "Member Details Expiring Year",
                            //     style: GoogleFonts.poppins(
                            //       color: Color.fromRGBO(0, 0, 0, 1),
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            AppBar(
                              toolbarHeight: SecureRiskColours.AppbarHeight,
                              backgroundColor:
                                  SecureRiskColours.Table_Heading_Color,
                              title: Text(
                                "Member Details Expiring Year",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              elevation: 5,
                              automaticallyImplyLeading: false,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("No.of Members at Inception",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: membersNoInceptionError == null ||
                                        membersNoInceptionError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: membersNoInception,
                                      decoration: InputDecoration(
                                        hintText: 'No.of Members at Inception',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          membersNoInceptionError =
                                              validateString(value);
                                        });
                                        return membersNoInceptionError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("Additions During the year",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: additionsError == null ||
                                        additionsError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: additions,
                                      decoration: InputDecoration(
                                        hintText: 'Additions During the year',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          additionsError =
                                              validateString(value);
                                        });
                                        return additionsError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("Deletion During the year",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: deletionsError == null ||
                                        deletionsError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: deletions,
                                      decoration: InputDecoration(
                                        hintText: 'Deletion During the year',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          deletionsError =
                                              validateString(value);
                                        });
                                        return deletionsError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("Total Members as on Date",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: totalMembersError == null ||
                                        totalMembersError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: totalMembers,
                                      decoration: InputDecoration(
                                        hintText: 'Total Members as on Date',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          totalMembersError =
                                              validateString(value);
                                        });
                                        return totalMembersError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding:  EdgeInsets.only(top: 15),
                            //   child: Text(
                            //     "Renewal Details",
                            //     style: GoogleFonts.poppins(
                            //       color: Color.fromRGBO(0, 0, 0, 1),
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: AppBar(
                                toolbarHeight: SecureRiskColours.AppbarHeight,
                                backgroundColor:
                                    SecureRiskColours.Table_Heading_Color,
                                title: Text(
                                  "Renewal Details",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                elevation: 5,
                                automaticallyImplyLeading: false,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("No.of Members to be Covered",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: membersNumError == null ||
                                        membersNumError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: membersNum,
                                      decoration: InputDecoration(
                                        hintText: 'No.of Members to be Covered',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          membersNumError =
                                              validateString(value);
                                        });
                                        return membersNumError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("Dependent",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: dependentMemberError == null ||
                                        dependentMemberError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: dependentMember,
                                      decoration: InputDecoration(
                                        hintText: 'Dependent',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          dependentMemberError =
                                              validateString(value);
                                        });
                                        return dependentMemberError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding:  EdgeInsets.only(top: 10.0),
                            //   child: Text(
                            //     "Family Defination",
                            //     style: GoogleFonts.poppins(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold,
                            //       color: Color.fromRGBO(0, 0, 0, 1),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: AppBar(
                                toolbarHeight: SecureRiskColours.AppbarHeight,
                                backgroundColor:
                                    SecureRiskColours.Table_Heading_Color,
                                title: Text(
                                  "Family Defination",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                elevation: 5,
                                automaticallyImplyLeading: false,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: familyDefinationError == null ||
                                        familyDefinationError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: familyDefination,
                                      decoration: InputDecoration(
                                        hintText: 'Family Defination',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          familyDefinationError =
                                              validateString(value);
                                        });
                                        return familyDefinationError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("No.of Families",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: familiesNumError == null ||
                                        familiesNumError!.isEmpty
                                    ? 40.0
                                    : 65.0,
                                width: screenWidth * 0.23,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Material(
                                    shadowColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: TextFormField(
                                      controller: familiesNum,
                                      decoration: InputDecoration(
                                        hintText: 'No.of Families',
                                        hintStyle:
                                            GoogleFonts.poppins(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        setState(() {
                                          familiesNumError =
                                              validateString(value);
                                        });
                                        return familiesNumError;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (localstorageProductId == 1001)
                              // Padding(
                              //   padding:  EdgeInsets.only(top: 10.0),
                              //   child: Text("Family Details",
                              //       style: GoogleFonts.poppins(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold,
                              //         color: Color.fromRGBO(0, 0, 0, 1),
                              //       )),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: AppBar(
                                  toolbarHeight: SecureRiskColours.AppbarHeight,
                                  backgroundColor:
                                      SecureRiskColours.Table_Heading_Color,
                                  title: Text(
                                    "Family Details",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  elevation: 5,
                                  automaticallyImplyLeading: false,
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                '''Family Defination whether additional children covered whether 
    additional relationships covered (like brother/sister etc.)''',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Color.fromRGBO(25, 26, 25, 1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: CustomDropdown(
                                value: policyCoverage,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    policyCoverage = newValue;
                                    // showCustomTextField = newValue == 'Custom';
                                    // _formSubmitted = false;
                                  });
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      //  'Family Details',
                                      " ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                      ),
                                    ), // default label
                                  ),
                                  ...productCategories.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                  '''Any revision required in family defination under renewal policy 
    (please specify if Yes)''',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color.fromRGBO(25, 26, 25, 1))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: CustomDropdown(
                                value: anyCoverage,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    anyCoverage = newValue;
                                  });
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      'Family Details',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                      ),
                                    ), // default label
                                  ),
                                  ...AnyCategory.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ] else ...[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Align children to the left
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align children to the start of the cross axis (left)
                        children: [
                          // Padding(
                          //   padding:  EdgeInsets.all(0),
                          //   child: Text(
                          //     "Expiry Details",
                          //     style: GoogleFonts.poppins(
                          //       color: Color.fromRGBO(0, 0, 0, 1),
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            width: screenWidth * 0.55,
                            child: AppBar(
                              toolbarHeight: SecureRiskColours.AppbarHeight,
                              backgroundColor:
                                  SecureRiskColours.Table_Heading_Color,
                              title: Text(
                                "Expiry Details",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              elevation: 5,
                              automaticallyImplyLeading: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Policy Number",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                              height:
                                  policyError == null || policyError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: policyNumber,
                                    decoration: InputDecoration(
                                      hintText: 'Policy Number',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        policyError = validateString(value);
                                      });
                                      return policyError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Start Date",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: startPeriodError == null ||
                                      startPeriodError!.isEmpty
                                  ? 40.0
                                  : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: startPeriod,
                                    readOnly:
                                        true, // Prevents manual text input
                                    decoration: InputDecoration(
                                      hintText: 'Start Date',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      suffixIcon: GestureDetector(
                                        // onTap: () async {
                                        //   DateTime? selectedDate =
                                        //       await showDatePicker(
                                        //     context: context,
                                        //     initialDate: DateTime.now(),
                                        //     firstDate: DateTime(2000),
                                        //     lastDate: DateTime(2101),
                                        //   );

                                        //   if (selectedDate != null) {
                                        //     String formattedDate =
                                        //         "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                        //     startPeriod.text = formattedDate;
                                        //   }
                                        // },

                                        //   if (selectedDate != null) {
                                        //     String formattedDate =
                                        //         "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                        //     startPeriod.text = formattedDate;
                                        //   }
                                        // },
                                        onTap:
                                            // () => _selectStartDate(context),
                                            () async {
                                          DateTime? selectedStartDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime
                                                .now(), // Initial date for the picker
                                            firstDate: DateTime(
                                                2000), // Earliest selectable date
                                            lastDate: DateTime(
                                                2101), // Latest selectable date
                                          );

                                          if (selectedStartDate != null) {
                                            // Format and set the start date
                                            startPeriod.text =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(selectedStartDate);

                                            // Calculate the end date (one year later, minus one day)
                                            DateTime endDate = DateTime(
                                                    selectedStartDate.year + 1,
                                                    selectedStartDate.month,
                                                    selectedStartDate.day)
                                                .subtract(Duration(days: 1));

                                            // Format and set the end date
                                            endPeriod.text =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(endDate);
                                          }
                                        },

                                        child: Icon(
                                          Icons.calendar_month_sharp,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        startPeriodError =
                                            validateString(value);
                                      });
                                      return startPeriodError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("End Date",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: endPeriodError == null ||
                                      endPeriodError!.isEmpty
                                  ? 40.0
                                  : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: endPeriod,
                                    readOnly:
                                        true, // Prevents manual text input
                                    decoration: InputDecoration(
                                      hintText: 'End Date',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      suffixIcon: GestureDetector(
                                        // onTap: () async {
                                        //   DateTime? selectedDate =
                                        //       await showDatePicker(
                                        //     context: context,
                                        //     initialDate: DateTime.now(),
                                        //     firstDate: DateTime(2000),
                                        //     lastDate: DateTime(2101),
                                        //   );

                                        //   if (selectedDate != null) {
                                        //     String formattedDate =
                                        //         "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                        //     endPeriod.text = formattedDate;
                                        //   }
                                        // },
                                        child: Icon(
                                          Icons.calendar_month_sharp,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        endPeriodError = validateString(value);
                                      });
                                      return endPeriodError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: screenWidth * 0.55,
                            child: AppBar(
                              toolbarHeight: SecureRiskColours.AppbarHeight,
                              backgroundColor:
                                  SecureRiskColours.Table_Heading_Color,
                              title: Text(
                                "Premium Details",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              elevation: 5,
                              automaticallyImplyLeading: false,
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 10),
                          //   child: Text(
                          //     "Premium Details",
                          //     style: GoogleFonts.poppins(
                          //       color: Color.fromRGBO(0, 0, 0, 1),
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Premium Paid at Inception",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: premiumPaidInceptionError == null ||
                                      premiumPaidInceptionError!.isEmpty
                                  ? 40.0
                                  : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: premiumPaidInception,
                                    decoration: InputDecoration(
                                      hintText: 'Premium Paid at Inception',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        premiumPaidInceptionError =
                                            validateString(value);
                                      });
                                      return premiumPaidInceptionError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("As on Date Premium",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height:
                                  premiumError == null || premiumError!.isEmpty
                                      ? 40.0
                                      : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: premium,
                                    decoration: InputDecoration(
                                      hintText: 'As on Date Premium',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        premiumError = validateString(value);
                                      });
                                      return premiumError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Addition Premium",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: additionPremiumError == null ||
                                      additionPremiumError!.isEmpty
                                  ? 40.0
                                  : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: additionPremium,
                                    decoration: InputDecoration(
                                      hintText: 'Addition Premium',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        additionPremiumError =
                                            validateString(value);
                                      });
                                      return additionPremiumError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Deletion Premium",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: deletionPremiumError == null ||
                                      deletionPremiumError!.isEmpty
                                  ? 40.0
                                  : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: deletionPremium,
                                    decoration: InputDecoration(
                                      hintText: 'Deletion Premium',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        deletionPremiumError =
                                            validateString(value);
                                      });
                                      return deletionPremiumError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Policy Type",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: policyTypeError == null ||
                                      policyTypeError!.isEmpty
                                  ? 40.0
                                  : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    controller: policyType,
                                    decoration: InputDecoration(
                                      hintText: 'Policy Type',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      setState(() {
                                        policyTypeError = validateString(value);
                                      });
                                      return policyTypeError;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Active Years",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color.fromRGBO(25, 26, 25, 1))),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: activeYearsError == null ||
                                      activeYearsError!.isEmpty
                                  ? 40.0
                                  : 65.0,
                              width: screenWidth * 0.23,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Material(
                                  shadowColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly // Allow only numeric input
                                    ],
                                    onChanged: (value) {
                                      activeYears.text =
                                          value; // Update the value of the TextFormField
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Active Years',
                                      hintStyle:
                                          GoogleFonts.poppins(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    // Set the initial value to "N/A" if the field is empty
                                    // initialValue: !.isEmpty
                                    //     ? 'N/A'
                                    //     : _textFieldValue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
