import 'package:flutter/material.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_styles.dart';
import 'package:wellness_ui/app_images.dart';

class NewSubsPlan extends StatefulWidget {
  final dynamic data;
  const NewSubsPlan({super.key, this.data});

  @override
  State<NewSubsPlan> createState() => _NewSubsPlanState();
}

class _NewSubsPlanState extends State<NewSubsPlan> {
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
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.banner),
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
