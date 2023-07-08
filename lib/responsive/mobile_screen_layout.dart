import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: NeverScrollableScrollPhysics(), //scroll krne pr navigation nhi hoga
        controller: pageController,
        onPageChanged: onPageChanged,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mobileBackgroundColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
              color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: "",
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
