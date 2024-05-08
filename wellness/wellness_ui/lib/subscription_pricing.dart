import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wellness_ui/api_services.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:wellness_ui/services_accordian.dart';
import 'package:wellness_ui/subscription_plan.dart';

class SubscriptionPricing extends StatefulWidget {
  const SubscriptionPricing({Key? key}) : super(key: key);

  @override
  State<SubscriptionPricing> createState() => _SubscriptionPricingState();
}

class _SubscriptionPricingState extends State<SubscriptionPricing> {
  List<Map<String, dynamic>> apiResponse = [];
  List<bool> isHovered = [];
  var client = http.Client();
  List<Map<String, dynamic>> servicesApiResonse = [
    {
      'title': 'Alerts & Tips',
      'data': [
        {
          'name': 'Alert1',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert2',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert3',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
      ],
    },
    {
      'title': 'Accordion Title 2',
      'data': [
        {
          'name': 'Alert4',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert5',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
      ],
    },
    {
      'title': 'Accordion Title 3',
      'data': [
        {
          'name': 'Alert6',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert7',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert8',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
      ],
    },
  ];

  List<AccordianItem> _items = [];
  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
    _items = servicesApiResonse
        .map((item) => AccordianItem(
              title: item['title'],
              data: List<Map<String, dynamic>>.from(item['data']),
              isExpanded: false,
            ))
        .toList();
  }

  Future<void> fetchDataFromAPI() async {
    var apiService = ApiService();
    final response =
        await apiService.get('/subscription/viewallsubscriptions');
    if (response.statusCode == 200) {
      setState(() {
        apiResponse = List<Map<String, dynamic>>.from(response.body);
        apiResponse.sort((a, b) => a['price'].compareTo(b['price']));

        // Initialize the hovered state for each card to false
        isHovered = List<bool>.filled(apiResponse.length, false);
      });
    } else {
      print('API request error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PRICING',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        children: List.generate(
                          apiResponse.length,
                          (index) {
                            var cardData = apiResponse[index];
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) {
                                setState(() {
                                  isHovered[index] = true;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  isHovered[index] = false;
                                });
                              },
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 200),
                                tween: Tween<double>(
                                  begin: isHovered[index] ? 1.0 : 1.1,
                                  end: isHovered[index] ? 1.1 : 1.0,
                                ),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Handle the card tap event

                                      },
                                      child: Card(
                                        color: isHovered[index]
                                            ? AppColors.darkblue
                                            : AppColors.lightBlue,
                                        margin: const EdgeInsets.all(40),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SizedBox(
                                            width: 130 * value,
                                            height: 130 * value,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      cardData['planType'],
                                                      style: TextStyle(
                                                        color: isHovered[index]
                                                            ? Colors.white
                                                            : AppColors
                                                                .textColor,
                                                        fontSize: 25 * value,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Price: ${cardData['price']}',
                                                    style: TextStyle(
                                                      fontSize: 16 * value,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: isHovered[index]
                                                          ? Colors.white
                                                          : AppColors.textColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  ElevatedButton(
                                                    onPressed: () {

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SubscriptionPlan(
                                                                  data: cardData),
                                                        ),
                                                      );

                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        isHovered[index]
                                                            ? AppColors.red
                                                            : AppColors.red,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                        'Subscribe Now'),

                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _items[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _items.map<ExpansionPanel>((AccordianItem item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                item.isExpanded = !isExpanded;
                              });
                            },
                            child: Container(
                              color: AppColors.lightBlue,
                                   // Change the background color of the title
                              child: ListTile(
                                leading: Icon(
                                  item.isExpanded ? Icons.remove : Icons.add,
                                  color:AppColors.textColor, // Set the color of the + and - icons
                                ),
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    color: AppColors.textColor, // Change the text color of the title
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        body: item.isExpanded
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: item.data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(item.data[index]['name']),
                                        Icon(
                                          item.data[index]['free'] == 1
                                              ? Icons.check
                                              : Icons.close,
                                          color: Colors
                                              .black, // Set the color of the check and close icons
                                        ),
                                        Icon(
                                          item.data[index]['basic'] == 1
                                              ? Icons.check
                                              : Icons.close,
                                          color: Colors
                                              .black, // Set the color of the check and close icons
                                        ),
                                        Icon(
                                          item.data[index]['standard'] == '1'
                                              ? Icons.check
                                              : Icons.close,
                                          color: Colors
                                              .black, // Set the color of the check and close icons
                                        ),
                                        Icon(
                                          item.data[index]['premium'] == 1
                                              ? Icons.check
                                              : Icons.close,
                                          color: Colors
                                              .black, // Set the color of the check and close icons
                                        ),
                                        Icon(
                                          item.data[index]['ultimate'] == 1
                                              ? Icons.check
                                              : Icons.close,
                                          color: Colors
                                              .black, // Set the color of the check and close icons
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : SizedBox
                                .shrink(), // Hide the body when not expanded
                        isExpanded: item.isExpanded,
                        canTapOnHeader: true, // Enable tapping on the header
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccordianItem {
  String title;
  List<Map<String, dynamic>> data;
  bool isExpanded;

  AccordianItem({
    required this.title,
    required this.data,
    required this.isExpanded,
  });
}