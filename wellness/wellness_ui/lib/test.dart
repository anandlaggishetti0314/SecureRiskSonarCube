// import 'package:flutter/material.dart';

// class ResponsiveNavBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text('Responsive NavBar'),
//       actions: [
//         LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             if (constraints.maxWidth < 600) {
//               // Display dropdowns vertically for smaller screens
//               return Column(
//                 children: [
//                   PopupMenuButton<String>(
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         PopupMenuItem<String>(
//                           value: 'Item 1',
//                           child: Text('Item 1'),
//                         ),
//                         PopupMenuItem<String>(
//                           value: 'Item 2',
//                           child: Text('Item 2'),
//                         ),
//                       ];
//                     },
//                     onSelected: (String value) {
//                       navigateToScreen(value, context);
//                     },
//                   ),
//                   PopupMenuButton<String>(
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         PopupMenuItem<String>(
//                           value: 'Item 3',
//                           child: Text('Item 3'),
//                         ),
//                         PopupMenuItem<String>(
//                           value: 'Item 4',
//                           child: Text('Item 4'),
//                         ),
//                       ];
//                     },
//                     onSelected: (String value) {
//                       navigateToScreen(value, context);
//                     },
//                   ),
//                 ],
//               );
//             } else {
//               // Display dropdowns horizontally for larger screens
//               return Row(
//                 children: [
//                   PopupMenuButton<String>(
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         PopupMenuItem<String>(
//                           value: 'Item 1',
//                           child: Text('Item 1'),
//                         ),
//                         PopupMenuItem<String>(
//                           value: 'Item 2',
//                           child: Text('Item 2'),
//                         ),
//                       ];
//                     },
//                     onSelected: (String value) {
//                       navigateToScreen(value, context);
//                     },
//                   ),
//                   PopupMenuButton<String>(
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         PopupMenuItem<String>(
//                           value: 'Item 3',
//                           child: Text('Item 3'),
//                         ),
//                         PopupMenuItem<String>(
//                           value: 'Item 4',
//                           child: Text('Item 4'),
//                         ),
//                       ];
//                     },
//                     onSelected: (String value) {
//                       navigateToScreen(value, context);
//                     },
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }

//   void navigateToScreen(String value, BuildContext context) {
//     if (value == 'Item 1') {
//       Navigator.pushNamed(context, '/login');
//     } else if (value == 'Item 2') {
//       Navigator.pushNamed(context, '/signup');
//     } else if (value == 'Item 3') {
//       Navigator.pushNamed(context, '/item3');
//     } else if (value == 'Item 4') {
//       Navigator.pushNamed(context, '/item4');
//     }
//   }
// }


