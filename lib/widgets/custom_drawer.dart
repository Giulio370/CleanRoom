import 'package:flutter/material.dart';
import '../screens/setup_screen.dart';
import '../screens/floor_selection_screen.dart';
import '../screens/rooms_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Hotel Columbia', style: TextStyle(color: Colors.white, fontSize: 24)),
            )
          ),
          ListTile(
            leading: Icon(Icons.bed_rounded),
            title: Text('Stanze'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RoomsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.layers_outlined),
            title: Text('Seleziona Piano'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FloorSelectionScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Setup'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SetupScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
