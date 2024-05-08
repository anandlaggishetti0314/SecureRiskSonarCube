import 'package:flutter/material.dart';
import 'package:wellness_ui/app_colors.dart';
import 'package:wellness_ui/app_images.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    String? chosenValue;

    // List of items in our dropdown menu

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.125,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                    ),
                    child: Image.asset(
                      AppImages.logo,
                      width: screenWidth * 0.1,
                    )),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.29),
                  child: TextButton(
                    onPressed: () {
                      // Add your button press logic here
                    },
                    child: const Text(
                      'HOME',
                      style: TextStyle(
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: TextButton(
                    onPressed: () {
                      // Add your button press logic here
                    },
                    child: const Text('PRODUCT',
                        style:
                            TextStyle( color: AppColors.textColor,)),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: TextButton(
                    onPressed: () {
                      // Add your button press logic here
                    },
                    child: const Text(
                      'ABOUT',
                      style: TextStyle( color: AppColors.textColor,),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return Quote();
                        //     });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        backgroundColor: const Color.fromRGBO(110, 201, 241, 1),
                      ),
                      child: const Text(
                        'GET QUOTE',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/login_page',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('LOGIN',
                              style: TextStyle(
                                  color: Color.fromRGBO(113, 114, 111, 1))),
                          SizedBox(width: 18),
                          Icon(
                            Icons.arrow_circle_right_rounded,
                            size: 40,
                            color: Color.fromRGBO(110, 201, 241, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your button press logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('9000000000',
                              style: TextStyle(
                                  color: Color.fromRGBO(113, 114, 111, 1))),
                          //SizedBox(width: 8),
                          Icon(
                            Icons.phone_in_talk_rounded,
                            color: Color.fromRGBO(110, 201, 241, 1),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 60,
                  height: 50,
                ),
                SizedBox(
                  child: InkWell(
                      onTap: () {
                        print('hi');
                      },
                      child: const Text(
                        'PRICING',
                        style: TextStyle(color: AppColors.textColor),
                      )),
                ),
                SizedBox(
                  child: InkWell(
                      onTap: () {
                        print('hi');
                      },
                      child: const Text(
                        'Get A Quote',
                        style: TextStyle(color: AppColors.textColor),
                      )),
                ),
                SizedBox(
                  child: InkWell(
                      onTap: () {
                        print('hi');
                      },
                      child: const Text(
                        'Get In Touch',
                        style: TextStyle(color: AppColors.textColor),
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                          Icons.language), // Place the icon inside the dropdown
                      SizedBox(
                          width:
                              8), // Add some spacing between the icon and text
                      DropdownButton<String>(
                        value: chosenValue,
                        // style: TextStyle(
                        //     color: Colors.grey), // Set the text color to grey
                        items: <String>[
                          'Android',
                          'IOS',
                          'Flutter',
                          'Node',
                          'Java',
                          'Python',
                          'PHP',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          "Please choose a language",
                          style: TextStyle(
                            // color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            chosenValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Expanded(child: )
          ],
        ),
      ),
    );
  }
}
