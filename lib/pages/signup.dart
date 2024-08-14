import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/signin.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {

  String email="", password="", name="", confirmPw="";

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController confirmPwcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (_formkey.currentState!.validate()) {
      if (password != confirmPw) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrange,
          content: Text("Passwords do not match", style: TextStyle(fontSize: 20.0),),
        ));
        return;
      }

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);

        String Id = randomAlphaNumeric(10);
        String user = emailcontroller.text.replaceAll("@gmail.com", "");
        String updatedusername = user.replaceFirst(user[0], user[0].toUpperCase());
        String firstletter = user.substring(0, 1).toUpperCase();

        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "E-mail": emailcontroller.text,
          "username": updatedusername,
          "Searchkey": firstletter,
          "Photo": "https://www.google.com/search?q=colorfull+contact+person+icon...",
          "Id": Id,
        };

        await DatabaseMethods().addUserDetails(userInfoMap, Id);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserDisplayName(namecontroller.text);
        await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);
        await SharedPreferenceHelper().saveUserPic("https://www.google.com/search?q=colorfull+contact+person+icon...");
        await SharedPreferenceHelper().saveUserName(emailcontroller.text.replaceAll("@gmail.com", ""));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrange,
          content: Text("Registered Successfully", style: TextStyle(fontSize: 20.0),),
        ));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Text("Password Provided is too weak", style: TextStyle(fontSize: 20.0),),
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Text("Account Already exists", style: TextStyle(fontSize: 20.0),),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3.0,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xff7f30fe), Color(0xff6380fb)], begin: Alignment.topLeft, end: Alignment.bottomRight ),
                  borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0))
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Center(child: Text("SignUp", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)),
                  Center(child: Text("Create your account", style: TextStyle(color: Color(0xffc5c4c4), fontSize: 20.0, fontWeight: FontWeight.w500),)),

                  Container(
                    margin: EdgeInsets.symmetric(vertical:20, horizontal: 20 ),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),

                      child: Container(
                        padding:EdgeInsets.symmetric(vertical:30,horizontal: 20 ) ,
                        height: MediaQuery.of(context).size.height/1.4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.circular(10) ),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black38 )),
                                child: TextFormField(
                                  controller: namecontroller,
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Please Enter Name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.person,color: Color(0xff7f30fe),),
                                  ),
                                ),
                              ),


                              SizedBox(height: 12,),

                              Text("Email",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black38 )),
                                child: TextFormField(
                                  controller: emailcontroller,
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Please Enter Email";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.email,color: Color(0xff7f30fe),),
                                  ),
                                ),
                              ),

                              SizedBox(height: 12,),

                              Text("Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black38 )),
                                child: TextFormField(
                                  controller: passwordcontroller,
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.password_outlined,color: Color(0xff7f30fe),),
                                  ),
                                  obscureText: true,
                                ),
                              ),

                              SizedBox(height: 12,),

                              Text("Confirm Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black38 )),
                                child: TextFormField(
                                  controller: confirmPwcontroller,
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Please Enter Confirm Password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.password_outlined,color: Color(0xff7f30fe),),
                                  ),
                                  obscureText: true,
                                ),
                              ),

                              SizedBox(height: 40,),


                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Material(
                                    elevation: 5,
                                    child:  GestureDetector(
                                      onTap: (){
                                        if(_formkey.currentState!.validate()){
                                          setState(() {
                                            email = emailcontroller.text;
                                            name = namecontroller.text;
                                            password = passwordcontroller.text;
                                            confirmPw = confirmPwcontroller.text;
                                          });
                                        }
                                        registration();
                                        },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Color(0xff7f30fe), borderRadius: BorderRadius.circular(10) ),
                                        child: Center(child: Text("SignUp",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18 ),)),),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account! "),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                          },
                            child: Text(" SignIn",style: TextStyle(color:Color(0xff7f30fe), fontWeight: FontWeight.bold,fontSize: 16 ),)),
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

