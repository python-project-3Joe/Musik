import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musik/Login/findMain.dart';
import 'package:musik/Login/findMain2.dart';
import 'package:musik/maintabpage.dart';
import 'package:musik/userMessage.dart';
import 'package:musik/view/diaryhome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController uId;
  late TextEditingController uPw;

  late List users;

  late String id; // JSON
  late String pw; // JSON

  @override
  void initState() {
    super.initState();
    users = [];
    uId = TextEditingController();
    uPw = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width, // 배경사진 화면 꽉 차게
            height: MediaQuery.of(context).size.height, // 배경사진 화면 꽉 차게
            // double.infinity는 SinglechildScrollView와 함꼐 쓸 쑤 없어서 쓰지 못함
            // 키보드가 올라가면 화면이 좁아지기 때문에 스크롤을 꼭 넣어 줘야 함
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/login.png'), fit: BoxFit.fill),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 400,
                  ),
                  SizedBox(
                    width: 300,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        controller: uId,
                        decoration:
                            const InputDecoration(labelText: "아이디를 입력하세요"),
                        keyboardType: TextInputType.text,
                        autocorrect: false, // 자동완성 해제
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        controller: uPw,
                        decoration:
                            const InputDecoration(labelText: "비밀번호를 입력하세요"),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autocorrect: false, // 자동완성 해제
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          // 아이디 비밀번호 찾기
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FindMain()));
                              },
                              child: const Text(
                                '아이디찾기     ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              '   |   ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FindMain2()));
                              },
                              child: const Text(
                                '    비밀번호찾기  ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(260, 50),
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              // 사용자 입력 값 JSON용 변수에 넣어줌
                              id = uId.text.trim();
                              pw = uPw.text.trim();

                              // 공백 있으면 에러스낵바 아니면 쿼리문 작동
                              if (uId.text.trim().isEmpty ||
                                  uPw.text.trim().isEmpty) {
                                errorSnackbar(context);
                              } else {
                                updateAction();
                              }
                            },
                            child: const Text(
                              '로   그   인',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/Sign_up');
                          },
                          // style: ElevatedButton.styleFrom(
                          //   fixedSize: const Size(300, 50),
                          //   primary: Colors.white,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          // ),
                          child: const Text(
                            '회 원 가 입',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//--- Function

// 공백 에러창
  errorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('아이디와 비밀번호를 입력해주세요.'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }

// 로그인 실패 에러창
  loginfailSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('아이디와 비밀번호가 일치하지 않습니다.'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.orange,
    ));
  }

  // 탈퇴 아이디로 로그인시 에러창
    leaveUserSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('탈퇴된 계정입니다.'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.orange,
    ));
  }

  // Login
  // 택스트필드에서 id,pw를 받아와서 로그인 버튼을 누르면 실행된다.
  // DB 다녀와서 계정이 없으면 알림창, 계정이 있으면 일기 리스트 화면으로 바로 넘어가기
  Future<bool> updateAction() async {
    users = []; // 초기화
    var url = Uri.parse(
        'http://localhost:8080/Flutter/musik/daily_login.jsp?uid=$id&upw=$pw'
        // get 방식으로 데이터 받아와서 넘기기
        );
    var response = await http.get(url);

    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];

    setState(() {
      if (result[0] == 'ERROR') {
        print(result); // 결과 확인용
        loginfailSnackbar(context); // 로그인 실패 알림창
      }else {
        users.addAll(result);
        // print(users); // 결과 확인용
        User.uId = id;
        User.uNickname = users[0]['u_nickname'];

        // 탈퇴된 계정 실패에러바
        if(users[0]['u_quit'] == '1'){
          leaveUserSnackbar(context);
        }else{
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainTabPage(
                  user: users[0],
                ); // Map으로 보내
              },
            ),
          ); 
        }
// 로그인 성공 리스트 화면으로 이동
      }
    });

    return true;
  } // Login

} //END
