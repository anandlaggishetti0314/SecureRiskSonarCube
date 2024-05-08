import 'package:flutter/material.dart';
import 'package:wellness_ui/login_screen.dart';
import 'package:wellness_ui/subscription_pricing.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return buildMobileLayout();
          } else {
            // Tablet and larger layout
            return buildWebLayout();
          }
        },
      ),
    );
  }

  Widget buildMobileLayout() {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: maxHeight * 0.13,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.01),
              child: Image.asset(
                "assets/images/logo_wellness.png",
                width: 60,
                height: 50,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.3),
                child: const Icon(Icons.menu,
                    color: Color.fromRGBO(113, 114, 111, 1)))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(110, 201, 241, 1),
              height: maxHeight * 0.30,
              child: const Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '''Get Insurance Policy 
and Save 20%!''',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildWebLayout() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.112,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.01,
                    ),
                    child: Image.asset(
                      "assets/images/logo_wellness.png",
                    )),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.01),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubscriptionPricing()),
                      );
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
                      style: TextStyle(color: Color.fromRGBO(32, 37, 41, 1.0))),
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
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
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
                          ),

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: const Color.fromRGBO(110, 201, 241, 1),
              height: screenHeight * 0.80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background_latest.png"),
                    fit: BoxFit.cover),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 160.0),
                        child: Text(
                          '''Buy this offer
@25% off !
on Medicine Orders''',
                          style: TextStyle(
                            color: Colors.white,
                            height: 1.3,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, right: 290.0),
                        child: SizedBox(
                          height: 64.0,
                          width: 204.0,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              // Add your onPressed code here!
                            },
                            backgroundColor: Colors.deepOrange,
                            label: Row(
                              children: [
                                 Text(
                                  'Buy Now',
                                  style: ralewayStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.whiteColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // Image(image: AssetImage('assets/images/Caspture.png')),
                      Padding(
                        padding: const EdgeInsets.only(top: 46.0, left: 1),
                        child: Image.asset(
                          'assets/images/medicine.png',
                          height: 400,
                          width: 494,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                        "Wellness Program for Corporate",

                        style: TextStyle(
                            color:Color.fromRGBO(112, 112, 112, 1.0),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                  ),
                ],
              ),
              ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Corporate wellness programs are employee health benefits plans created to support and foster a comprehensive approach to well-being. These "
                          "\n                                                                     programs help create a culture of health on an organizational scale.",

                      style: TextStyle(
                          color:Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/health.png',
                        ),
                        Container(
                          height: 100,
                          width: 220,
                          child: Card(
                            child:Center(
                              child: Text('Enhanced Health',
                                textAlign: TextAlign.center,
                                style: ralewayStyle.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkblue,
                                ),

                              ),

                            ),


                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/productivity.png',
                        ),
                        Container(
                          height: 100,
                          width: 220,
                          child: Card(
                            child:Center(
                              child: Text('Increased Productivity',
                                textAlign: TextAlign.center,
                                style: ralewayStyle.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkblue,
                                ),

                              ),

                            ),


                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/retention.png',
                        ),
                        Container(
                          height: 100,
                          width: 220,
                          child: Card(
                            child:Center(
                              child: Text('Improved Retention',
                                textAlign: TextAlign.center,
                                style: ralewayStyle.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkblue,
                                ),

                              ),

                            ),


                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/healthrisks.png',
                        ),
                        Container(
                          height: 100,
                          width: 220,
                          child: Card(
                            child:Center(
                              child: Text('Decreased Health Risks',
                                textAlign: TextAlign.center,
                                style: ralewayStyle.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkblue,
                                ),

                              ),

                            ),


                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/CostsforEmployees.png',
                        ),
                        Container(
                          height: 100,
                          width: 220,
                          child: Card(
                            child:Center(
                              child: Text('Fewer Health Costs for Employees',
                                textAlign: TextAlign.center,
                                style: ralewayStyle.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkblue,
                                ),

                              ),

                            ),


                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),

            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                new TextButton(
                  child:Padding(
                 padding:EdgeInsets.all(10),

              child:Text("Get Started",
              style:TextStyle(fontSize: 15, color: Colors.white),
            ),
            ),
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty
                        .all<Color>(AppColors
                        .orange,),
                  ),
                ),
                Container(height: 20.0),//SizedBox(height: 20.0),
              ],
            ),

           Container(
      width: 1500,
      height: 150,
      color: const Color(0xFF71726F),


      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,

        children: <Widget>[

          Container(

            height: 20,
            width: 100,
            child: Card(
              semanticContainer: true,

             child: Row(

               children: <Widget>[
                 Container(
                   width: 40,
                   height: 50,
                   child: Image.asset('assets/images/retention.png'),

                 ),
                Expanded(child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    Text('HRA'),
                    Text('A health risk assessment is an instrument used to collect health information',
                        style:
                        TextStyle(fontSize: 10, color: Colors.black)
                    ),
                  ],
                ),
                ),


               ],
             ),
            ),

          ),
          Container(

            height: 50,
            width: 220,
            child: Card(

              child: Row(

                children: <Widget>[
                  Container(
                    width: 40,
                    height: 50,
                    child: Image.asset('assets/images/retention.png'),

                  ),
                  Expanded(child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      Text('HRA'),
                      Text('A health risk assessment is an instrument used to collect health information',
                          style:
                          TextStyle(fontSize: 10, color: Colors.black)
                      ),
                    ],
                  ),
                  ),


                ],
              ),
            ),

          ),
          Container(

            height: 50,
            width: 220,
            child: Card(

              child: Row(

                children: <Widget>[
                  Container(
                    width: 40,
                    height: 50,
                    child: Image.asset('assets/images/retention.png'),

                  ),
                  Expanded(child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      Text('HRA'),
                      Text('A health risk assessment is an instrument used to collect health information',
                          style:
                          TextStyle(fontSize: 10, color: Colors.black)
                      ),
                    ],
                  ),
                  ),


                ],
              ),
            ),

          ),
          Container(

            height: 50,
            width: 220,
            child: Card(

              child: Row(

                children: <Widget>[
                  Container(
                    width: 40,
                    height: 50,
                    child: Image.asset('assets/images/retention.png'),

                  ),
                  Expanded(child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      Text('HRA'),
                      Text('A health risk assessment is an instrument used to collect health information',
                          style:
                          TextStyle(fontSize: 10, color: Colors.black)
                      ),
                    ],
                  ),
                  ),


                ],
              ),
            ),

          ),
          Container(

            height: 50,
            width: 220,
            child: Card(

              child: Row(

                children: <Widget>[
                  Container(
                    width: 40,
                    height: 50,
                    child: Image.asset('assets/images/retention.png'),

                  ),
                  Expanded(child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      Text('HRA'),
                      Text('A health risk assessment is an instrument used to collect health information',
                          style:
                          TextStyle(fontSize: 10, color: Colors.black)
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



    //f***************************************footer********************************************
            Container(
              height: screenHeight * 0.4,

              // width: double.infinity,

              color: Colors.grey,

              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/Template.png",
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('''Securisk Insurance Brokers (P) Ltd.
IRDA Registration # 597,Validity May 1st 2013 – 
April 30th 2023, CIN : U67200PB2013PTC037781''',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(
                        width: 150,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Registered Office",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text('''33, Ground Floor, Nirmal Chhaya 
Apartments, MIG Flats Block – C, 
Rishi Nagar Ludhiana 141001''',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_in_talk_rounded,
                                color: Color.fromRGBO(110, 201, 241, 1),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("+91 7498443677",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Corporate Office",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text('''# B – 406, 4th Floor, Mahavir Icon, 
Plot # 89 – 90, Sector 15, CBD 
Belapur, Navi Mumbai – 4000614''',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_in_talk_rounded,
                                color: Color.fromRGBO(110, 201, 241, 1),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("022-49707155",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Branch Office",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text('''Shop 3B, Commercial Street, 
Lanco Hills, Manikonda Jagir, 
Hyderabad - 500089, Telangana.''',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFFFFFFFF))),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_in_talk_outlined,
                                color: Color.fromRGBO(110, 201, 241, 1),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("+91 99853035655",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                          "© 2023 Securisk Insurance Brokers (P) Ltd. All rights reserved.",
                          style: TextStyle(fontSize: 13, color: Colors.white)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Terms and Conditions | Privacy Policies",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
