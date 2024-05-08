import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/responsive_widget.dart';
import 'OtpSuccessfulScreen.dart';
import 'api_services.dart';

class OtpScreenLatest extends StatefulWidget {
  final int userId;
  const OtpScreenLatest({Key? key,required this.userId}) : super(key: key);

  @override
  State<OtpScreenLatest> createState() => _OtpScreenLatestState();
}

class _OtpScreenLatestState extends State<OtpScreenLatest> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  TextEditingController otp6Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveWidget.isValidLoginScreen(context)
                ? const SizedBox()
                : Expanded(
                    child: Stack(children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.banner),
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height,
                        // color: AppColors.mainBlueColor,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 6.0), // Add bottom margin
                                  child: Text(
                                    'Simplyfying',
                                    style: TextStyle(
                                      fontSize: 48.0,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    'Health Care for',
                                    style: TextStyle(
                                      fontSize: 48.0,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'your family',
                                  style: TextStyle(
                                    fontSize: 48.0,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(
                    horizontal: ResponsiveWidget.isSmallScreen(context)
                        ? height * 0.032
                        : height * 0.12),
                color: AppColors.backColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.2),
                      Center(
                        child: Image.asset(
                          AppImages.logo,
                          width: 100,
                          height: 50,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 01.0, top: 20.0, right: 01.0, bottom: 20.0),
                        child: Center(
                          child: Text(
                            'Verify with OTP',
                            style: TextStyle(
                              fontSize: 35.0,
                              color: Color.fromRGBO(32, 37, 41, 1.0),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Form(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: otp1Controller,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin1) {},
                                decoration: InputDecoration(hintText: "0"),
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: otp2Controller,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin2) {},
                                decoration: InputDecoration(hintText: "0"),
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: otp3Controller,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin3) {},
                                decoration: InputDecoration(hintText: "0"),
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: otp4Controller,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin4) {},
                                decoration: InputDecoration(hintText: "0"),
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: otp5Controller,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin5) {},
                                decoration: InputDecoration(hintText: "0"),
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: otp6Controller,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin6) {},
                                decoration: InputDecoration(hintText: "0"),
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final maxWidth = constraints.maxWidth;
                          final buttonWidth =
                              maxWidth < 400 ? maxWidth.toDouble() : 400.0;

                          return Container(
                            margin: const EdgeInsets.only(
                                left: 25.0,
                                top: 20.0,
                                right: 01.0,
                                bottom: 20.0),
                            width: buttonWidth,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.lightblueColor),
                              ),
                              onPressed: () {
                                validateLogin();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('Verify'),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: height * 0.064),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateLogin() async {

    if (otp1Controller.text.isNotEmpty &&
        otp2Controller.text.isNotEmpty &&
        otp3Controller.text.isNotEmpty &&
        otp4Controller.text.isNotEmpty &&
        otp5Controller.text.isNotEmpty &&
        otp6Controller.text.isNotEmpty) {

      var apiService = ApiService();

      final data = {
        'id': widget.userId,
        'otp': '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}${otp6Controller.text}',
      };


      try {
        var response = await apiService.post('user/verifyOtp', data);
        String message = response.body['message'];
        log('message: $message');

        if (response.statusCode == 201) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OtpSuccessfulScreen(),
            ),
          );
        } else {
          showErrorMessage('Error: $message');
        }
      } catch (e) {
        print('Exception: $e');
        showErrorMessage('Error: $e');
      }
    } else {
      showErrorMessage('Please enter the complete OTP');
    }
  }
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
