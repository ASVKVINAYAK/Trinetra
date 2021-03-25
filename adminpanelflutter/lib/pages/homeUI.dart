import 'dart:math';

import 'package:adminpanelflutter/common/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreenUI extends StatefulWidget {
  @override
  _HomeUI createState() => _HomeUI();
}

// ignore: non_constant_identifier_names
var COLORS = [
  Color(0xFFEF7A85),
  Color(0xFFFF90B3),
  Color(0xFFFFC2E2),
  Color(0xFFB892FF),
  Color(0xFFB892FF)
];
class _HomeUI extends State<HomeScreenUI> {


  var data = [
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/200?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/100?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/150?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/125?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/175?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/225?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/250?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/350?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/275?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/300?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/325?random"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Dashboard",
      body: Container(
        child: new Stack(
          children: <Widget>[
            new Transform.translate(
              offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('data').snapshots(),
                builder: (context, snapshot) {
                  return new ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0.0),
                    scrollDirection: Axis.vertical,
                    primary: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index) {
                      DocumentSnapshot fdata=snapshot.data.docs[index];
                      String d="";
                      d="Name: "+fdata['name']+"\nAge: "+fdata['age']+"\n";
                      return AwesomeListItem(
                          title: fdata.id,
                          content: d,
                          color: data[index]["color"],
                          image: data[index]["image"]);
                    },
                  );
                }
              ),
            ),

            new Transform.translate(
              offset: Offset(0.0, -56.0),
              child: new Container(
                child: new ClipPath(
                  clipper: new MyClipper(),
                  child: new Stack(
                    children: [
                      Image.network(
                        "https://raw.githubusercontent.com/ASVKVINAYAK/HC-QS/main/WhatsApp%20Image%202021-03-21%20at%207.19.14%20PM.jpeg",
                        fit: BoxFit.fill,
                      ),
                      new Opacity(
                        opacity: 0.2,
                        child: new Container(color: COLORS[0]),
                      ),
                      // new Transform.translate(
                      //   offset: Offset(0.0, 50.0),
                      //   child: new ListTile(
                      //     leading: new CircleAvatar(
                      //       child: new Container(
                      //         decoration: new BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: Colors.transparent,
                      //           image: new DecorationImage(
                      //             fit: BoxFit.fill,
                      //             image: NetworkImage(
                      //                 "https://avatars2.githubusercontent.com/u/3234592?s=460&v=4"),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     title: new Text(
                      //       "TRINETRA",
                      //       style: new TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 24.0,
                      //           letterSpacing: 2.0),
                      //     ),
                      //     subtitle: new Text(
                      //       "Admin Panel",
                      //       style: new TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 12.0,
                      //           letterSpacing: 2.0),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

// ignore: must_be_immutable
class AwesomeListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  AwesomeListItem({this.title, this.content, this.color, this.image});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(width: 10.0, height: 280.0, color: widget.color),
        new Expanded(
          child: new Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: new Text(
                    widget.content,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        new Container(
          height: 150.0,
          width: 150.0,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              new Transform.translate(
                offset: new Offset(50.0, 0.0),
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  color: widget.color,
                ),
              ),
              new Transform.translate(
                offset: Offset(10.0, 20.0),
                child: new Card(
                  elevation: 20.0,
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
