import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:wellness_ui/NewProfile.dart';
import 'package:wellness_ui/sidebar.dart';
import 'ProfilePage.dart';
import 'SideBarComponents/AllRFQS.dart';
import 'SideBarComponents/CreateRFQ.dart';
import 'SideBarComponents/Intermediarydetails.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();

  void logout(BuildContext context) {
    toastification.showSuccess(
      context: context,
      autoCloseDuration: const Duration(seconds: 2),
      title: 'Acount Logout successfully',
    );
    Timer timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/landing_Page');
    });
    print("logout......");
  }
}

class DashboardState extends State<Dashboard> {
  bool _isSidebarOpen = true;
  Widget _selectedDashboard = NewProfilePage();
  IconLabel? selectedIcon;
  final TextEditingController iconController = TextEditingController();

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _openRFQPage() {
    setState(() {
      _selectedDashboard = CreateRFQ();
    });
  }

  void _selectDashboard(Widget dashboard) {
    setState(() {
      if (dashboard is Allrfqs) {
        _selectedDashboard = Allrfqs(onCreateRFQ: _openRFQPage);
      } else {
        _selectedDashboard = dashboard;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<IconLabel>> iconEntries =
        <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries
          .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
                height: 47.71,
              ),
              SizedBox(width: 8),
            ],
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: _toggleSidebar,
            icon: Icon(_isSidebarOpen ? Icons.close : Icons.menu),
            color: Colors.black,
          ),
        ),
        body: Row(
          children: [
            if (_isSidebarOpen)
              Sidebar(
                onSelectDashboard: _selectDashboard,
                // onCreateRFQ: _openRFQPage,
              ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: _selectedDashboard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



enum IconLabel {
  smile('Sridhar Budharapu', Icons.sentiment_satisfied_outlined),
  brush('Change PassWord', Icons.brush_outlined),
  heart('Logout', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
