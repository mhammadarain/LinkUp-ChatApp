import 'package:chat_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email has been sent!"),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "user-not-found") {
        message = "No user found for that email.";
      } else {
        message = "An error occurred. Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/4.0,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xff7f30fe), Color(0xff6380fb)], begin: Alignment.topLeft, end: Alignment.bottomRight ),
                  borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0))
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Center(child: Text("Forgot Password", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)),
                  Center(child: Text("Enter Email to Change New Password", style: TextStyle(color: Color(0xffc5c4c4), fontSize: 18.0, fontWeight: FontWeight.w500),)),

                  Container(
                    margin: EdgeInsets.symmetric(vertical:20, horizontal: 20 ),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),

                      child: Container(
                        padding:EdgeInsets.symmetric(vertical:90,horizontal: 20 ) ,
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.circular(10) ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10,),
                              Form(
                                key: _formKey,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black38 )),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your email";
                                      }
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                    decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.email_outlined,color: Color(0xff7f30fe),),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 30,),

                              Center(
                                child: SizedBox(
                                  width: 170,
                                  child: Material(
                                    elevation: 5,
                                    child:  GestureDetector(
                                      onTap: (){
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Color(0xff7f30fe), borderRadius: BorderRadius.circular(10) ),
                                        child: Center(child: Text("Send Email",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18 ),)),),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account! "),
                        GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            },
                            child: Text(" SignUp",style: TextStyle(color:Color(0xff7f30fe), fontWeight: FontWeight.bold,fontSize: 16 ),)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


