import 'package:flutter/material.dart';

class IntermediaryDashboardContent extends StatefulWidget {
  @override
  _IntermediaryDashboardContentState createState() =>
      _IntermediaryDashboardContentState();
}

class _IntermediaryDashboardContentState
    extends State<IntermediaryDashboardContent> {
  bool isAddPopupOpen = false;

  void openAddPopup() {
    setState(() {
      isAddPopupOpen = true;
    });
  }

  void closeAddPopup() {
    setState(() {
      isAddPopupOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            PaginatedDataTable(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Button 1'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Button 2'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Button 3'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: openAddPopup,
                    child: Text('Add'),
                  ),
                ],
              ),
              columns: const [
                DataColumn(label: Text('S.No')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Product')),
                DataColumn(label: Text('Coverage')),
                DataColumn(label: Text('Created on')),
                DataColumn(label: Text('Updated on')),
              ],
              source: _IntermediaryDataSource(),
              onPageChanged: (pageIndex) {
                // Handle page change event
              },
              rowsPerPage: 5,
            ),
          ],
        ),
        if (isAddPopupOpen)
          Stack(
            children: [
              AbsorbPointer(
                absorbing: true,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.black54,
                ),
              ),
              Center(
                child: Container(
                  width: 400,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Create Product',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Product Name',
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Product Type',
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: closeAddPopup,
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _IntermediaryDataSource extends DataTableSource {
  final List<Map<String, String>> _data = [
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
    {
      'S.No': '01',
      'Name': 'John Doe',
      'Product': 'NonEB',
      'Coverage': '4',
      'Created on': '05-06-2023',
      'Updated on': '06-06-2023'
    },
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];
    return DataRow(cells: [
      DataCell(Text(row['S.No'] ?? '')),
      DataCell(Text(row['Name'] ?? '')),
      DataCell(Text(row['Product'] ?? '')),
      DataCell(Text(row['Coverage'] ?? '')),
      DataCell(Text(row['Created on'] ?? '')),
      DataCell(Text(row['Updated on'] ?? '')),
    ]);
  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
