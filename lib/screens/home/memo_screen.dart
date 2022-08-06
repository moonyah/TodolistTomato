import 'package:flutter/material.dart';

class MyMemo extends StatefulWidget {
  const MyMemo({Key? key}) : super(key: key);

  @override
  State<MyMemo> createState() => _MyMemoState();
}

class _MyMemoState extends State<MyMemo> {
  @override
  Widget build(BuildContext context) {
    return
      const Center(
        child: Text("메모 기능은 준비 중입니다."),
      );
  }
}
