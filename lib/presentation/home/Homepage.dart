import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silkspaceadmin/presentation/product/Productslist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silkspaceadmin/presentation/login/Userspage.dart';
import 'package:silkspaceadmin/global_variables.dart';
import 'package:silkspaceadmin/presentation/orders/orderspage.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          elevation: 10,
          shadowColor: Colors.black,
          title: Center(
            child: Text(
              'Silk Space Admin',
              style: TextStyle(
                  color: const Color.fromARGB(255, 226, 229, 232),
                  fontSize: 29,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black12,
          elevation: 100,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black54),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("lib/images/project2.jpg"),
                    foregroundImage: AssetImage("lib/images/project2.jpg"),
                    backgroundColor: Colors.blueGrey,
                    radius: 10,
                  ),
                  accountName: Text(context
                      .watch<GlobalVariables>()
                      .allUsers[context.watch<GlobalVariables>().userind]
                      .name),
                  accountEmail: Text(context
                      .watch<GlobalVariables>()
                      .allUsers[context.watch<GlobalVariables>().userind]
                      .email)),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  color: Colors.black38,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Userspage(),
                            ));
                      },
                      child: Text(
                        'USERS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  color: Colors.black38,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productslist(),
                            ));
                      },
                      child: Text(
                        'PRODUCTS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  color: Colors.black38,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Orderspage(),
                            ));
                      },
                      child: Text(
                        'ORDERS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 610,
              width: double.infinity,
              //color: Colors.blue,
              child: Image(
                image: AssetImage("lib/images/project3.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              color: Colors.white,
              height: 800,
              width: 700,
              child: Column(
                children: [
                  Text("Grow with SilkSpace",
                      style: GoogleFonts.alegreya(
                          fontSize: 25, fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage("lib/images/grow.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
