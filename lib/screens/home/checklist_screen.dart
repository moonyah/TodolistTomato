import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_tomato/config/palette.dart';
import 'package:todolist_tomato/screens/home/do_screen.dart';
import 'package:todolist_tomato/screens/home/done_screen.dart';
import 'package:todolist_tomato/screens/home/memo_screen.dart';

class MyChecklist extends StatefulWidget {
  const MyChecklist({Key? key}) : super(key: key);

  @override
  State<MyChecklist> createState() => _MyChecklistState();
}

class _MyChecklistState extends State<MyChecklist>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("MyTodos")
                    .where("completed", isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                        Positioned(top: 32, left: 200, child: Text(
                            "x  "+docs.length.toString(), style: const TextStyle(fontSize: 18),))
                      ]),
                      backgroundColor: Colors.white,
                      bottom: const TabBar(
                        indicatorColor: Palette.mainColor,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: '할 일',
                          ),
                          Tab(
                            text: '완료된 일',
                          ),
                          Tab(text: '메모장'),
                        ],
                      ),
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red)));
                })
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [MyDo(), MyDone(), MyMemo()],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

//return MaterialApp(
//   home: DefaultTabController(
//     length: 3,
//     child: Scaffold(
//       appBar: AppBar(
//         bottom: const TabBar(
//           tabs: [
//             Tab(text: '할 일'),
//             Tab(
//               text: '완료된 일',
//             ),
//             Tab(text: '메모장'),
//           ],
//         ),
//         title: const Text('todolist_tomato'),
//       ),
//       body: const TabBarView(
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//           MyPlant(),
//           MyCalendar(),
//           MySettings()
//         ],
//       ),
//     ),
//   ),
// );

// body:Stack(
//   children: [
//     Positioned(
//       top: 0,
//       right: 0,
//       left: 0,
//       child: Container(
//         height: 100,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/tomato.png'),
//               scale: 1.3
//             )
//         ),
//       ),
//     ),
//     // 토마토 개수
//     Positioned(
//       top: 100,
//       child: Container(
//         width: MediaQuery.of(context).size.width-40,
//         margin: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         children: const [
//                           Text('할 일',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54
//                             ),),
//                         ],
//                       ),
//                       // 할 일
//                       Column(
//                         children: const [
//                           Text('완료된 일',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54
//                             ),),
//                         ],
//                       ),
//                       // 완료된 일
//                       Column(
//                         children: const [
//                           Text('메모장',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54
//                             ),),
//                         ],
//                       )
//                       // 메모장
//                     ],
//                 )
//               ],
//             ),
//           ),
//       ),
//     )
//   ],
// )
//}
