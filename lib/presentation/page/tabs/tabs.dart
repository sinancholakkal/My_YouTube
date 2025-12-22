import 'package:flutter/material.dart';
import 'package:my_youtube/presentation/page/home_screen/home_screen.dart';

class Tabs extends StatefulWidget {
  Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          tabController.animateTo(value);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.slow_motion_video_rounded),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
        ],
      ),

      body: TabBarView(
        controller: tabController,
        children: [
          HomeScreen(),
          Center(child: Text("Shorts")),
          Center(child: Text("Subscriptions")),
        ],
      ),
    );
  }
}
