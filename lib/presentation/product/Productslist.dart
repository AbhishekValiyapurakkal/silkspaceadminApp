import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:silkspaceadmin/Addproducts0.dart';

class Productslist extends StatefulWidget {
  const Productslist({super.key});

  @override
  State<Productslist> createState() => _ProductslistState();
}

class _ProductslistState extends State<Productslist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[300],
            elevation: 10,
            shadowColor: Colors.black,
            title: const Center(
              child: Text(
                'Products List',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snap = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(snap['name']),
                      subtitle: Text(snap['price']),
                      trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(snap.id)
                                .delete();
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  },
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Addproducts0(),
                  ));
            },
            backgroundColor: Colors.green[300],
            child: const Icon(Icons.add),
          )),
    );
  }
}
