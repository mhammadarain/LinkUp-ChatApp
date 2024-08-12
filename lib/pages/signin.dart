import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Center(child: Text("SignIn", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)),
                  Center(child: Text("Login to your account", style: TextStyle(color: Color(0xffc5c4c4), fontSize: 20.0, fontWeight: FontWeight.w500),)),

                  Container(
                    margin: EdgeInsets.symmetric(vertical:20, horizontal: 20 ),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),

                      child: Container(
                        padding:EdgeInsets.symmetric(vertical:30,horizontal: 20 ) ,
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.circular(10) ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Email",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                         SizedBox(height: 10,),
                         Container(
                           padding: EdgeInsets.only(left: 10),
                           decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black38 )),
                           child: TextFormField(
                             decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.email_outlined,color: Color(0xff7f30fe),),
                           ),
                         ),
                         ),

                         SizedBox(height: 30,),

                         Text("Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                         SizedBox(height: 10,),
                         Container(
                           padding: EdgeInsets.only(left: 10),
                           decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black38 )),
                           child: TextFormField(
                             decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.password_outlined,color: Color(0xff7f30fe),),
                             ),
                             obscureText: true,
                           ),
                         ),

                         SizedBox(height: 10,),

                         Container(
                           alignment: Alignment.bottomRight,
                             child: Text("Forgot Password?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),)),

                         SizedBox(height: 10,),

                         Center(
                           child: Container(
                             width: 170,
                             child: Material(
                               elevation: 5,
                               child:  Container(
                                   padding: EdgeInsets.all(10),
                                   decoration: BoxDecoration(color: Color(0xff7f30fe), borderRadius: BorderRadius.circular(10) ),
                                   child: Center(child: Text("SignIn",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18 ),)),),
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
                      children: [
                        Text("Don't have an account! "),
                        Text(" SignUp",style: TextStyle(color:Color(0xff7f30fe), fontWeight: FontWeight.bold,fontSize: 16 ),),
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
