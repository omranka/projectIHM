import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/ui/addnews/addnews.dart';
import 'package:project/ui/home/homePage.dart';
import 'package:project/ui/login/signup.dart';

import '../../utils/colors.dart';
import '../../utils/fire_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = false;

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                ),
                  Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Login to your account",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: primary,
                        ),
                      )
                  ),
                ),
                Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Email",
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: grey,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "email must not be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    )),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              cursorColor: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Password",
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: grey,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "password must not be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    )),
                                filled: true,
                                fillColor: Colors.white,
                                suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: obscureText
                                        ? Icon(Icons.visibility_off,
                                            color: Color(0XFF2f5792))
                                        : Icon(Icons.visibility,
                                            color: Color(0XFF2f5792))),
                              ),
                              cursorColor: Theme.of(context).primaryColor,
                              obscureText: obscureText,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child:  ElevatedButton(
                          child:isLoading
                      ?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text("Loading ... ",style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: white,
                            ),
                          )),
                          CircularProgressIndicator(color: white,),
                        ],
                      )


                          :Text("Login",style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: white,
                            ),
                          )),
                          onPressed: () async{
                            if(loginFormKey.currentState!.validate()){

                              setState(() {
                                isLoading=true;
                              });
                              User? user = await FireAuth
                                  .signInUsingEmailPassword(
                                email: emailController.text,
                                password:
                                passwordController.text,
                                context:context
                              );
                            print("********************");
                            print(user);
                              setState(() {
                                isLoading=false;
                              });

                              if(user!=null){
                              /*  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(email:user.email!),
                                    ));*/


                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddNews(),
                                    ));
                              }


                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                                    child: const Divider(
                                      color: Color(0xFFB4B4B4),
                                      height: 50,
                                    )),
                              ),
                              Text(
                                "Or",
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFB4B4B4),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                                    child: const Divider(
                                      color: Color(0xFFB4B4B4),
                                      height: 50,
                                    )),
                              ),
                            ]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Login with Google",style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: grey,
                          ),
                        ),),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              "Don't have account? ",
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => SignUp(),));
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color:primary,
                                  ),
                                ),
                              ),
                            )
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
      ),
    );
  }

 }
