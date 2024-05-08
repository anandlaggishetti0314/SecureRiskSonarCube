import 'package:flutter/material.dart';
import 'package:wellness_ui/login_screen.dart';

import 'app_colors.dart';
import 'app_icons.dart';
import 'app_styles.dart';

class CommonAppBar extends StatefulWidget {
  const CommonAppBar({super.key});

  @override
  State<CommonAppBar> createState() => _CommonAppBarPageState();
}

class _CommonAppBarPageState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
            // Tablet and larger layout
            return buildWebLayout();
        },
      ),
    );
  }

  Widget buildWebLayout() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: screenHeight * 0.112,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                    ),
                    child: Image.asset(
                      "assets/images/logo_wellness.png",
                      width: 50,
                      height: 50,
                    )),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: TextButton(
                    onPressed: () {
                      // Add your button press logic here
                    },
                    child: const Text(
                      'PRICING',
                      style: TextStyle(
                        color: Color.fromRGBO(32, 37, 41, 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.0,
                ),
                child: TextButton(
                  onPressed: () {
                    // Add your button press logic here
                  },
                  child: const Text('GET A QUOTE',
                      style:
                      TextStyle(color: Color.fromRGBO(32, 37, 41, 1.0))),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.01),
                  child: TextButton(
                    onPressed: () {
                      // Add your button press logic here
                    },
                    child: const Text(
                      'GET IN TOUCH',
                      style: TextStyle(color: Color.fromRGBO(32, 37, 41, 1.0)),
                    ),
                  ),
                ),
              ),


            ],

          ),

        ),
      ),
    );
  }
}
