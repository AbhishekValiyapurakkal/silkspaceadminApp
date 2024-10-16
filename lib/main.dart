import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silkspaceadmin/domain/firebase_options.dart';
import 'package:silkspaceadmin/global_variables.dart';
import 'package:silkspaceadmin/presentation/home/Homepage.dart';
import 'package:silkspaceadmin/presentation/login/Loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => GlobalVariables(),
      )
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: First(),
    ),
  ));
}

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  bool finalstate = false;
  Future getloginstate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? state = preferences.getBool('login');
    setState(() {
      finalstate = state!;
    });
  }

  @override
  void initState() {
    getloginstate().whenComplete(
      () {
        if (finalstate == false) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Loginpage(),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const homepage(),
              ));
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
