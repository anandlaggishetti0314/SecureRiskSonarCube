import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'NavigationDrawerWidget.dart';
import 'app_colors.dart';
import 'app_icons.dart';
import 'app_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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

    return Scaffold(

      body: SingleChildScrollView(

        child:Column(
          children: <Widget>[
            new Container(height: 40.0, width: 500,  color: Color.fromRGBO(
                214, 241, 243, 1.0),),

            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    SingleChildScrollView(

                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.only(left:50), //apply padding to some sides only
                        constraints: const BoxConstraints(maxWidth:double.infinity),
                        child:Row(


                          children: [
                            Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6.0),
                                Text(
                                  'Basic Details',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                SizedBox(height: height * 0.03),
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
                                SizedBox(height: height * 0.03),
                                Text(
                                  'Personal Details',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                SizedBox(height: height * 0.03),

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
                                SizedBox(height: height * 0.03),
                                Text(
                                  'Present Address',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                SizedBox(height: height * 0.03),

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
                                SizedBox(height: height * 0.03),

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
                                SizedBox(height: height * 0.03),




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
                            SizedBox(width: width * .2),
                            Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6.0),

                                SizedBox(
                                  width: 100,height: 100,
                                  child: Image.asset('assets/images/ProfilePic.png'),
                                ),
                                SizedBox(height: height * 0.03),
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
                                SizedBox(height: height * 0.03),
                                Text(
                                  'Personal Details',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                SizedBox(height: height * 0.03),

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
                                SizedBox(height: height * 0.03),
                                Text(
                                  'Present Address',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                SizedBox(height: height * 0.03),

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
                                SizedBox(height: height * 0.03),

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
                                SizedBox(height: height * 0.03),




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

                          ],


                        )

                      ),

                    )
                  ]

              ),

            )

          ],


        ),
      ),





    );
  }

}

