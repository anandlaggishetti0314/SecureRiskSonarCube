import 'package:flutter/material.dart';
import 'package:wellness_ui/OtpScreenLatest.dart';
import 'package:wellness_ui/User.dart';
import 'package:wellness_ui/api_services.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_icons.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:wellness_ui/responsive_widget.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String? _emailError;
  String? _nameError;
  String? _mobileError;
  String? _cityError;

  Widget buildErrorInputField({required String? errorName}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        // height: height * 0.03,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 4.0,bottom: 0),
          child: Text(
            errorName!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required String labelText,
    required String suffixIcon,
    required TextEditingController controller,
  }) {
    return Container(
      height: 48.0,
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
                          'Sign-up',
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  buildInputField(
                                    labelText: 'Name',
                                    suffixIcon: AppIcons.emailIcon,
                                    controller: nameController,
                                  ),
                                  Container(
                                    child: _nameError != null
                                        ? buildErrorInputField(
                                            errorName: _nameError)
                                        : null,
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.05),
                              Column(
                                children: [
                                  buildInputField(
                                    labelText: 'Email',
                                    suffixIcon: AppIcons.lockIcon,
                                    controller: emailController,
                                  ),
                                  Container(
                                    child: _emailError != null
                                        ? buildErrorInputField(
                                            errorName: _emailError)
                                        : null,
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.05),
                              Column(
                                children: [
                                  buildInputField(
                                    labelText: 'Mobile',
                                    suffixIcon: AppIcons.emailIcon,
                                    controller: mobileController,
                                  ),
                                  Container(
                                    child: _mobileError != null
                                        ? buildErrorInputField(
                                            errorName: _mobileError)
                                        : null,
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.05),
                              Column(
                                children: [
                                  Container(
                                    child: buildInputField(
                                      labelText: 'City',
                                      suffixIcon: AppIcons.lockIcon,
                                      controller: cityController,
                                    ),
                                  ),
                                  Container(
                                    child: _cityError != null
                                        ? buildErrorInputField(
                                            errorName: _cityError)
                                        : null,
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.05),               
                             
                              Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 60),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              final maxWidth =
                                                  constraints.maxWidth;
                                              final buttonWidth = maxWidth < 120
                                                  ? maxWidth.toDouble()
                                                  : 120.0;

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
                                              final buttonWidth = maxWidth < 120
                                                  ? maxWidth.toDouble()
                                                  : 120.0;

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
                                                    validateRegister();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text('Sign-up'),
                                                  ),
                                                ),
                                              );
                                            },
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
            ),
          ],
        ),
      ),
    );
  }

  void validateRegister() async {
    setState(() {
      _emailError = _validateEmail(emailController.text);
      _mobileError = _validateMobileNumber(mobileController.text);
      _cityError = _validateCity(cityController.text);
      _nameError = _validateName(nameController.text);
    });
    print(_emailError);
    if (_emailError == null &&
        _nameError == null &&
        _mobileError == null &&
        _cityError == null) {
      var user = User(
          email: emailController.text,
          mobile: mobileController.text,
          city: cityController.text,
          name: nameController.text,);
      var apiService = ApiService();
      final data = {
        'email': user.email,
        "mobile": user.mobile,
        'city': user.city,
        'name': user.name,
      };
      var response = await apiService.post('user/register', data);
      // String message = response.body['message'];
      print(response.statusCode.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        // showSuccessMessage(message);
        var userId = response.body['id'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  OtpScreenLatest(userId: userId)),
        );
        print(response.body);
      } else {
        print(response.body);
      }
    }
    print("register");
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

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is mandatory';
    }
    return null;
  }

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is mandatory';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Invalid mobile number format';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is mandatory';
    }
    return null;
  }
}
