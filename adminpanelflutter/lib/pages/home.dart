
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/common/base.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map datadb;
 List doc;
 String r="",x="",y="";
 int no=0;
  @override
  Widget build(BuildContext context)
  {

    //for fetching data
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('data');
      collectionReference.snapshots().listen((snapshot) {
        doc = snapshot.docs;
        no=doc.length;
        int i = 0;
        while (true) {
          if (i >= no) {
            break;
          }
          datadb = snapshot.docs[i].data();
          x = datadb.toString();
          r = r + "[ $x ] \n ";
          i++;
        }
      });

    return BaseScreen(
      title: "Dashboard",
      body: Container(
        padding: EdgeInsets.all(10),
       child:  Card(
         color: Colors.cyanAccent,
        child: Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Row(
          children: [
            Icon(Icons.person,
              size: 50,
            ),
            SizedBox(
              height: 80,
              child: Card(
                color: Colors.teal,
                  child: Text(
                    'Active Users \n $no',
                    textAlign:TextAlign.center ,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  )
              ),
              ),
        ],
        ),
           Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.timer,
                      size: 50,
                    ),
                SizedBox(
                  height: 80,
                  child: Card(
                    color: Colors.yellow,
                  child: Text(
                    'Daily Time Usage \n 5hours',
                    textAlign:TextAlign.center ,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                ),
              ],
            ),
          Center(
            child: Container(
              height: 425,
              width: 1000,
              child: SingleChildScrollView(
              child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              margin: EdgeInsets.all(15),
             color: Colors.white,
              child: Text(
                r,
            textAlign:TextAlign.start ,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),

              ),

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