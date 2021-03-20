import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/base.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}
// ignore: camel_case_types
class Userdetails
{
  Userdetails({this.n,this.age});
    String n;
    int age;
}

class _TableScreenState extends State<TableScreen> {
  final _formKey = GlobalKey<FormState>();
  Userdetails userdetails = new Userdetails();

  //for adding data
  adddata()
  async{

    TextEditingController _name = TextEditingController();
    showDialog(
        context: context,
        builder: (context)
    {
      return AlertDialog(
        title: Text('Add Data '),
        content: TextField(
          controller: _name,
          decoration: InputDecoration(
              hintText: "Enter User Name to Add details"),
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
                String docname=_name.text;
                String nm="";
                String ag="";
                TextEditingController name = TextEditingController();
                TextEditingController age = TextEditingController();
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
                            controller: name,
                            decoration: InputDecoration(labelText: 'Full Name'),
                          ),
                          TextFormField(
                            controller: age,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(labelText: 'Age'),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: TextButton(
                              onPressed: () {
                                nm=name.text;
                                ag=age.text;
                                  Map<String, dynamic> demodata = {"name": nm, "age": ag};
                                  DocumentReference documentReference = FirebaseFirestore
                                      .instance.collection('data').doc(docname);
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
              decoration: InputDecoration(hintText: "Enter User Name to delete details"),
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
                  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('data').doc(dc).get();
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
                    DocumentReference removedata = FirebaseFirestore.instance.collection('data').doc(dc);
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
      TextEditingController _name = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update'),
            content: TextField(
              controller: _name,
              decoration: InputDecoration(hintText: "Enter User Name to Update details"),
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
                  String nm="";
                  String ag="";
                  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('data').doc(dc).get();
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
                    DocumentReference updata = FirebaseFirestore.instance.collection('data').doc(dc);
                  TextEditingController name = TextEditingController();
                  TextEditingController age = TextEditingController();
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
                                  controller: name,
                                  decoration: InputDecoration(labelText: 'Full Name'),
                                ),
                                TextFormField(
                                  controller: age,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(labelText: 'Age'),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: TextButton(
                                    onPressed: () {

                                      nm=name.text;
                                      ag=age.text;
                                      Map<String, dynamic> demodata = {"name": nm, "age": ag};
                                      updata.update(demodata);
                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      Fluttertoast.showToast(
                                          msg: "User Updated Successfully",
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
      return BaseScreen(
        title: "Manage",
        body: Container(
          child:Padding(
            padding:EdgeInsets.all(10),
            child:Card(
              color: Colors.yellow,
              child: ListView(
                children: <Widget>[
                  Card(
                    color: Colors.blue,
                    child: ListTile(
                      leading: FlutterLogo(size: 50),
                      trailing: new Column(
                        children: <Widget>[
                          new Container(
                            child: new IconButton(
                              icon: new Icon(Icons.add),
                              onPressed: adddata,
                            ),
                            margin: EdgeInsets.only(top: 5.0),
                          )
                        ],
                      ),
                      title: Text('Add Details'),
                    ),
                  ),
                  Card(
                    color: Colors.amberAccent,
                    child: ListTile(
                      leading: FlutterLogo(size: 50),
                      title: Text('Update Details'),
                      trailing: new Column(
                        children: <Widget>[
                          new Container(
                            child: new IconButton(
                              icon: new Icon(Icons.update),
                              onPressed: updatedata,
                            ),
                            margin: EdgeInsets.only(top: 5.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.amber,
                    child: ListTile(
                      leading:FlutterLogo(size: 50),
                      title: Text('Delete Details'),
                      trailing: new Column(
                        children: <Widget>[
                          new Container(
                            child: new IconButton(
                              icon: new Icon(Icons.remove),
                              onPressed: deletedata,
                            ),
                            margin: EdgeInsets.only(top: 5.0),
                          )
                        ],
                      ),

                    ),
                  ),
                ],
              ),

            ),
          ),
        ),
      );
    }
  }



