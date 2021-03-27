import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/nav_item.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        shape: BoxShape.rectangle,
      ),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "Trinetra Admin Panel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            NavItem(
              leading: Icon(Icons.home),
              title: Text("Home"),
              path: "/home",
            ),
            NavItem(
              leading: Icon(Icons.list),
              title: Text("Table"),
              path: "/table",
            ),
          ],
        ),
      ),
    );
  }
}
