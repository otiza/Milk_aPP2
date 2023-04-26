import 'package:flutter/material.dart';

import 'package:milk_collection/components/custom_textfield.dart';
import 'package:milk_collection/components/custom_loginbutton.dart';
import 'package:milk_collection/pages/ErrorPage.dart';

import '../auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool wrongcred = false;
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  
  void signUserIn(BuildContext context) async {
    bool login =
        await authenticateUser(usernameController.text, passwordController.text)
            .catchError((error) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ErrorPage(error: error.message))
              );
              
            });
    if (login == false) {
      setState(() {
        wrongcred = true;
      });
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                //logo
                const SizedBox(height: 120),
                const Icon(Icons.lock, size: 120),
                const SizedBox(height: 10),
                const Text('here goes your logo and company name'),
                const SizedBox(height: 50),
                //username field
                wrongcred
                    ? const Text(
                        "Wrong credentials",
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text("enter your credentials"),
                const SizedBox(height: 15,),
                MyTextField(
                    controller: usernameController,
                    hintText: 'USERNAME',
                    obscureText: false,
                    onChange: (text) {
                      setState(() {
                        wrongcred = false;
                      });
                    },
                    color: wrongcred ? Colors.red: Colors.black),
                //password field
                const SizedBox(height: 10),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    onChange: (text){
                      setState(() {
                        wrongcred = false;
                      });
                    },
                    color: wrongcred ? Colors.red: Colors.black,
                    ),

                const SizedBox(height: 60),
                MyButton(
                  onTap: () {
                    signUserIn(context);
                  },
                  text: "Sign In",
                  color: Colors.black,
                )
                //Login Button

                // Forgot password
              ]),
            )),
          ),
        ));
  }
}
