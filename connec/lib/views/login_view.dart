import 'package:flutter/material.dart';
class LoginPage  extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          centerTitle: true,
          title: const Text("로그인 또는 회원가입", style: TextStyle(color: Colors.black, )),

          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: <Widget>[
              id(),
              password(),
              // SizedBox(height: 50),
              login_button(),
              sign_up_button(),
            ],
          ),
        )
    );

  }

  @override
  void initState() {
    super.initState();

    idFocus.requestFocus();
  }


  Widget id() => Container(
    margin: EdgeInsets.only(top: 70),
    height: 53,
    child: TextField(
      controller: idTextController,
      onSubmitted: (_) {
        passwordFocus.requestFocus();
      },
      focusNode: idFocus,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: '아이디',
      ),
    ),
  );

  Widget password() => Container(
    margin: EdgeInsets.only(top: 15),
    height: 53,
    child: TextField(
      controller: passwordTextController,
      focusNode: passwordFocus,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: '비밀번호',
      ),
    ),
  );
  Widget login_button() => Container(
    margin: EdgeInsets.only(top: 75),
    height: 53,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF2C75F5),
        ),
      ),
      onPressed: onClick(),
      child: Text(
        "로그인",
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
  Widget sign_up_button() => Container(
    margin: EdgeInsets.only(top: 20),
    height: 53,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF2C75F5),
        ),
      ),
      onPressed: onClick(),
      child: Text(
        "회원가입",
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  @override
  void dispose() {
    idTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  onClick() {

  }

}