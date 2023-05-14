import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileshop_admin_portal/main_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = "";
  String adminPassword = "";
  allowAdminToLogin() async
  {
    SnackBar snackBar =const SnackBar(
      content: Text(
        "Checking Authentiation ,please wait",
        style: TextStyle(
            fontSize: 15,
            color: Colors.white
        ),
      ),
      backgroundColor: Colors.teal,
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: adminEmail, password: adminPassword,
    ).then((fAuth){
      //success
      currentAdmin= fAuth.user;
    }).catchError((onError){
      //incase of error
      //display error massage
      final snackBar = SnackBar(
          content: Text(
        "Error Occured:" + onError.toString(),
        style: TextStyle(
          fontSize: 15,
          color: Colors.white
        ),
      ),
        backgroundColor: Colors.teal,
        duration:const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    if(currentAdmin!=null){
      //check if the admin record also exists in the admin collection in firebase
      await FirebaseFirestore.instance.collection("admins").doc(currentAdmin!.uid).get().then((snap){
        if(snap.exists){
          Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
        }
        else{
          SnackBar snackBar= const SnackBar(content: Text(
            "no record fond you are not admin.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),

          ),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image
                      Image.asset(
                        "images/admin.png"
                      ),

                      //email text feild
                      TextField(
                        onChanged: (value)
                        {
                          adminEmail =value;

                        },
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                              width: 2
                            ),
                          ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2
                              ),
                            ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(
                            Icons.email,
                            color: Colors.teal,
                          )
                        ),

                      ),
                      SizedBox(height: 10,),
                      //password text feild
                      TextField(
                        onChanged: (value)
                        {
                          adminPassword =value;

                        },
                        obscureText: true,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal,
                                  width: 2
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2
                              ),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            icon: Icon(
                              Icons.admin_panel_settings,
                              color: Colors.teal,
                            )
                        ),

                      ),
                      SizedBox(height: 10,),
                      //button login
                      ElevatedButton(
                        onPressed: (){
                          allowAdminToLogin();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
