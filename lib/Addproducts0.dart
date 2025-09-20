import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silkspaceadmin/presentation/add/Addproducts.dart';
import 'package:silkspaceadmin/presentation/add/addsaree.dart';

class Addproducts0 extends StatefulWidget {
  const Addproducts0({super.key});
  @override
  State<Addproducts0> createState() => _Addproducts0State();
}

class _Addproducts0State extends State<Addproducts0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Center(
          child: Text(
            '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddSaree(),
                ));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 250,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: const DecorationImage(
                          image: AssetImage("lib/images/Villagecotton3.jpg"),
                          // alignment: Alignment.bottomCenter,
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black87.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2))
                      ]),
                  child: Center(
                    child: Text(
                      "SAREE",
                      style: GoogleFonts.sansita(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            const Shadow(
                                color: Colors.black54,
                                blurRadius: 10,
                                offset: Offset(0, 2))
                          ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Addproducts(),
                        ));
                  },
                  child: Container(
                    height: 250,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                            image: AssetImage("lib/images/crepe.jpg"),
                            // alignment: Alignment.bottomCenter,
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2))
                        ]),
                    child: Center(
                      child: Text(
                        "Other Products",
                        style: GoogleFonts.sansita(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              const Shadow(
                                  color: Colors.black54,
                                  blurRadius: 10,
                                  offset: Offset(0, 2))
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
