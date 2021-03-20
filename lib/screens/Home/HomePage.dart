import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trinetra/helper/localAuth_helper.dart';
import 'package:trinetra/widgets/BubbleBottomBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isAuthenticated = await LocalAuthHelper.authenticate();

          if (isAuthenticated) {
            Fluttertoast.showToast(
                msg: 'Authentication Sucessful!',
                backgroundColor: Colors.greenAccent);
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) => HomePage()),
            // );
          } else {
            Fluttertoast.showToast(
                msg: 'Error Authenticating!', backgroundColor: Colors.red);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        backgroundColor: Colors.indigo,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: currentIndex, tilesPadding: EdgeInsets.all(5),
        onTap: changePage,
        // borderRadius:
        // BorderRadius.vertical(
        //   top: Radius.circular(5),
        // ), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              title: Text("Dashboard")),
          BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.history_toggle_off_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: Colors.white,
              ),
              title: Text("History")),
        ],
      ),
    );
  }
}
