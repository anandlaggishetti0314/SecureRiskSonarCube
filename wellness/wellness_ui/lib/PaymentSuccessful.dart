
import 'package:flutter/material.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_icons.dart';
import 'package:wellness_ui/app_images.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessful> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<PaymentSuccessful> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Widget buildInputField({
    required String labelText,
    required String suffixIcon,
    required TextEditingController controller,
  }) {
    return Container(
      height: 40.0,
      constraints: const BoxConstraints(maxWidth: 401),
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
          Padding(
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
                            width: 144,
                            height: 99,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Payment Successful',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),

                          child:Column(
                          )
                        ),
                         Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/success_image.png',
                            width: 80,
                            height: 80,
                          ),
                        ),

                        const Padding(
                            padding: EdgeInsets.all(15),
                        child: Text('Your BASIC PLAN Subscription is success'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Find your plan details in email xxxxxid@gmail.co.com'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Track your order in My Order'),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final maxWidth =
                                constraints.maxWidth;
                            final buttonWidth = maxWidth < 400
                                ? maxWidth.toDouble()
                                : 400.0;

                            return Container(
                              width: buttonWidth,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty
                                      .all<Color>(AppColors
                                      .lightblueColor),
                                ),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      12.0),
                                  child: Text('View Subscription'),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
