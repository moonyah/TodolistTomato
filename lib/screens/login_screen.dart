import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist_tomato/screens/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;
  bool isSignupScreen = true;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 450,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/tomato.png'),
                    )
                  ),
                ),
              ),
              // 로고
              Positioned(
                top: 270,
                  child: Container(
                    padding: const EdgeInsets.all(40.0),
                height: isSignupScreen ? 400.0 : 350.0,
                width: MediaQuery.of(context).size.width-40,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSignupScreen = false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text('로그인',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen ? Colors.black54 : Colors.black26
                                    ),),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSignupScreen = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text('회원가입',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isSignupScreen ? Colors.black54 : Colors.black26
                                      ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                          if(isSignupScreen)
                          Container(
                              margin: const EdgeInsets.only(top:20),
                              child: Form(
                                key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const ValueKey(1),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 4){
                                        return '4자 이상 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userName = value!;
                                    },
                                    onChanged: (value){
                                      userName = value;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '이름',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: const ValueKey(2),
                                    validator: (value){
                                      if(value!.isEmpty || !value.contains('@')){
                                        return '유효한 이메일 주소를 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userEmail = value!;
                                    },
                                    onChanged: (value){
                                      userEmail = value;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black26
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: const ValueKey(3),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 6){
                                        return '최소 6자 이상 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userPassword = value!;
                                    },
                                    onChanged: (value){
                                      userPassword = value;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black26
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ),
                          if(!isSignupScreen)
                          Container(
                            margin: const EdgeInsets.only(top:20),
                            child: Form(
                                key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: const ValueKey(4),
                                    validator: (value){
                                      if(value!.isEmpty || !value.contains('@')){
                                        return '유효한 이메일 주소를 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userEmail = value!;
                                    },
                                    onChanged: (value){
                                      userEmail = value;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black26
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: const ValueKey(5),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 6){
                                        return '최소 6자 이상 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userPassword = value!;
                                    },
                                    onChanged: (value){
                                      userEmail = value;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black26
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          )
                        ],
                      ),
                    ),
              )),
              // 텍스트 폼 필드
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                top: isSignupScreen ? 560 : 490,
                  right: 0,
                  left: 240,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      width: 50,
                      child: GestureDetector(
                        onTap: ()async{
                          setState(() {
                            showSpinner = true;
                          });
                          if(isSignupScreen)
                            {
                              _tryValidation();
                              try {
                                final newUser = await _authentication
                                    .createUserWithEmailAndPassword(
                                    email: userEmail, password: userPassword);

                                await FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid)
                                .set({
                                  'userName' : userName,
                                  'email' : userEmail
                                });

                                if(newUser.user != null){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context){
                                          return const HomeScreen();
                                      }
                                      )
                                  );
                                }
                              }catch(e){
                                  print(e);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
                                Text('이메일과 비밀번호를 확인해주세요'),
                                backgroundColor: Colors.red,));
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          if(!isSignupScreen) {
                            _tryValidation();
                            try {
                              final newUser = await _authentication
                                  .signInWithEmailAndPassword(
                                  email: userEmail, password: userPassword);
                              if (newUser.user != null) {
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //       return const HomeScreen();
                                //     }
                                //     )
                                // );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: const Icon(
                              Icons.double_arrow_rounded,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  )),
              // 전송버튼
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
                top: isSignupScreen ? MediaQuery.of(context).size.height-140 : MediaQuery.of(context).size.height-180,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Text(isSignupScreen ? 'or Signup with': 'or Signin with',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                        )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton.icon(onPressed: (){},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size(130, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        backgroundColor: Colors.black38
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Google'),
                      )
                    ],
              ))
              // 구글 로그인 버튼
           ],
          ),
        ),
      ),
    );
  }
}
