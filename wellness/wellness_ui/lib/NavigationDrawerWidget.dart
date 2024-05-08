




import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationDrawerWidger extends StatelessWidget {

  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.people,

            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
}){

    final color = Colors.white;
    return ListTile(

      leading: Icon(icon,color: color,),
      title: Text(text,style: TextStyle(color: color)),
      onTap: (){},

    );
  }

  
}