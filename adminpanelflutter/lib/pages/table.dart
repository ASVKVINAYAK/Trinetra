import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/base.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}
// ignore: camel_case_types
class Userdetails
{
  Userdetails({this.n,this.pno});
    String n;
    int pno;
}

class _TableScreenState extends State<TableScreen> {
  final _formKey = GlobalKey<FormState>();
  Userdetails userdetails = new Userdetails();
  var _url = 'https://techspace-trinetra.herokuapp.com/admin/map';
  void _launchURL() async => await launch(_url);


  //for adding data
  adddata()
  async{

    TextEditingController _eid = TextEditingController();
    showDialog(
        context: context,
        builder: (context)
    {
      return AlertDialog(
        title: Text('Add Data '),
        content: TextField(
          controller: _eid,
          decoration: InputDecoration(
              hintText: "Enter User ID to Add details"),
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
              onPressed: (){
                String docid=_eid.text;
                String name="";
                String phoneno="";
                String imei="";
                TextEditingController nm = TextEditingController();
                TextEditingController pno = TextEditingController();
                TextEditingController imeino = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context)
                {
                  return AlertDialog(
                    content: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: nm,
                            decoration: InputDecoration(labelText: ' Enter Full Name'),
                          ),
                          TextFormField(
                            controller: pno,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(labelText: 'Enter Phone No'),
                          ),
                          TextFormField(
                            controller: imeino,
                            decoration: InputDecoration(labelText: 'Enter IMEI No'),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: TextButton(
                              onPressed: () {
                                name=nm.text;
                                phoneno=pno.text;
                                imei=imeino.text;
                                  Map<String, dynamic> demodata = {"name": name, "phone no": phoneno, "IMEI": imei};
                                  DocumentReference documentReference = FirebaseFirestore
                                      .instance.collection('users').doc(docid);
                                  documentReference.set(demodata);
                                  Navigator.pop(context);
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "User added Successfully",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              },
                              child: Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),

                  );
                }
                );
              },
          ),
        ],
      );
    },
    );
  }

  //for deleting data
    deletedata()
    async{
      TextEditingController _name = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete User Details'),
            content: TextField(
              controller: _name,
              decoration: InputDecoration(hintText: "Enter User ID to delete details"),
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
                onPressed: () async {
                  String dc=_name.text;
                  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('users').doc(dc).get();
                  bool isDocExists = docSnapshot.exists; //true if exists and false otherwise
                  if (isDocExists== false) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "User not found",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else
                  {
                    DocumentReference removedata = FirebaseFirestore.instance.collection('users').doc(dc);
                    removedata.delete();
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "User Deleted Successfully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }


    //for updating data
    updatedata()
    async{
      TextEditingController _eid = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update'),
            content: TextField(
              controller: _eid,
              decoration: InputDecoration(hintText: "Enter User ID to Update details"),
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
                onPressed: () async {
                  String dc=_eid.text;
                  String name="";
                  String imei="";
                  String phoneno="";
                  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('users').doc(dc).get();
                  bool isDocExists = docSnapshot.exists; //true if exists and false otherwise
                  if (isDocExists== false) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "User not found",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else {
                    DocumentReference updata = FirebaseFirestore.instance.collection('users').doc(dc);
                  TextEditingController n = TextEditingController();
                  TextEditingController pno = TextEditingController();
                    TextEditingController imeino = TextEditingController();
                  showDialog(
                      context: context,
                      builder: (context)
                      {
                        return AlertDialog(
                          content: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: n,
                                  decoration: InputDecoration(labelText: ' Enter Full Name'),
                                ),
                                TextFormField(
                                  controller: pno,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(labelText: 'Enter Phone no'),
                                ),
                                TextFormField(
                                  controller: imeino,
                                  decoration: InputDecoration(labelText: ' Enter IMEI no'),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: TextButton(
                                    onPressed: () {
                                        String tempimei="";
                                        String tempno="";
                                        String tempname="";
                                      CollectionReference collectionReference = FirebaseFirestore.instance
                                          .collection('users');
                                      collectionReference.snapshots().listen((snapshot) {
                                       List doc = snapshot.docs;
                                       int no=doc.length;
                                       print(snapshot.docs[0].id);
                                        int i = 0;
                                        while (true) {
                                          if (i >= no) {
                                            break;
                                          }
                                          if(snapshot.docs[i].id==dc)
                                            {
                                                tempimei=snapshot.docs[i].get('IMEI');
                                                tempno=snapshot.docs[i].get('phone no');
                                                tempname=snapshot.docs[i].get('name');
                                                print(snapshot.docs[i].get('IMEI'));
                                            }
                                          i++;
                                        }
                                      });
                                      name=n.text;
                                      phoneno=pno.text;
                                      imei=imeino.text;

                                      if(name=="")
                                        {
                                          name=tempname;
                                        }
                                        if(phoneno=="")
                                        {
                                          phoneno=tempno;
                                        }
                                        if(imei=="")
                                        {
                                          imei=tempimei;
                                        }
                                      Map<String, dynamic> demodata = {"name": name, "phone no": phoneno,"IMEI":imei};
                                      updata.update(demodata);
                                      Navigator.pop(context);
                                        Navigator.pop(context);


                                      Fluttertoast.showToast(
                                          msg: "User Updated Successfully",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 5,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.black87,
                                          fontSize: 16.0
                                      );
                                    },
                                    child: Text('Submit'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
                },
              ),
            ],
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {

      WebViewController _webviewController;
      WebView(
        initialUrl: '',
        onWebViewCreated: (WebViewController webViewController) {
          _webviewController = webViewController;
        },
      );
    var cardtextstyle=TextStyle(fontFamily: "Montserrat Regular",fontSize: 20,color: Colors.white);
      return BaseScreen(
        title: "Manage",
          body: Container(
            color: Colors.white,
            child:Expanded(
              child: GridView.count(
                crossAxisSpacing: 50,
                mainAxisSpacing: 40,
                crossAxisCount: 3,
                children: <Widget>[
                 Card(
                   color: Colors.lightBlueAccent,
                   shape:RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(50),
                   ),
                   elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                   IconButton(
                     icon: new Icon(Icons.add),
                     iconSize: 45,
                     onPressed: adddata,
                   ),
                    Text('Add Details',
                    style: cardtextstyle,
                    ),
                 ],
                  ),
                 ),

                  Card(
                    color: Colors.lightBlueAccent,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(Icons.update),
                          iconSize: 25,
                          onPressed: updatedata,
                        ),
                        Text('Update Details',
                          style: cardtextstyle,
                        ),
                      ],
                    ),
                  ),

                  Card(
                    color: Colors.lightBlueAccent,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(Icons.delete),
                          iconSize: 25,
                          onPressed: deletedata,
                        ),
                        Text('Delete Details ',
                          style: cardtextstyle,
                        ),
                      ],
                    ),
                  ),

                  Card(
                    color: Colors.lightBlueAccent,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        IconButton(
                          icon: new Icon(Icons.map),
                          iconSize: 25,
                          onPressed: _launchURL,
                        ),
                        Text('View Map ',
                          style: cardtextstyle,
                        ),
                      ],
                    ),
                  ),



                  Card(
                    color: Colors.lightBlueAccent,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        IconButton(
                          icon: new Icon(Icons.remove_red_eye),
                          iconSize: 25,
                          onPressed:()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenUI()));
                          }
                        ),
                        Text('View Data',
                          style: cardtextstyle,
                        ),
                      ],
                    ),
                  ),





                ],
              ),
            ),
          ),
      );
    }
  }



