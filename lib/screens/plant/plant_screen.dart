import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_tomato/config/palette.dart';
import 'package:todolist_tomato/screens/plant/month_plant_screen.dart';
import 'package:todolist_tomato/screens/plant/this_month_plant_screen.dart';

class MyPlant extends StatefulWidget {
  const MyPlant({Key? key}) : super(key: key);

  @override
  State<MyPlant> createState() => _MyPlantState();
}

class _MyPlantState extends State<MyPlant> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("MyTodos")
                      .where("completed", isEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      final docs = snapshot.data!.docs;
                      return AppBar(
                        flexibleSpace: Stack(children: [
                          Positioned(
                            top: 0,
                            right: 39,
                            left: 0,
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/tomato.png'),
                                      scale: 1.3)),
                            ),
                          ),
                          Positioned(
                              top: 32,
                              left: 200,
                              child: Text(
                                "x  " + docs.length.toString(),
                                style: const TextStyle(fontSize: 18),
                              ))
                        ]),
                        backgroundColor: Colors.white,
                        bottom: const TabBar(
                          indicatorColor: Palette.mainColor,
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: '5월 식물',
                            ),
                            Tab(
                              text: '월별 식물',
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red)));
                  })),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [ThisMonthPlant(), MonthPlant()],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
