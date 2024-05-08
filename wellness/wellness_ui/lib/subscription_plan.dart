import 'package:flutter/material.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_icons.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wellness_ui/paymentSummary.dart';

class SubscriptionPlan extends StatefulWidget {
  final dynamic data;
  const SubscriptionPlan({Key? key, this.data}) : super(key: key);

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  DateTime? selectedDate;

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

  dynamic _data;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController designatoinController = TextEditingController();
  final TextEditingController noOfEmployeesController = TextEditingController();
  final TextEditingController dateOfInceptionController =
      TextEditingController();
  final TextEditingController planDurationontroller = TextEditingController();
  String? dropdownValue;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    print(_data['price']);
  }

  Widget buildInputField({
    required String labelText,
    required String suffixIcon,
    required TextEditingController controller,
  }) {
    return Container(
      height: 40.0,
      constraints: const BoxConstraints(maxWidth: 301),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: AppColors.whiteColor,
      ),
      child: TextFormField(
        controller: controller,
        style: ralewayStyle.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.blueDarkColor,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightblueColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightblueColor),
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Image.asset(suffixIcon),
          ),
          contentPadding: const EdgeInsets.only(top: 16.0, left: 20.0),
          hintStyle: ralewayStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.blueDarkColor.withOpacity(0.8),
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final price = _data["price"];
    final planType = _data["planType"];
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            AppImages.banner2,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Container with Input Boxes
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            child: Image(
                              image: AssetImage(AppImages.logo),
                              width: 60,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'Subscribe',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 401),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: AppColors.planTypeColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$planType",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: AppColors.whiteColor),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: " ₹ ",
                                          style: ralewayStyle.copyWith(
                                            fontSize: 23.0,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w200,
                                          )),
                                      TextSpan(
                                          text: price.toString(),
                                          style: ralewayStyle.copyWith(
                                            fontSize: 37.0,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      TextSpan(
                                          text: "/PPPM",
                                          style: ralewayStyle.copyWith(
                                            fontSize: 20.0,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w200,
                                          ))
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          ResponsiveBuilder(
                            builder: (context, sizingInformation) {
                              if (sizingInformation.deviceScreenType ==
                                      DeviceScreenType.mobile ||
                                  sizingInformation.deviceScreenType ==
                                      DeviceScreenType.tablet) {
                                // Mobile view layout
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 35),
                                          buildInputField(
                                            labelText: 'Name',
                                            suffixIcon: AppIcons.emailIcon,
                                            controller: nameController,
                                          ),
                                          const SizedBox(height: 16.0),
                                          buildInputField(
                                            labelText: 'Email',
                                            suffixIcon: AppIcons.emailIcon,
                                            controller: emailController,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 35),
                                          buildInputField(
                                            labelText: 'Name',
                                            suffixIcon: AppIcons.emailIcon,
                                            controller: nameController,
                                          ),
                                          const SizedBox(height: 16.0),
                                          buildInputField(
                                            labelText: 'Email',
                                            suffixIcon: AppIcons.emailIcon,
                                            controller: emailController,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Desktop view layout
                                return Column(
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 70),
                                          buildInputField(
                                            labelText: 'Name',
                                            suffixIcon: AppIcons.userPersonIcon,
                                            controller: nameController,
                                          ),
                                          SizedBox(width: 200),
                                          buildInputField(
                                            labelText: 'Email',
                                            suffixIcon: AppIcons.atIcon,
                                            controller: emailController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 70),
                                          buildInputField(
                                            labelText: 'Mobile',
                                            suffixIcon: AppIcons.cellphoneIcon,
                                            controller: mobileController,
                                          ),
                                          SizedBox(width: 200),
                                          buildInputField(
                                            labelText: 'City',
                                            suffixIcon: AppIcons.mapIcon,
                                            controller: cityController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 70),
                                          buildInputField(
                                            labelText: 'Company',
                                            suffixIcon: AppIcons.atIcon,
                                            controller: companyController,
                                          ),
                                          SizedBox(width: 200),
                                          buildInputField(
                                            labelText: 'Department',
                                            suffixIcon: AppIcons.atIcon,
                                            controller: departmentController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 70),
                                          buildInputField(
                                            labelText: 'Designation',
                                            suffixIcon: AppIcons.atIcon,
                                            controller: designatoinController,
                                          ),
                                          SizedBox(width: 200),
                                          buildInputField(
                                            labelText: 'No. of Employees',
                                            suffixIcon: AppIcons.atIcon,
                                            controller: noOfEmployeesController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 60),
                                         
                                          Container(
                                            height: 40.0,
                                            constraints: const BoxConstraints(
                                                maxWidth: 301),
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
                                              controller:
                                                  dateOfInceptionController,
                                              style: ralewayStyle.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.blueDarkColor,
                                                fontSize: 16.0,
                                              ),
                                              decoration: InputDecoration(
                                                labelText: 'Date of Inception',
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .lightblueColor),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .lightblueColor),
                                                ),
                                                suffixIcon: GestureDetector(
                                                  // onTap: () {
                                                  //   _selectDate(context);
                                                  // },
                                                  child: Image.asset(
                                                      AppIcons.userPersonIcon),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: 16.0, left: 20.0),
                                                hintStyle:
                                                    ralewayStyle.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blueDarkColor
                                                      .withOpacity(0.8),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: 200),
                                          // buildInputField(
                                          //   labelText: 'Plan Duration',
                                          //   suffixIcon: AppIcons.lockIcon,
                                          //   controller: planDurationontroller,
                                          // ), // Define the dropdownValue variable

                                          Container(
                                            height: 40.0,
                                            constraints: const BoxConstraints(
                                                maxWidth: 301),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              color: AppColors.whiteColor,
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: dropdownValue,
                                              onChanged: (String? newValue) {
                                                // Correct the type of onChanged callback
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                '1 Month',
                                                '3 Month',
                                                '6 Month',
                                                '9 Month',
                                                '12 Month'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              style: ralewayStyle.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.blueDarkColor,
                                                fontSize: 16.0,
                                              ),
                                              decoration: InputDecoration(
                                                labelText: 'Plan Duration',
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .lightblueColor),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .lightblueColor),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: 16.0, left: 20.0),
                                                hintStyle:
                                                    ralewayStyle.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blueDarkColor
                                                      .withOpacity(0.8),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // SizedBox(height: 30),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              final maxWidth =
                                                  constraints.maxWidth;
                                              final buttonWidth = maxWidth < 300
                                                  ? maxWidth.toDouble()
                                                  : 300.0;

                                              return Container(
                                                width: buttonWidth,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(AppColors
                                                                .greyButton),
                                                  ),
                                                  onPressed: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text('Cancel'),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(width: 50),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              final maxWidth =
                                                  constraints.maxWidth;
                                              final buttonWidth = maxWidth < 300
                                                  ? maxWidth.toDouble()
                                                  : 300.0;

                                              return Container(
                                                width: buttonWidth,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(AppColors
                                                                .lightblueColor),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const PaymentSummary()),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child:
                                                        Text('Subscribe Now'),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
