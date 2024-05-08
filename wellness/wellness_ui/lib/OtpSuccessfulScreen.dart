import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:wellness_ui/login_screen.dart';
import 'package:wellness_ui/responsive_widget.dart';

class OtpSuccessfulScreen extends StatefulWidget {
  const OtpSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<OtpSuccessfulScreen> createState() => _OtpSuccessfulScreenState();
}

class _OtpSuccessfulScreenState extends State<OtpSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

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
                    'Successful',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Color.fromRGBO(32, 37, 41, 1.0),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 01.0, top: 20.0, right: 01.0, bottom: 20.0),
                child: Center(
                  child: Image(image: AssetImage(
                    'assets/images/success_image.png',),
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                Text(
                'Click here to:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'Karla'
                ),
              ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:
                            (context) => const LoginScreen()
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: ralewayStyle.copyWith(
                        fontSize: 10.0,
                        color: AppColors.mainBlueColor,
                          fontFamily: 'Karla'

                      ),
                    ),
                  ),

            ],
            ),

            ],
          ),
        ),
      ),
    ),]
    ,
    )
    ,
    )
    ,
    );
  }
}
