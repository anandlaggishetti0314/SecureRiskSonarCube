import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'NavigationDrawerWidget.dart';
import 'app_colors.dart';
import 'app_icons.dart';
import 'app_styles.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
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
          padding: const EdgeInsets.only(left: 20.0, top: 4.0),
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
      height: 35.0,
      constraints: const BoxConstraints(maxWidth: 300),
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return buildWebLayout();
        },
      ),
    );
  }

  Widget buildWebLayout() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            minWidth: width,
            maxWidth: width,
          ),
          child: Column(
            children: [
              Container(
                height: 40.0,
                width: double.infinity,
                color: const Color.fromRGBO(214, 241, 243, 1.0),
              ),
              Container(
                  // color: AppColors.lightGreyBg,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.03),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Basic Details',
                                style: ralewayStyle.copyWith(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Column(
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
                                      SizedBox(height: height * 0.03),
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
                                      SizedBox(height: height * 0.03),
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
                                    ],
                                  ),
                                  SizedBox(width: width * 0.06),
                                  Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 200, maxHeight: 200),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Image.asset(
                                          'assets/images/ProfilePic.png'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Personal Details',
                                style: ralewayStyle.copyWith(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    buildInputField(
                                      labelText: 'Age',
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
                                SizedBox(width: width * 0.06),
                                Column(
                                  children: [
                                    buildInputField(
                                      labelText: 'Gender',
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
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Present Address',
                                    style: ralewayStyle.copyWith(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    buildInputField(
                                      labelText: 'Address1',
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
                                SizedBox(width: width * 0.06),
                                Column(
                                  children: [
                                    buildInputField(
                                      labelText: 'Address2',
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
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    buildInputField(
                                      labelText: 'City',
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
                                SizedBox(width: width * 0.06),
                                Column(
                                  children: [
                                    buildInputField(
                                      labelText: 'Pincode',
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
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: Column())
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
