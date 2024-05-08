import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginapp/Authentication/AuthGaurd.dart';
import 'package:loginapp/SideBarComponents/AppBar.dart';
import 'Graphs/Updated.dart';

class MainDashboard extends StatefulWidget {
  MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  AuthGaurd authGaurd = new AuthGaurd();

  @override
  void initState() {
    super.initState();
    authGaurd.authenticateUser().then((data) {
      if (data == false) {
        Navigator.of(context).pushReplacementNamed('/login_page');
      }
    }).catchError((error) {
      ('Error fetching API data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size w = MediaQuery.of(context).size;
    double screenHeight = w.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: AppBarExample(),
      ),
      //  body: MyCardLayout(),
      body: Updated(),
      // body: LocationBased(),
    );
  }
}

class MyCardLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        // ContainerWithPartitions(),
        Expanded(
          child: Row(
            children: <Widget>[
              Flexible(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  elevation: 4,
                  child: Container(
                    width: screenWidth / 2,
                    height: screenHeight - 100 / 2,
                    alignment: Alignment.center,
                    // child: Donutgraph(),
                  ),
                ),
              ),
              Flexible(
                child: Card(
                  elevation: 4,
                  child: Container(
                    width: screenWidth / 2,
                    height: screenHeight - 100 / 2,
                    alignment: Alignment.center,
                    //    child: ChartWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  MyCard(this.text, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 30),
        ),
      ),
    );
  }
}
