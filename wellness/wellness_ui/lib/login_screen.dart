import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wellness_ui/User.dart';
import 'package:wellness_ui/api_services.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_icons.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:wellness_ui/remember_me_checkbox.dart';
import 'package:wellness_ui/responsive_widget.dart';
import 'package:wellness_ui/signup.dart';
import 'package:wellness_ui/subscription_pricing.dart';
import 'AppandSidebar.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool isPasswordVisible = false;
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
                      SizedBox(height: height * 0.1),
                      Center(
                        child: Image.asset(
                          AppImages.logo,
                          width: 144,
                          height: 99,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Center(
                        child: Text(
                          'Sign-in or Login',
                          style: ralewayStyle.copyWith(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.064),
                      Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Column(
                            children: [
                              const SizedBox(height: 6.0),
                              Container(
                                height: 50.0,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: AppColors.whiteColor,
                                ),
                                child: TextFormField(
                                  controller: emailController,
                                  style: ralewayStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blueDarkColor,
                                    fontSize: 16.0,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightblueColor)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightblueColor)),
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(AppIcons.emailIcon),
                                    ),
                                    // suffixText: '@',
                                    contentPadding: const EdgeInsets.only(
                                        top: 16.0, left: 20.0),
                                    // hintText: 'Enter Email',
                                    hintStyle: ralewayStyle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blueDarkColor
                                          .withOpacity(0.8),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),

                              _emailError != null
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        height: height * 0.03,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, top: 4.0),
                                          child: Text(
                                            _emailError!,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(height: height * 0.03),
                              const SizedBox(height: 6.0),

                              Container(
                                height: 50.0,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: AppColors.whiteColor,
                                ),
                                child: TextFormField(
                                  controller: passwordController,
                                  style: ralewayStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blueDarkColor,
                                    fontSize: 16.0,
                                  ),
                                  obscureText: !isPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.lightblueColor),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.lightblueColor),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                        print(isPasswordVisible);
                                      },
                                      icon: Image.asset(AppIcons.lockIcon),
                                    ),
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
                              Container(
                                child: _passwordError != null
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: height * 0.03,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, top: 4.0),
                                            child: Text(
                                              _passwordError!,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(height: height * 0.03),
                              ),
                              // if (_passwordError != null)

                              // SizedBox(height: height * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      RememberMeCheckbox(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Remember Password',
                                          style: ralewayStyle.copyWith(
                                            fontSize: 12.0,
                                            color: AppColors.mainBlueColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: ralewayStyle.copyWith(
                                        fontSize: 12.0,
                                        color: AppColors.mainBlueColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.05),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: validateLogin,
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Ink(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70.0, vertical: 18.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: AppColors.mainBlueColor,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Login',
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
                              SizedBox(height: height * 0.05),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Don't have an account yet?",
                                        style: ralewayStyle.copyWith(
                                          fontSize: 15.0,
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    TextSpan(
                                        // text: ' Sign Up 👇',
                                        text: ' Sign-up',
                                        style: ralewayStyle.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.lightblueColor,
                                          fontSize: 15.0,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUp()),
                                            );
                                          }),
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
            ),
          ],
        ),
      ),
    );
  }

  void validateLogin() async {
    setState(() {
      _emailError = _validateEmail(emailController.text);
      _passwordError = _validatePassword(passwordController.text);
      // Add similar validation for password field if needed
    });
    if (_emailError == null && _passwordError == null) {
      var user =
          User(email: emailController.text, password: passwordController.text);
      var apiService = ApiService();
      final data = {'email': user.email, 'password': user.password};
      var response = await apiService.post('user/login', data);
      String message = response.body['message'];
      if (response.statusCode == 200) {
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );

        showSuccessMessage(message);
        
      } else {
        showErrorMessage('Error: $message');
      }
    }
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is mandatory';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is mandatory';
    }
    return null;
  }
}
