import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist_tomato/screens/calendar/calendar_screen.dart';
import 'package:todolist_tomato/screens/plant/plant_screen.dart';
import 'package:todolist_tomato/screens/setting/setting_screen.dart';

import '../config/palette.dart';
import 'home/checklist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try{
    final user = _authentication.currentUser;
    if(user != null) {
      loggedUser = user;
      debugPrint(loggedUser!.email);
    }
    }catch(e){
      print(e);
  }
  }
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyChecklist(),
    MyPlant(),
    MyCalendar(),
    MySettings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('6월 14일 (화)', style: TextStyle(fontSize: 17, color: Colors.black87)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.assistant_photo, color: Palette.mainColor,),
          onPressed: () {
            showDialog(context: context,
                barrierDismissible: true,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text("D-DAY",textAlign: TextAlign.center,style: TextStyle(color: Palette.mainColor),),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const [
                          Text("• 디데이 기능은 준비 중입니다."),
                          //Text("• 1회 이상 반복되는 체크리스트는 빨간색으로 표시됩니다")
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.assignment,
              color: Colors.black54,
            ), onPressed: () {
              showDialog(context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("Todolist Tomato",textAlign: TextAlign.center,style: TextStyle(color: Palette.mainColor),),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const [
                          Text("• 체크 리스트 하나 = 토마토 1개"),
                          Text("• 토마토는 최대 10개까지 열립니다!"),
                          //Text("• 1회 이상 반복되는 체크리스트는 빨간색으로 표시됩니다")
                        ],
                      ),
                    ),
                );
                  });
          },
          ),
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.black54,
            ), onPressed: () {
            _authentication.signOut();
          },
          )
        ],
      ),
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: '식물',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.mainColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),

    );
  }

}
