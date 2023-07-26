import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:lumios/providers/ai_provider.dart';
import 'package:lumios/screens/chat_screen.dart';
import 'package:lumios/screens/profile_screen.dart';

import 'audio_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.ai});
  
  final Ai ai;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    
    //// Use normal tab controller
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _tabController!.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: ChatScreen(),
          ),
          Center(
            child: ProfileScreen(),
          ),
        ],
      ),
      floatingActionButton: _tabController!.index == 0 
        ? Padding(
            padding: const EdgeInsets.only(bottom:72.0),
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const AudioScreen();
                      },
                    ),
                  );
                },
                shape: const StadiumBorder(),
                backgroundColor: Theme.of(context).primaryColorDark,
                child: Icon(Icons.mic, color: Theme.of(context).primaryColorLight,),
              ),
          ) 
        : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: 'Chat', 
        labels: const ['Chat', 'Profile'],
        icons: const [Icons.message, Icons.account_box],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Theme.of(context).primaryColorDark,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Theme.of(context).primaryColorDark,
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
    );
  }
}
