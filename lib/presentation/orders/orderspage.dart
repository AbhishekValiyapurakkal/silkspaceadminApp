import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orderspage extends StatefulWidget {
  const Orderspage({super.key});

  @override
  State<Orderspage> createState() => _UserspageState();
}

class _UserspageState extends State<Orderspage> {
  update(track) async {
    final data = {'track': "Confirmed"};
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(track)
        .update(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.black,
          backgroundColor: Colors.blue[300],
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              "Orders",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snap = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: Image(
                            image: NetworkImage(snap['image']),
                            fit: BoxFit.fill,
                          ),
                          title: Text(snap['name']),
                          subtitle: Text(snap['address'].split("+").join("\n")),
                          trailing: Card(
                            child: IconButton(
                                onPressed: () {
                                  update(snap.id);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Order Approved"),
                                    duration: Duration(seconds: 2),
                                  ));
                                },
                                icon: Icon(Icons.done)),
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
