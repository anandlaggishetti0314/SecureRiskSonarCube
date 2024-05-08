import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'CreateRFQ.dart';

class CorporateDetails extends StatefulWidget {
  @override
  State<CorporateDetails> createState() => _CorporateDetailsState();
}

class _CorporateDetailsState extends State<CorporateDetails> {
  // ignore: non_constant_identifier_names
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

  var name;
  String? data;

  Future<void> saveCorporateDetails() async {
    var corporateDetails = {
      "id": "ae1304d8-be5b-4661-9244-5bb8e281dd39",
      'insuredName': NameOftheInsurer.text,
      'address': Address.text,
      'nob': NameOfTheBusiness.text,
      'contactName': ContactName.text,
      'email': EmailId.text,
      'phNo': PhoneNumber.text,
    };

    var intermediaryDetails = {
      "id": "ae1304d8-be5b-4661-9244-5bb8e281dd39",
      "name": NameOfTheIntermediary.text,
      "contactName": IntermediateContactName.text,
      "email": IntermediateEmailId.text,
      "phNo": IntermediatePhoneNumber.text
    };

    var body = {
      "corporateDetails": corporateDetails,
      "intermediaryDetails": intermediaryDetails
    };

    Response response =
        await post(Uri.parse('http://192.168.4.58:9763/rfq/saveCDID'),
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
        ElevatedButton(
          onPressed: saveCorporateDetails,
          child: Text('Save CorporateDetails'),
        ),
      ],
    );
  }
}
