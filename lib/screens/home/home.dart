import 'package:brewcrew/screens/camera/camera.dart';
import 'package:brewcrew/screens/home/courses.dart';
import 'package:brewcrew/screens/home/dashboard.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:brewcrew/screens/home/trash_modal.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'package:camera/camera.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  List trashData;

  void updateTrashdata(List data) {
    setState(() {
      trashData = data;
    });
  }

  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  void changePage(int index) {
    setState(() {
      _currentPage = index;
      _controller.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: TrashModal(
                data: trashData,
              ),
            );
          });
    }

    final Future<List<CameraDescription>> cameras = availableCameras();

    return Scaffold(
      backgroundColor: themeGreen,
      appBar: AppBar(
        title: Icon(Icons.emoji_food_beverage),
        backgroundColor: themeDarkGreen,
        brightness: Brightness.dark,
        elevation: 8.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showSettingsPanel(),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              controller: _controller,
              children: <Widget>[
                Dashboard(changePage: changePage),
                FutureBuilder(
                  future: cameras,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TakePictureScreen(
                        changeData: updateTrashdata,
                        camera: snapshot.data.first,
                      );
                    } else {
                      return Loading();
                    }
                  },
                ),
                Courses(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.white),
              ),
              color: themeDarkGreen,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.white24,
              selectedIndex: _currentPage,
              tabBorderRadius: 50,
              gap: 4,
              duration: Duration(milliseconds: 500),
              color: Colors.white60,
              activeColor: Colors.white,
              iconSize: 24,
              tabBackgroundColor: Colors.white24,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              onTabChange: (tab) {
                setState(() {
                  _controller.animateToPage(
                    tab,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                });
              },
              tabs: [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.camera_alt_rounded,
                  text: 'Camera',
                ),
                GButton(
                  icon: Icons.school_rounded,
                  text: 'Learn',
                ),
                GButton(
                  icon: Icons.insights_rounded,
                  text: 'Stats',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
