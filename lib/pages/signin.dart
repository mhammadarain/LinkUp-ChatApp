import 'package:chat_app/pages/forgot_password.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email = "", password = "", name = "", pic = "", username = "", id = "";
  TextEditingController passwardcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> userlogin() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        email = emailcontroller.text;
        password = passwardcontroller.text;
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        QuerySnapshot querySnapshot = await DatabaseMethods().getUserbyemail(email);

        // Ensure that the user's data is properly fetched and saved in Shared Preferences
        if (querySnapshot.docs.isNotEmpty) {
          name = "${querySnapshot.docs[0]["Name"]}";
          username = "${querySnapshot.docs[0]["username"]}";
          pic = "${querySnapshot.docs[0]["Photo"]}";
          id = "${querySnapshot.docs[0]["Id"]}";

          await SharedPreferenceHelper().saveUserDisplayName(name);
          await SharedPreferenceHelper().saveUserName(username);
          await SharedPreferenceHelper().saveUserId(id);
          await SharedPreferenceHelper().saveUserPic(pic);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          // Handle case where user data is not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.deepOrange,
              content: Text(
                "User data not found",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }

      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == "user-not-found") {
          errorMessage = "No user found for that email.";
        } else if (e.code == "wrong-password") {
          errorMessage = "Wrong password provided.";
        } else {
          errorMessage = "Login failed: ${e.message}";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Text(
              errorMessage,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff7f30fe), Color(0xff6380fb)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Login to your account",
                        style: TextStyle(
                          color: Color(0xffc5c4c4),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.0, color: Colors.black38),
                                  ),
                                  child: TextFormField(
                                    controller: emailcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Email";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Color(0xff7f30fe),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.0, color: Colors.black38),
                                  ),
                                  child: TextFormField(
                                    controller: passwardcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Password";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                        color: Color(0xff7f30fe),
                                      ),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: SizedBox(
                                    width: 170,
                                    child: Material(
                                      elevation: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_formkey.currentState!.validate()) {
                                            setState(() {
                                              email = emailcontroller.text;
                                              password = passwardcontroller.text;
                                            });
                                          }
                                          userlogin();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color(0xff7f30fe),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "SignIn",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text("Don't have an account! "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp()),
                              );
                            },
                            child: Text(
                              " SignUp",
                              style: TextStyle(
                                color: Color(0xff7f30fe),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
