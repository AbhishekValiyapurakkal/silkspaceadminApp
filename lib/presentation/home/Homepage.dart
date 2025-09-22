import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silkspaceadmin/presentation/orders/orderspage.dart';
import 'package:silkspaceadmin/presentation/product/Productslist.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          elevation: 6,
          shadowColor: Colors.black54,
          title: const Center(
            child: Text(
              'Silk Space Admin',
              style: TextStyle(
                  color: Color.fromARGB(255, 226, 229, 232),
                  fontSize: 29,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black12,
          elevation: 8,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.black54),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("lib/images/project2.jpg"),
                  backgroundColor: Colors.blueGrey,
                ),
                accountName: const Text(""),
                accountEmail: Text(
                  FirebaseAuth.instance.currentUser?.email ?? "",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              _drawerButton(
                label: "PRODUCTS",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Productslist(),
                    ),
                  );
                },
              ),
              _drawerButton(
                label: "ORDERS",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Orderspage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            RepaintBoundary(
              child: Image.asset(
                "lib/images/project3.jpg",
                fit: BoxFit.cover,
                cacheWidth: 1080,
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    "Grow with SilkSpace",
                    style: GoogleFonts.alegreya(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RepaintBoundary(
                    child: Image.asset(
                      "lib/images/grow.jpg",
                      fit: BoxFit.cover,
                      cacheWidth: 1080,
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

  Widget _drawerButton({required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: Colors.black38,
        child: TextButton(
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
