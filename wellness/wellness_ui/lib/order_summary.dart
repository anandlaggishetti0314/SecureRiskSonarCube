import 'package:flutter/material.dart';
import 'package:wellness_ui/app_colors.dart';

import 'package:wellness_ui/app_styles.dart';
import 'package:wellness_ui/available_time.dart';
import 'package:wellness_ui/consultation_mode.dart';
import 'package:wellness_ui/sidebar.dart';

import 'package:flutter/services.dart';

class OrderSummary extends StatefulWidget {
  final List<String> checkedSymptoms;
  final dynamic data;
  const OrderSummary({super.key, required this.checkedSymptoms, this.data});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  dynamic _data;
  List<String> _checkedSymptoms = [];

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _checkedSymptoms = widget.checkedSymptoms;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ResponsiveLayout(
          largeScreen: Order(checkedSymptoms: _checkedSymptoms, data: _data),
          mediumScreen: Order(
              checkedSymptoms: _checkedSymptoms,
              data:
                  _data), // You can define a separate widget for medium-sized screens if needed.
          smallScreen: Order(
              checkedSymptoms: _checkedSymptoms,
              data:
                  _data), // You can define a separate widget for small-sized screens if needed.
        ),
      ),
    );
  }
}

class Order extends StatefulWidget {
  final List<String> checkedSymptoms;
  final dynamic data;
  const Order({Key? key, required this.checkedSymptoms, this.data})
      : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  dynamic _data;
  List<String> _checkedSymptoms = [];
  String patientName = "";
  String doctorName = "";
  String doctorQualification = "";
  String doctorRegNo = "";
  String _selectedModeButton = '';
  String _selectedTimeButton = '';
  DateTime? selectedDate;
  final TextEditingController dateOfInceptionController =
      TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfInceptionController.text =
            '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}';
      });
    }
  }

  void _toggleModeButton(String buttonText) {
    setState(() {
      if (_selectedModeButton == buttonText) {
        _selectedModeButton =
            ''; // Reset the state if the same button is clicked again
      } else {
        _selectedModeButton = buttonText;
      }
    });
  }

  void _toggleTimeButton(String buttonText) {
    setState(() {
      if (_selectedTimeButton == buttonText) {
        _selectedTimeButton =
            ''; // Reset the state if the same button is clicked again
      } else {
        _selectedTimeButton = buttonText;
      }
    });
  }

  bool _isSidebarOpen = true;
  Widget? _selectedDashboard;
  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _checkedSymptoms = widget.checkedSymptoms;
    print(_data.name);
    print(_checkedSymptoms);
    _selectedDashboard = Order(
      checkedSymptoms: _checkedSymptoms,
      data: _data,
    );
    doctorName = _data.name;
    doctorQualification = _data.qualification;
    doctorRegNo = _data.regno;
  }

  final TextEditingController iconController = TextEditingController();

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _selectDashboard(Widget dashboard) {
    setState(() {
      _selectedDashboard = dashboard;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Determine the width breakpoint to decide the layout
    bool isSmallScreen = width < 768;
    bool isMediumScreen = width >= 768 && width < 1200;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(
                          child: Text(
                            "Order Summary",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: isSmallScreen
                                  ? 2
                                  : 1, // Adjust flex value for small screens
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      constraints:
                                          BoxConstraints(minWidth: 200),
                                      child: Text(
                                        "Selected Symptoms:",
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: isSmallScreen
                                  //       ? width * 0.01
                                  //       : width *
                                  //           0.02, // Adjust spacing for small screens
                                  // ),
                                  Flexible(
                                    child: Text(
                                      _checkedSymptoms.join(', '),
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: isSmallScreen
                                  ? 2
                                  : 1, // Adjust flex value for small screens
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      constraints:
                                          BoxConstraints(minWidth: 200),
                                      child: Text(
                                        "Selected Doctor:",
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      doctorName,
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: isSmallScreen
                                  ? 2
                                  : 1, // Adjust flex value for small screens
                              child: Row(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(minWidth: 150),
                                    child: const Text(
                                      "Patient Name:",
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: isSmallScreen
                                        ? width * 0.01
                                        : width *
                                            0.02, // Adjust spacing for small screens
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 40.0,
                                        constraints: BoxConstraints(
                                          maxWidth: isSmallScreen
                                              ? 150
                                              : 200, // Adjust maxWidth for small screens
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          color: AppColors.whiteColor,
                                        ),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              patientName = value;
                                            });
                                          },
                                          controller: patientNameController,
                                          style: ralewayStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blueDarkColor,
                                            fontSize: 16.0,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "Patient Name",
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightblueColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightblueColor,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                              top: 16.0,
                                              left: 20.0,
                                            ),
                                            hintStyle: ralewayStyle.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.blueDarkColor
                                                  .withOpacity(0.8),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: isSmallScreen
                                  ? 2
                                  : 1, // Adjust flex value for small screens
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      constraints:
                                          BoxConstraints(minWidth: 150),
                                      child: const Text(
                                        "Phone Number:",
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: isSmallScreen
                                        ? width * 0.01
                                        : width *
                                            0.02, // Adjust spacing for small screens
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 40.0,
                                      constraints: BoxConstraints(
                                        maxWidth: isSmallScreen
                                            ? 150
                                            : 200, // Adjust maxWidth for small screens
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        color: AppColors.whiteColor,
                                      ),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(
                                              r'[0-9]')), // Allow numbers only
                                        ],
                                        // controller: controller,
                                        style: ralewayStyle.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blueDarkColor,
                                          fontSize: 16.0,
                                        ),
                                        decoration: InputDecoration(
                                          // labelText: labelText,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.lightblueColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.lightblueColor,
                                            ),
                                          ),
                                          // suffixIcon: IconButton(
                                          //   onPressed: () {},
                                          //   icon: Image.asset(suffixIcon),
                                          // ),
                                          contentPadding: const EdgeInsets.only(
                                            top: 16.0,
                                            left: 20.0,
                                          ),
                                          hintStyle: ralewayStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blueDarkColor
                                                .withOpacity(0.8),
                                            fontSize: 14.0,
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
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: isSmallScreen
                                  ? 2
                                  : 1, // Adjust flex value for small screens
                              child: width <= 1024
                                  ? Column(
                                      children: [
                                        FittedBox(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "Preferred Mode of Consultation :",
                                              style: TextStyle(
                                                color: AppColors.textColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: isSmallScreen
                                              ? height * 0.01
                                              : height *
                                                  0.02, // Adjust spacing for small screens
                                        ),
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              ConsultationMode(
                                                text: "Video",
                                                isSelected:
                                                    _selectedModeButton ==
                                                        "Video",
                                                onPressed: () =>
                                                    _toggleModeButton("Video"),
                                              ),
                                              SizedBox(
                                                width: isSmallScreen
                                                    ? width * 0.01
                                                    : width * 0.01,
                                              ),
                                              ConsultationMode(
                                                text: "Chat",
                                                isSelected:
                                                    _selectedModeButton ==
                                                        "Chat",
                                                onPressed: () =>
                                                    _toggleModeButton("Chat"),
                                              ),
                                              SizedBox(
                                                width: isSmallScreen
                                                    ? width * 0.01
                                                    : width * 0.01,
                                              ),
                                              ConsultationMode(
                                                text: "Voice",
                                                isSelected:
                                                    _selectedModeButton ==
                                                        "Voice",
                                                onPressed: () =>
                                                    _toggleModeButton("Voice"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : FittedBox(
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "Preferred Mode of Consultation :",
                                              style: TextStyle(
                                                color: AppColors.textColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: isSmallScreen
                                                ? width * 0.01
                                                : width *
                                                    0.02, // Adjust spacing for small screens
                                          ),
                                          ConsultationMode(
                                            text: "Video",
                                            isSelected:
                                                _selectedModeButton == "Video",
                                            onPressed: () =>
                                                _toggleModeButton("Video"),
                                          ),
                                          SizedBox(
                                            width: isSmallScreen
                                                ? width * 0.01
                                                : width * 0.01,
                                          ),
                                          ConsultationMode(
                                            text: "Chat",
                                            isSelected:
                                                _selectedModeButton == "Chat",
                                            onPressed: () =>
                                                _toggleModeButton("Chat"),
                                          ),
                                          SizedBox(
                                            width: isSmallScreen
                                                ? width * 0.01
                                                : width * 0.01,
                                          ),
                                          ConsultationMode(
                                            text: "Voice",
                                            isSelected:
                                                _selectedModeButton == "Voice",
                                            onPressed: () =>
                                                _toggleModeButton("Voice"),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                            Expanded(
                              flex: isSmallScreen
                                  ? 2
                                  : 1, // Adjust flex value for small screens
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Date of Consultation :",
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  SizedBox(
                                    width: isSmallScreen
                                        ? width * 0.01
                                        : width *
                                            0.02, // Adjust spacing for small screens
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 40.0,
                                      constraints: BoxConstraints(
                                        maxWidth: isSmallScreen
                                            ? 150
                                            : 200, // Adjust maxWidth for small screens
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        color: AppColors.whiteColor,
                                      ),
                                      child: TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        controller: dateOfInceptionController,
                                        style: ralewayStyle.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blueDarkColor,
                                          fontSize: 16.0,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Date of Consultation',
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.lightblueColor),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.lightblueColor),
                                          ),
                                          // suffixIcon: GestureDetector(
                                          //   // onTap: () {
                                          //   //   _selectDate(context);
                                          //   // },
                                          //   child: Image.asset(
                                          //       AppIcons.userPersonIcon),
                                          // ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 16.0, left: 20.0),
                                          hintStyle: ralewayStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blueDarkColor
                                                .withOpacity(0.8),
                                            fontSize: 14.0,
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
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Availability Time :",
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: isSmallScreen
                                  ? width * 0.01
                                  : width *
                                      0.02, // Adjust spacing for small screens
                            ),
                            AvailableTimeButton(
                              text: "09:00",
                              isSelected: _selectedTimeButton == "Video",
                              onPressed: () => _toggleTimeButton("Video"),
                            ),
                            SizedBox(
                              width:
                                  isSmallScreen ? width * 0.01 : width * 0.01,
                            ),
                            AvailableTimeButton(
                              text: "10:00",
                              isSelected: _selectedTimeButton == "Chat",
                              onPressed: () => _toggleTimeButton("Chat"),
                            ),
                            SizedBox(
                              width:
                                  isSmallScreen ? width * 0.01 : width * 0.01,
                            ),
                            AvailableTimeButton(
                              text: "11:00",
                              isSelected: _selectedTimeButton == "Voice",
                              onPressed: () => _toggleTimeButton("Voice"),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        const Row(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Bill Summary",
                              style: TextStyle(
                                  color: AppColors.textColor, fontSize: 35),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: constraints.maxWidth,
                                child: DataTable(
                                  // dataRowColor: MaterialStatePropertyAll(AppColors.lightGreyBg),
                                  headingRowColor: MaterialStatePropertyAll(
                                      AppColors.greyTableHeaderColor),
                                  columns: <DataColumn>[
                                    DataColumn(label: Text('#')),
                                    DataColumn(
                                        label: Flexible(
                                            child: Text('Patient Name'))),
                                    DataColumn(
                                        label: Flexible(
                                            child: Text('Consultant Name'))),
                                    DataColumn(label: Text('Price')),
                                    DataColumn(label: Text('Taxes')),
                                    DataColumn(label: Text('Amount')),
                                  ],
                                  rows: <DataRow>[
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('1')),
                                      DataCell(
                                        Column(
                                          children: [
                                            Text(
                                              patientName,
                                            ),
                                            FittedBox(
                                                child: Text(
                                              _checkedSymptoms.join(','),
                                            ))
                                          ],
                                        ),
                                      ),
                                      DataCell(Text(doctorName)),
                                      DataCell(Text('2500')),
                                      DataCell(Text('450')),
                                      DataCell(Text('2950')),
                                    ]),

                                    // Add more rows here
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text("Total :",
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 15)),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      "2950",
                                      style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 20),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  ResponsiveLayout({
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  });

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1200;
  }

  @override
  Widget build(BuildContext context) {
    if (isSmallScreen(context)) {
      return smallScreen ?? largeScreen;
    } else if (isMediumScreen(context)) {
      return mediumScreen ?? largeScreen;
    } else {
      return largeScreen;
    }
  }
}
