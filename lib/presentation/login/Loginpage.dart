import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:silkspaceadmin/Buttons/buttons.dart';
import 'package:silkspaceadmin/presentation/home/Homepage.dart';
class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController forgotpassword = TextEditingController();

  bool isobsecure = true;

  Future signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.setBool('login', true);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homepage(),
          ));
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("ALERT !"),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("OK"))
          ],
        ),
      );
    }
  }

  Future forgot() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotpassword.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("ALERT !"),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("OK"))
          ],
        ),
      );
    }
  }

  // Future googlesignin() async {
  //   final google = GoogleSignIn();
  //   final user = await google.signIn().catchError((error) {});
  //   if (user == null) return;
  //   final auth = await user.authentication;
  //   final credential = await GoogleAuthProvider.credential(
  //       accessToken: auth.accessToken, idToken: auth.idToken);
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool('login', true);
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => btmnav(),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 110,
                    width: 100,
                    //color: Colors.blue,
                    child: Center(
                        child: Image(
                      image: AssetImage("lib/images/Designer.png"),
                      fit: BoxFit.fill,
                    ))),
                Container(
                  height: 80,
                  width: 300,
                  //color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back",
                          style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.w600,
                              fontSize: 35,
                              shadows: [
                                Shadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 2),
                                    blurRadius: 5)
                              ]),
                        ),
                        Text(
                          "Enter your credential to login",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: password,
                    obscureText: isobsecure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isobsecure = !isobsecure;
                            });
                          },
                          icon: Icon(isobsecure
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: 'Password',
                    ),
                  ),
                ),
                elvbtn(
                    txt: "Login",
                    ontap: () {
                      signin();
                    },
                    height: 50,
                    width: 220),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext) => AlertDialog(
                                title: Text('Forgot Password'),
                                content: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextField(
                                    controller: forgotpassword,
                                    decoration: InputDecoration(
                                        hintText: "Enter your email",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        forgot();
                                        Navigator.pop(context);
                                      },
                                      child: Text('verify')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('cancel'))
                                ],
                              ));
                    },
                    child: Text("Forgot password?")),
                // Text("OR"),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 60,
                //     ),
                //     Text("Do you want to"),
                //     TextButton(
                //         onPressed: () {
                //           googlesignin();
                //         },
                //         child: Text("Continue with google ?"))
                //   ],
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // Row(
                //   children: [
                //     SizedBox(width: 80),
                //     Text("Don't have an account?"),
                //     TextButton(
                //         onPressed: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => Signup(),
                //               ));
                //         },
                //         child: Text("Sign up"))
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
