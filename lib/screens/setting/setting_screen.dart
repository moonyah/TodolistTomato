import 'package:flutter/material.dart';

class MySettings extends StatelessWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/tomato.png'),
                          scale: 0.9
                      )
                  ),
                ),
              ),
              Positioned(
                  top: 165,
                  child: Container(
                      padding: const EdgeInsets.all(40.0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: const [
                              Text('다크 모드',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54
                                ),),
                              SizedBox(height: 50,),
                              Text('공지 사항',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54
                                ),),
                              SizedBox(height: 50,),
                              Text('건의 사항',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54
                                ),),
                              SizedBox(height: 50,),
                              Text('앱 버전',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54
                                ),),
                              SizedBox(height: 50,),
                              Text('로그 아웃',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54
                                ),),
                            ],
                          )
                      )
                  )
              )
  ])
    );
  }
}


