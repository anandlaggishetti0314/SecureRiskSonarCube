import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
class Allrfqs extends StatefulWidget {
  final VoidCallback onCreateRFQ;

  const Allrfqs({required this.onCreateRFQ});

  @override
  _AllrfqsState createState() => _AllrfqsState();
}

class _AllrfqsState extends State<Allrfqs> {
  int? _selectedPagination;
  String? _selectedFilter;
  int _currentPage = 1;
  int _pageSize = 10;
  List<Employee> _data = [];
  List<Employee> _filteredData = [];
  int totalPages = 1;
  String _searchText = '';

  List<int> _paginationOptions = [5, 10, 15, 20];
  List<String> _filterOptions = [
    'Processing',
    'Pending',
    'Submitted',
    'Closed',
    'Lost'
  ];

  @override
  void initState() {
    super.initState();
    _selectedPagination = 10;
    _fetchData();
  }

  void _handlePaginationChange(int? newValue) {
    setState(() {
      _selectedPagination = newValue;
      _pageSize = newValue!;
      totalPages = (_filteredData.length / _pageSize).ceil();
      _currentPage = 1;
    });
  }

  void _fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.4.58:9763/rfq/allRfq'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(response.body) as List<dynamic>;

        setState(() {
          _data = jsonData.map((json) => Employee.fromJson(json)).toList();
          _filteredData = getFilteredData();
          totalPages = (_filteredData.length / _pageSize).ceil();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (exception) {
      print('Exception: $exception');
    }
  }

  void _handleFilterByChange(String? newValue) {
    setState(() {
      _selectedFilter = newValue;
      _filteredData = getFilteredData();
      totalPages = (_filteredData.length / _pageSize).ceil();
      _currentPage = 1;
    });
  }

  List<Employee> getFilteredData() {
    if (_selectedFilter == null) {
      return _data;
    } else {
      return _data.where((item) => item.appStatus == _selectedFilter).toList();
    }
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _handleSearch(String value) {
    setState(() {
      _searchText = value;
      _filteredData = getFilteredData();
      if (_searchText.isNotEmpty) {
        _filteredData = _filteredData
            .where((item) =>
                item.product.contains(_searchText) ||
                item.productCategory
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()) ||
                item.appStatus
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
            .toList();
      }
      totalPages = (_filteredData.length / _pageSize).ceil();
      _currentPage = 1;
    });
  }

  List<Employee> getCurrentPageData() {
    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    return _filteredData.sublist(
        startIndex, endIndex.clamp(0, _filteredData.length));
  }

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Employee> currentPageData = getCurrentPageData();
    bool hasPreviousPage = _currentPage > 1;
    bool hasNextPage = _currentPage < totalPages;

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 233, 249, 251),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: 208,
                          height: 37,
                          child: TextField(
                            controller: _searchController,
                            onChanged: _handleSearch,
                            decoration: InputDecoration(
                              labelText: 'Search',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _handleSearch(_searchController.text);
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          width: 208,
                          height: 37,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton<String>(
                              value: _selectedFilter,
                              onChanged: _handleFilterByChange,
                              items: _filterOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isExpanded: true,
                              underline: SizedBox(),
                              icon: Icon(Icons.arrow_drop_down),
                              hint: Text('Filter By'),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Spacer(),
                      Spacer(),
                      Align(
                        child: Container(
                          width: 113.8,
                          height: 37,
                          child: ElevatedButton(
                            onPressed: widget.onCreateRFQ,
                            child: Text('Create RFQ'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SfDataGrid(
                    source: EmployeeDataSource(currentPageData),
                    columnWidthMode: ColumnWidthMode.fill,
                    columns: [
                      GridColumn(
                        columnName: 'S.No',
                        label: Container(
                          color: Colors.amber,
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'S.No',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Product Category',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Product Category',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Product',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Product',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Task',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Task',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Insurer',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Insurer',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Nature of business',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Nature of Business',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Phone no',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Phone no',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Email id',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Email id',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Status',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Status',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Created by',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Created by',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Options',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'options',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Items per page:'),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      value: _selectedPagination,
                      onChanged: _handlePaginationChange,
                      items: _paginationOptions.map((option) {
                        return DropdownMenuItem<int>(
                          value: option,
                          child: Text(option.toString()),
                        );
                      }).toList(),
                    ),
                    TextButton(
                      child: Text('Previous'),
                      onPressed: hasPreviousPage
                          ? () {
                              _goToPage(_currentPage - 1);
                            }
                          : null,
                    ),
                    SizedBox(width: 10),
                    for (int i = 1; i <= totalPages; i++)
                      TextButton(
                        child: Text(
                          i.toString(),
                          style: TextStyle(
                            fontWeight: i == _currentPage
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                          _goToPage(i);
                        },
                      ),
                    SizedBox(width: 10),
                    TextButton(
                      child: Text('Next'),
                      onPressed: hasNextPage
                          ? () {
                              _goToPage(_currentPage + 1);
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  final List<Employee> employees;

  EmployeeDataSource(this.employees);

  @override
  List<DataGridRow> get rows =>
      employees.asMap().entries.map<DataGridRow>((entry) {
        final index = entry.key;
        final item = entry.value;
        return DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'S.No', value: (index + 1).toString()),
          DataGridCell<String>(
              columnName: 'Product Category', value: item.productCategory),
          DataGridCell<String>(columnName: 'Product', value: item.product),
          DataGridCell<String>(columnName: 'Task', value: item.policyType),
          DataGridCell<String>(columnName: 'Insurer', value: item.insurerName),
          DataGridCell<String>(
              columnName: 'Nature of business', value: item.nob),
          DataGridCell<String>(columnName: 'Phone no', value: item.phNo),
          DataGridCell<String>(columnName: 'Email id', value: item.email),
          DataGridCell<String>(columnName: 'Status', value: item.appStatus),
          DataGridCell<String>(
              columnName: 'Created by', value: item.createDate),
          DataGridCell<String>(columnName: 'Options', value: ''),
        ]);
      }).toList();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'Options') {
          return Row(children: [
            IconButton(
              onPressed: () {
                // Handle delete button action for the current row
              },
              icon: Icon(
                Icons.delete,
                color: Color.fromARGB(255, 252, 0, 0),
              ),
            ),
            IconButton(
              onPressed: () {
                // Handle edit button action for the current row
              },
              icon: Icon(Icons.edit_note),
            ),
            IconButton(
              onPressed: () {
                // Handle edit button action for the current row
              },
              icon: Icon(Icons.download),
            ),
          ]);
        } else {
          return Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              dataCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      }).toList(),
    );
  }
}

class Employee {
  Employee({
    required this.product,
    required this.productCategory,
    required this.policyType,
    required this.insurerName,
    required this.nob,
    required this.phNo,
    required this.email,
    required this.appStatus,
    required this.createDate,
  });

  final String product;
  final String productCategory;
  final String policyType;
  final String insurerName;
  final String nob;
  final String phNo;
  final String email;
  final String appStatus;
  final String createDate;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      product: json['product'] as String? ?? '',
      productCategory: json['productCategory'] as String? ?? '',
      policyType: json['policyType'] as String? ?? '',
      insurerName: json['insurerName'] as String? ?? '',
      nob: json['nob'] as String? ?? '',
      phNo: json['phNo'] as String? ?? '',
      email: json['email'] as String? ?? '',
      appStatus: json['appStatus'] as String? ?? '',
      createDate: json['createDate'] as String? ?? '',
    );
  }
}
