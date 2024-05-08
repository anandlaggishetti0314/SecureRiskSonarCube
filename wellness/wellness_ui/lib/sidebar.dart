import 'package:flutter/material.dart';
import 'package:wellness_ui/ProfilePage.dart';
import 'package:wellness_ui/SideBarComponents/Intermediarydetails.dart';

class Sidebar extends StatelessWidget {
  // final ValueChanged<Widget> onSelectDashboard;
  final void Function(Widget) onSelectDashboard;
  // final VoidCallback onCreateRFQ;

  const Sidebar({
    required this.onSelectDashboard,
    // required this.onCreateRFQ,
  });

  @override
  Widget build(BuildContext context) {
    Color fieldTextColor = Color(0xFF71726F);

    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Card(
        elevation: 20,
        child: Container(
          
          width: 230,
          height: 1061,
          color: const Color(0xFFFFFFFF),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
      
                title: Text(
                  'Profile',
                  style: TextStyle(color: fieldTextColor,
                  ),
                ),
                onTap: () {
                  onSelectDashboard(ProfilePage(),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'My Orders',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {
                  onSelectDashboard(IntermediaryDashboardContent());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.file_copy,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'My Previous Orders',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.charging_station,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'My Lab Tests',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.data_array,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'My Consultation',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.details,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'My Health Records',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'Manage Payment',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'Buy Subscription',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.campaign_outlined,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'Need Help',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.contact_phone_rounded,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.density_large_sharp,
                  color: Color.fromARGB(251, 255, 255, 255),
                ),
                title: Text(
                  'About us',
                  style: TextStyle(color: fieldTextColor),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}