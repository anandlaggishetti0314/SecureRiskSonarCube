import 'package:flutter/material.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_icons.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:wellness_ui/order_summary.dart';
import 'package:wellness_ui/order_summary_sidebar.dart';
import 'package:wellness_ui/responsive_widget.dart';

class Doctor extends StatelessWidget {
  const Doctor({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ResponsiveCardLayout(),
      ),
    );
  }
}

class ResponsiveCardLayout extends StatefulWidget {
  const ResponsiveCardLayout({Key? key});

  @override
  _ResponsiveCardLayoutState createState() => _ResponsiveCardLayoutState();
}

class _ResponsiveCardLayoutState extends State<ResponsiveCardLayout> {
  List<String> checkedSymptoms = [];
  final List<CardData> cardData = [
    CardData(
        name: "Dr. John Smith",
        qualification: "MBBS",
        imagePath: AppImages.doctor1,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. Smith John",
        qualification: "MBBS Diploma",
        imagePath: AppImages.doctor2,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. Mac Sam",
        qualification: "MBBS, MS",
        imagePath: AppImages.doctor3,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. John Smith",
        qualification: "BAMS",
        imagePath: AppImages.doctor4,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. John Smith",
        qualification: "MBBS",
        imagePath: AppImages.doctor1,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. Smith John",
        qualification: "MBBS Diploma",
        imagePath: AppImages.doctor2,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. Mac Sam",
        qualification: "MBBS, MS",
        imagePath: AppImages.doctor3,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. John Smith",
        qualification: "BAMS",
        imagePath: AppImages.doctor4,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. John Smith",
        qualification: "MBBS",
        imagePath: AppImages.doctor1,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. Smith John",
        qualification: "MBBS Diploma",
        imagePath: AppImages.doctor2,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. Mac Sam",
        qualification: "MBBS, MS",
        imagePath: AppImages.doctor3,
        regno: "Reg. No. 73738"),
    CardData(
        name: "Dr. John Smith",
        qualification: "BAMS",
        imagePath: AppImages.doctor4,
        regno: "Reg. No. 73738"),
  ];
  bool _feverChecked = false;
  bool _coughChecked = false;
  bool _coldChecked = false;
  bool _covidChecked = false;

  int hoveredIndex = -1;
  @override
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Container(
              height: constraints.maxHeight * 1.4,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          color: AppColors.darkblue,
                          image: DecorationImage(
                            image: AssetImage(AppImages.doctorBanner),
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Text(
                                    'Look for Top Doctors Near me',
                                    style: TextStyle(
                                      fontSize: 48.0,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Text(
                                    'Consult with a Doctor for your primary care need. Our Doctors will help you with appropriate advice.',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 1200),
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                    ),
                                    child: TextFormField(
                                      style: ralewayStyle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor,
                                        fontSize: 16.0,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Type your requirements',
                                        labelStyle: ralewayStyle.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor,
                                          fontSize: 20.0,
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.whiteColor),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Image.asset(AppIcons.atIcon),
                                        ),
                                        hintStyle: ralewayStyle.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.whiteColor,
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
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: ResponsiveWidget.isLargeScreen(context)
                          ? const EdgeInsets.all(38.0)
                          : const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Consultation",
                              style: TextStyle(
                                color: AppColors.textLightColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            ResponsiveWidget.isLargeScreen(
                                                    context)
                                                ? 300
                                                : 180,
                                        maxHeight: constraints.maxHeight,
                                      ),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "SYMPTOMS",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textLightColor,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              'Fever',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            value: _feverChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _feverChecked = value ?? false;
                                                if (_feverChecked) {
                                                  checkedSymptoms.add('Fever');
                                                } else {
                                                  checkedSymptoms
                                                      .remove('Fever');
                                                }
                                              });
                                            },
                                            activeColor: AppColors.whiteColor,
                                            checkColor: AppColors.textColor,
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              'Cough',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            value: _coughChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _coughChecked = value ?? false;
                                                if (_coughChecked) {
                                                  checkedSymptoms.add('Cough');
                                                } else {
                                                  checkedSymptoms
                                                      .remove('Cough');
                                                }
                                              });
                                            },
                                            activeColor: AppColors.whiteColor,
                                            checkColor: AppColors.textColor,
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              'Cold',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            value: _coldChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _coldChecked = value ?? false;
                                                if (_coldChecked) {
                                                  checkedSymptoms.add('Cold');
                                                } else {
                                                  checkedSymptoms
                                                      .remove('Cold');
                                                }
                                              });
                                            },
                                            activeColor: AppColors.whiteColor,
                                            checkColor: AppColors.textColor,
                                          ),
                                          CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              'Covid',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            value: _covidChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _covidChecked = value ?? false;
                                                if (_covidChecked) {
                                                  checkedSymptoms.add('Covid');
                                                } else {
                                                  checkedSymptoms
                                                      .remove('Covid');
                                                }
                                              });
                                            },
                                            activeColor: AppColors.whiteColor,
                                            checkColor: AppColors.textColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Doctors Available",
                                              style: TextStyle(
                                                color: AppColors.textColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: LayoutBuilder(
                                          builder: (BuildContext context,
                                              BoxConstraints constraints) {
                                            if (constraints.maxWidth >= 1024) {
                                              return Container(
                                                child: buildGridView(
                                                    4, 100.0, checkedSymptoms),
                                              );
                                            } else if (constraints.maxWidth >=
                                                768) {
                                              return Container(
                                                child: buildGridView(
                                                    3, 1000.0, checkedSymptoms),
                                              );
                                            } else if (constraints.maxWidth >=
                                                520) {
                                              return Container(
                                                child: buildGridView(
                                                    2,
                                                    double.infinity,
                                                    checkedSymptoms),
                                              );
                                            } else if (constraints.maxWidth >=
                                                320) {
                                              return Container(
                                                child: buildGridView(
                                                    1,
                                                    double.infinity,
                                                    checkedSymptoms),
                                              );
                                            } else {
                                              return buildGridView(
                                                  1,
                                                  double.infinity,
                                                  checkedSymptoms);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView(
      int crossAxisCount, double cardWidth, List<String> checkedSymptoms) {
    return GridView.builder(
      itemCount: cardData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.0,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return MouseRegion(
          onHover: (event) {
            setState(() {
              hoveredIndex = index;
            });
          },
          onExit: (event) {
            setState(() {
              hoveredIndex = -1;
            });
          },
          child: CardItem(
            cardData: cardData[index],
            isHovered: hoveredIndex == index,
            width: cardWidth,
            checkedSymptoms: checkedSymptoms,
          ),
        );
      },
    );
  }
}

class CardData {
  final String name;
  final String qualification;
  final String imagePath;
  final String regno;

  CardData({
    required this.name,
    required this.qualification,
    required this.imagePath,
    required this.regno,
  });
}

class CardItem extends StatelessWidget {
  final List<String> checkedSymptoms;
  final CardData cardData;
  final bool isHovered;
  final double width;

  const CardItem({
    required this.cardData,
    required this.isHovered,
    required this.width,
    required this.checkedSymptoms,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderSummarySidebar(
                      checkedSymptoms: checkedSymptoms, data: cardData)),
            );
          },
          child: Card(
            color: isHovered ? AppColors.whiteColor : Colors.white,
            elevation: isHovered ? 10.0 : 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.0),
              side: isHovered
                  ? BorderSide(color: AppColors.lightblueBorder, width: 1.0)
                  : BorderSide.none,
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset(
                          cardData.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardData.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          cardData.qualification,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          cardData.regno,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
