import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/nav_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Sidebar extends StatefulWidget {
  @override
  _SideScreenState createState() => _SideScreenState();
}

class _SideScreenState  extends State<Sidebar> {

  final _formKey = GlobalKey<FormState>();
  PlatformFile objFile = null;
  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
    }
  }
  void uploadSelectedFile(String e, String n, String p) async {
    Map body = {"username": "admin", "password": "admin123"};
    var url = Uri.parse('https://techspace-trinetra.herokuapp.com/login');
    Map<String, String> headtoken = {
      'Content-type': 'application/json; charset=UTF-8',
    };
    var restoken =
    await http.post(url, body: jsonEncode(body), headers: headtoken);
    var admindata = jsonDecode(restoken.body);
    String token = admindata['token'];

    Map<String, String> headuser = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    //---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://techspace-trinetra.herokuapp.com/register"),
    );

    request.headers['Content-type'] = "application/json; charset=UTF-8";
    request.headers["Authorization"] = 'Bearer $token';
    request.headers["Accept"] = 'application/json';

    //-----add other fields if needed
    request.fields["employee_id"] = e;
    request.fields["name"] = n;
    request.fields["phone"] = p;
    //-----add selected file with request
    request.files.add(new http.MultipartFile(
        "photo", objFile.readStream, objFile.size,
        filename: objFile.name));

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
  }

  adddata() async {
    TextEditingController _eid = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Data '),
          content: TextField(
            controller: _eid,
            decoration:
            InputDecoration(hintText: "Enter User ID to Add details"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                String docid = _eid.text;
                String name = "";
                String phoneno = "";
                TextEditingController nm = TextEditingController();
                TextEditingController pno = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nm,
                                decoration: InputDecoration(
                                    labelText: ' Enter Full Name'),
                              ),
                              TextFormField(
                                controller: pno,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    labelText: 'Enter Phone No'),
                              ),
                              IconButton(
                                icon: new Icon(Icons.image),
                                iconSize: 25,
                                onPressed: () => chooseFileUsingFilePicker(),
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: TextButton(
                                  onPressed: () {
                                    uploadSelectedFile(
                                        docid, nm.text, pno.text);
                                    // Navigator.pop(context);
                                    // Navigator.pop(context);
                                    Alert(
                                      context: context,
                                      type: AlertType.success,
                                      title: "New Member Added ",
                                      desc: "${docid} Registered Successfully",
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "COOL",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          width: 120,
                                        )
                                      ],
                                    ).show();

                                  },
                                  child: Text('Submit'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        );
      },
    );
  }

  updatedata() async {
    TextEditingController _eid = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Data '),
          content: TextField(
            controller: _eid,
            decoration:
            InputDecoration(hintText: "Enter User ID to Update details"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                String docid = _eid.text;
                String name = "";
                String phoneno = "";
                TextEditingController nm = TextEditingController();
                TextEditingController pno = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nm,
                                decoration: InputDecoration(
                                    labelText: ' Enter Full Name'),
                              ),
                              TextFormField(
                                controller: pno,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    labelText: 'Enter Phone No'),
                              ),
                              IconButton(
                                icon: new Icon(Icons.image),
                                iconSize: 25,
                                onPressed: () => chooseFileUsingFilePicker(),
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: TextButton(
                                  onPressed: () {
                                    uploadSelectedFile(
                                        docid, nm.text, pno.text);
                                    Alert(
                                      context: context,
                                      type: AlertType.success,
                                      title: " Member Updated ",
                                      desc: "${docid} Updated succesfully Successfully",
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "COOL",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          },
                                          width: 120,
                                        )
                                      ],
                                    ).show();
                                  },
                                  child: Text('Submit'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        );
      },
    );
  }


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
              onTap: adddata,
            ),
            NavItem(
              leading: Icon(Icons.edit),
              title: Text("Update Details"),
              onTap: updatedata,
            ),
          ],
        ),
      ),
    );
  }

  void _launchMapURL() async =>
      await launch('https://techspace-trinetra.herokuapp.com/admin/map');
}
