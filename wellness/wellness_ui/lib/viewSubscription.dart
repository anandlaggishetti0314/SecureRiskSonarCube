import 'package:flutter/material.dart';
import 'package:wellness_ui/PaymentSuccessful.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_icons.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ViewSubscription extends StatefulWidget {
  final dynamic data;
  const ViewSubscription({Key? key, this.data}) : super(key: key);

  @override
  State<ViewSubscription> createState() => _ViewSubscriptionState();
}

class _ViewSubscriptionState extends State<ViewSubscription> {
  dynamic _data;

 
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Expanded(
            child: Container(
              color: AppColors.lightGreyBg,
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Subscription",
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Plan :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "&100/ppm",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Email :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 250),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "jashwanth.pendyala@ojas-it.com",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "City :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Hyderabad",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Designation :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Team Lead",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Date Of Inception :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "07/14/2023",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Company Name :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Mobile :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "7993519524",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Concerned Person :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Department :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "JAVA",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 150),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "No Of Employees :",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                    Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 50, maxWidth: 200),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "25",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.textLightColor),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: Column(
                          children: [
                            const Divider(
                              height: 30,
                              color: AppColors.textLightColor,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 550),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Total    :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    "23000.00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Tooltip(
                                      message: 'View Invoice',
                                      preferBelow: true,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(
                                          top: 0, left: 150, right: 30),
                                      decoration: const BoxDecoration(
                                        color: AppColors.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.whiteColor,
                                            offset: Offset(
                                              15.0,
                                              15.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 5.0,
                                            spreadRadius: 2.0,
                                          ), //BoxShadow
                                        ],
                                      ),
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textColor),
                                      child: SizedBox(
                                        child: Image.asset(
                                          AppIcons.eyeIcon,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "(inclusive GST)",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.textLightColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PaymentSuccessful()),
                                  );
                                },
                                child: Ink(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70.0, vertical: 18.0),
                                  decoration: const BoxDecoration(
                                    // borderRadius: BorderRadius.circular(16.0),
                                    color: AppColors.mainBlueColor,
                                  ),
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 200),
                                    child: Center(
                                      child: Text(
                                        'Pay Now',
                                        style: ralewayStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.whiteColor,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
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
