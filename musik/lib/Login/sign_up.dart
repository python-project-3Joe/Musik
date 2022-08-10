import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musik/Login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Property
  late TextEditingController idController;
  late TextEditingController pwController;
  late TextEditingController nameController;
  late TextEditingController emailController;

  late String id;
  late String pw;
  late String name;
  late String email;
  late String result;
  late bool DuplicatedFinish;
  late List data;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    data = [];
    getJSONData();

    DuplicatedFinish = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.brown,
            title: const Text(
              "회원가입",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            toolbarHeight: 100,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          body: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Row(
                      children: [
                        const Text(
                          '아이디 : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 23,
                        ),
                        Flexible(
                          child: TextField(
                            controller: idController,
                            onChanged: (value) {
                              id = value;
                            },
                            decoration: const InputDecoration(
                              labelText: 'ID 를 입력하세요',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(149, 106, 106, 106),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.brown,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              id = idController.text;
                              bool isDuplicated = false;
                              bool isIdEmpty = false;
                              for (int i = 0; i < data.length; i++) {
                                if (data[i]['u_id'] == id) {
                                  errorSnackBar_id(context);
                                  isDuplicated = true;
                                  isIdEmpty = false;
                                  idController.text = '';
                                }
                              }
                              if (id.isEmpty) {
                                isDuplicated = true;
                                isIdEmpty = true;
                                errorSnackBar_idEmpty(context);
                              }

                              if ((id.length < 4 || id.length > 15) &&
                                  !isIdEmpty) {
                                errorSnackBar_idCheck(context);
                                isDuplicated = true;
                              }

                              if (!isDuplicated) {
                                allowSnackBar_id(context);
                                DuplicatedFinish = true;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber[500],
                              minimumSize: const Size(80, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('중복체크'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Row(
                      children: [
                        const Text(
                          '패스워드 : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: pwController,
                            onChanged: (value) {
                              pw = value;
                            },
                            decoration: const InputDecoration(
                              labelText: '특수,대소문자,숫자 포함 8~15자이내로 입력',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(149, 106, 106, 106),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Row(
                      children: [
                        const Text(
                          '패스워드 확인 : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: pwController,
                            onChanged: (value) {
                              pw = value;
                            },
                            decoration: const InputDecoration(
                              labelText: '특수,대소문자,숫자 포함 8~15자이내로 입력',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(149, 106, 106, 106),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Row(
                      children: [
                        const Text(
                          '이름 : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 34,
                        ),
                        Flexible(
                          child: TextField(
                            controller: nameController,
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: const InputDecoration(
                              labelText: '성함을 입력하세요',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(149, 106, 106, 106),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Row(
                      children: [
                        const Text(
                          'Email : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: emailController,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: const InputDecoration(
                              labelText: 'email 형식으로 입력하세요',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(149, 106, 106, 106),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        id = idController.text;
                        pw = pwController.text;
                        name = nameController.text;
                        email = emailController.text;
                        if (DuplicatedFinish == false) {
                          errorSnackBar_Duplicated(context);
                        } else {
                          _Validation();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber[500],
                        minimumSize: const Size(80, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('회원가입하기'))
                ],
              ),
            ),
          )),
    );
  }

  // --- Functions

  Future getJSONData() async {
    data.clear();
    var url = Uri.parse(
        "http://localhost:8080/Flutter/musik/id_Duplicate_Check.jsp?");
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      //키값
      List value = dataConvertedJSON['results'];
      //데이터에 넣기
      data.addAll(value);
    });
  }

  _Validation() {
    final id = idController.text;
    final pw = pwController.text;
    final name = nameController.text;
    final email = emailController.text;

    if (RegExp(r'^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$')
        .hasMatch(pw)) {
      if (name.length > 2 && name.length < 15) {
        if (RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email)) {
          _showDialog(context);
        } else {
          errorSnackBar_Email(context);
        }
      } else {
        errorSnackBar_name(context);
      }
    } else {
      errorSnackBar_pw(context);
    }
  }

  _showDialog(BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('SignUp'),
            content: const Text('회원가입 하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  signinAction();
                  _showFinishDialog(context);
                },
                child: const Text('예'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('아니오'),
              ),
            ],
          );
        });
  }

  _showFinishDialog(BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text('회원가입이 완료되었습니다!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.pushNamed(context, '/Log_in');
                },
                child: const Text('확인'),
              ),
            ],
          );
        });
  }

  signinAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/musik/user_insert.jsp?id=$id&pw=$pw&name=$name&email=$email');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

      if (result == 'OK') {
        //_showDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("사용자 정보 입력에 문제가 발생 하였습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  allowSnackBar_id(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t사용가능한 아이디입니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  errorSnackBar_Duplicated(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t아이디 중복체크를 해주세요!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_id(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t중복된 아이디입니다.\n\t\t\t다른 아이디를 사용해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_idCheck(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("아이디를 4자 이상 15자 이내로 입력해주세요!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_idEmpty(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("아이디를 입력해주세요!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_pw(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text("\t\t\t\t패스워드를 특수/대소문자/숫자 포함\n\t\t\t8자 ~ 15자 이내로 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_name(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t\t이름은 2자 ~ 15자 이내로 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar_Email(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("\t\t\t\t\t잘못된 이메일 형식입니다.\n\t\t\t올바른 형식으로 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
} //end
