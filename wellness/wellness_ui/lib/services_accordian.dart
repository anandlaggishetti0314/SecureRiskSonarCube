import 'package:flutter/material.dart';

class AccordionExample extends StatefulWidget {
  @override
  _AccordionExampleState createState() => _AccordionExampleState();
}

class _AccordionExampleState extends State<AccordionExample> {
  List<Map<String, dynamic>> apiResponse = [
    {
      'title': 'Accordion Title 1',
      'data': [
        {
          'name': 'Alert1',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert2',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert3',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
      ],
    },
    {
      'title': 'Accordion Title 2',
      'data': [
        {
          'name': 'Alert4',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert5',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
      ],
    },
    {
      'title': 'Accordion Title 3',
      'data': [
        {
          'name': 'Alert6',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert7',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
        {
          'name': 'Alert8',
          'free': 0,
          'basic': 1,
          'standard': '1',
          'premium': 1,
          'ultimate': 1
        },
      ],
    },
  ];

  List<AccordianItem> _items = [];

  @override
  void initState() {
    super.initState();
    _items = apiResponse
        .map((item) => AccordianItem(
              title: item['title'],
              data: List<Map<String, dynamic>>.from(item['data']),
              isExpanded: false,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accordion Example'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !isExpanded;
              });
            },
            children: _items.map<ExpansionPanel>((AccordianItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        item.isExpanded = !isExpanded;
                      });
                    },
                    child: Container(
                      color: Colors.lightBlue, // Change the background color of the title
                      child: ListTile(
                        leading: Icon(
                          item.isExpanded ? Icons.remove : Icons.add,
                          color: Colors.white, // Set the color of the + and - icons
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white, // Change the text color of the title
                            fontWeight: FontWeight.bold,
                          ),
                          
                        ),
                        
                      ),
                    ),
                  );
                },
                body: item.isExpanded
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: item.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(item.data[index]['name']),
                                Icon(
                                  item.data[index]['free'] == 1 ? Icons.check : Icons.close,
                                  color: Colors.black, // Set the color of the check and close icons
                                ),
                                Icon(
                                  item.data[index]['basic'] == 1 ? Icons.check : Icons.close,
                                  color: Colors.black, // Set the color of the check and close icons
                                ),
                                Icon(
                                  item.data[index]['standard'] == '1' ? Icons.check : Icons.close,
                                  color: Colors.black, // Set the color of the check and close icons
                                ),
                                Icon(
                                  item.data[index]['premium'] == 1 ? Icons.check : Icons.close,
                                  color: Colors.black, // Set the color of the check and close icons
                                ),
                                Icon(
                                  item.data[index]['ultimate'] == 1 ? Icons.check : Icons.close,
                                  color: Colors.black, // Set the color of the check and close icons
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox.shrink(), // Hide the body when not expanded
                isExpanded: item.isExpanded,
                canTapOnHeader: true, // Enable tapping on the header
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class AccordianItem {
  String title;
  List<Map<String, dynamic>> data;
  bool isExpanded;

  AccordianItem({
    required this.title,
    required this.data,
    required this.isExpanded,
  });
}
