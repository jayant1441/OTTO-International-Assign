import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:otto_international_assign/bookmark_page/presentation/bookmark_page_index.dart';
import 'package:otto_international_assign/home_page/presentation/home_page_index.dart';
import 'package:otto_international_assign/profile/presentation/profile_page_index.dart';
import 'package:otto_international_assign/utils/colors.dart';

class BottomNavigationMain extends StatefulWidget {
  const BottomNavigationMain({Key? key}) : super(key: key);


  @override
  State<BottomNavigationMain> createState() => _BottomNavigationMainState();
}

class _BottomNavigationMainState extends State<BottomNavigationMain> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyBookmarkPage(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80, // Set this height
        flexibleSpace: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top+12),
              Text('Hi, ${FirebaseAuth.instance.currentUser?.displayName}', style: const TextStyle( fontSize : 24, fontWeight: FontWeight.w600,color: AppColors.goldColor),),
              Text("Create your best gallery today.", style: TextStyle(color: Colors.grey),),
            ],
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: AppColors.goldColor,
              color: Colors.grey,
              tabBorderRadius: 8,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  textStyle: TextStyle(color:  Colors.white),
                  iconActiveColor: Colors.white,
                ),
                GButton(
                  icon: LineIcons.bookmark,
                  text: 'Bookmark',
                  textStyle: TextStyle(color:  Colors.white),
                  iconActiveColor: Colors.white,
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                  textStyle: TextStyle(color:  Colors.white),
                  iconActiveColor: Colors.white,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
