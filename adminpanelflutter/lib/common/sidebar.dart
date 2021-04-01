import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/nav_item.dart';
import 'package:url_launcher/url_launcher.dart';

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
              leading: Icon(Icons.data_usage_rounded),
              title: Text("Data"),
              path: "/home",
            ),
            NavItem(
              leading: Icon(Icons.map_outlined),
              title: Text("View/Edit Admin Map"),
              onTap: _launchMapURL,
            ),
            NavItem(
              leading: Icon(Icons.person_add),
              title: Text("Add Employee"),
            ),
            NavItem(
              leading: Icon(Icons.edit),
              title: Text("Update Details"),
            ),
            NavItem(
              leading: Icon(Icons.delete_outline),
              title: Text("Remove Employee"),
            ),
            // NavItem(
            //   leading: Icon(Icons.list),
            //   title: Text("Table"),
            //   path: "/table",
            // ),
          ],
        ),
      ),
    );
  }

  void _launchMapURL() async =>
      await launch('https://techspace-trinetra.herokuapp.com/admin/map');
}
