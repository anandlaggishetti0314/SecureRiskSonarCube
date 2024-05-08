import 'package:flutter/material.dart';
import 'package:wellness_ui/AppandSidebar.dart';
import 'package:wellness_ui/order_summary.dart';

import 'package:wellness_ui/sidebar.dart';

class OrderSummarySidebar extends StatefulWidget {
  final List<String> checkedSymptoms;
  final dynamic data;
  const OrderSummarySidebar(
      {super.key, required this.checkedSymptoms, this.data});

  @override
  State<OrderSummarySidebar> createState() => _OrderSummarySidebarState();
}

class _OrderSummarySidebarState extends State<OrderSummarySidebar> {
  dynamic _data;
  List<String> _checkedSymptoms = [];
  bool _isSidebarOpen = true;
  Widget _selectedDashboard = const Dashboard();
  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _checkedSymptoms = widget.checkedSymptoms;
    _selectedDashboard = OrderSummary(
      checkedSymptoms: widget.checkedSymptoms,
      data: widget.data,
    );
  }

  final TextEditingController iconController = TextEditingController();

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _selectDashboard(Widget dashboard) {
    setState(() {
      _selectedDashboard = dashboard;
    });
  }

  @override
  Widget build(BuildContext context) {
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
