import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import 'package:develove/services/auth_required.dart';

import 'package:develove/views/home_view/pages/explore/explore_page.dart';
import 'package:develove/views/home_view/pages/guilds/guilds_list_page.dart';
import 'package:develove/views/home_view/pages/home_page.dart';
import 'package:develove/views/home_view/pages/profile/profile_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends AuthRequiredState<HomeView> {
  String? _userId;
  late int _currentPage;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
  }

  @override
  void onAuthenticated(Session session) {
    final user = session.user;
    if (user != null) {
      _userId = user.email;
    }
  }

  @override
  void onUnauthenticated() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF313131), Color(0xFF282828)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            controller: _pageController,
            // physics: NeverScrollableScrollPhysics(),
            physics: BouncingScrollPhysics(),
            children: [
              HomePage(
                userId: _userId,
              ),
              ExplorePage(),
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
                icon: Icon(
                  Icons.account_circle_outlined,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
