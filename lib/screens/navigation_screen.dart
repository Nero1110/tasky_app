import 'package:depi_flutter_3rd_task/screens/completed_tasks.dart';
import 'package:depi_flutter_3rd_task/screens/home_screen.dart';
import 'package:depi_flutter_3rd_task/screens/profile_screen.dart';
import 'package:depi_flutter_3rd_task/screens/to_do_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    ToDoScreen(),
    CompletedTasks(),
    ProfileScreen(),
  ];
int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
bottomNavigationBar: BottomNavigationBar(
  selectedItemColor:  Color(0xff15B86C),
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: onItemTapped,
              items: [
                BottomNavigationBarItem(
activeIcon:SvgPicture.asset("assets/home.svg",color: Color(0xff15B86C),) ,
                  icon: SvgPicture.asset("assets/home.svg",color: Color(0xffC6C6C6),),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  activeIcon:SvgPicture.asset("assets/taskdone.svg",color: Color(0xff15B86C),) 
                  ,icon: SvgPicture.asset("assets/taskdone.svg"),
                  label: "To Do",
                ),
                BottomNavigationBarItem(
                  activeIcon:SvgPicture.asset("assets/tasknotdone.svg",color: Color(0xff15B86C),) ,
                  icon: SvgPicture.asset("assets/tasknotdone.svg"),
                  label: "Completed",
                ),
                BottomNavigationBarItem(
                  
                  activeIcon:SvgPicture.asset("assets/profile.svg",color: Color(0xff15B86C),) ,
                  icon: SvgPicture.asset("assets/profile.svg"),
                  label: "Profile",
                ),
              ],
            ),
    );
  }
}
