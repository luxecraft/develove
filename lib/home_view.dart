import 'package:develove/views/home_view/explore/new_explore_page.dart';
import 'package:flutter/material.dart';
import 'package:develove/views/home_view/guilds/guilds_list_page.dart';
import 'package:develove/views/home_view/posts/home_page.dart';
import 'package:develove/views/home_view/profile/profile_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _userId;
  late int _currentPage;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(
              userId: _userId,
            ),
            // ExplorePage(),
            NewExplorePage(),
            GuildListPage(),
            ProfilePage()
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentPage,
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index);
              _currentPage = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.explore),
              icon: Icon(
                Icons.explore_outlined,
              ),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.groups),
              icon: Icon(
                Icons.groups_outlined,
              ),
              label: "Guilds",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
