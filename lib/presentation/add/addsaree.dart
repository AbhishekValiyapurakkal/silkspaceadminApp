import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silkspaceadmin/Buttons/buttons.dart';

class AddSaree extends StatefulWidget {
  const AddSaree({super.key});

  @override
  State<AddSaree> createState() => _AddSareeState();
}

class _AddSareeState extends State<AddSaree> {
  String? image;
  String? coverimage;

  Future<String?> uploadimage(File path) async {
    firebase_storage.FirebaseStorage storage =
        await firebase_storage.FirebaseStorage.instance;
    DateTime current_time = DateTime.now();
    String timestamp = current_time.millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child('images/$timestamp');
    firebase_storage.UploadTask task = ref.putFile(path);
    await task;
    String url = await ref.getDownloadURL();
    setState(() {
      image = url;
    });
    return image;
  }

  Future<String?> uploadcoverimage(File path) async {
    firebase_storage.FirebaseStorage storage =
        await firebase_storage.FirebaseStorage.instance;
    DateTime current_time = DateTime.now();
    String timestamp = current_time.millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child('images/$timestamp');
    firebase_storage.UploadTask task = ref.putFile(path);
    await task;
    String url = await ref.getDownloadURL();
    setState(() {
      coverimage = url;
    });
    return coverimage;
  }

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController main = TextEditingController();
  TextEditingController newcategory = TextEditingController();

  List sareelist = [];

  Future fetchsareecategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('sareecategories').get();
      List sarees = querySnapshot.docs.map((doc) => doc['category']).toList();
      setState(() {
        sareelist = sarees;
      });
    } catch (e) {
      print(e);
    }
  }

  String? sareevalue;

  create() async {
    await FirebaseFirestore.instance.collection('products').add({
      'name': name.text,
      'price': price.text,
      'description': description.text,
      'stock': stock.text,
      'image': image,
      'category': sareevalue,
      'maincategory': "saree",
    });
  }

  @override
  void initState() {
    fetchsareecategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    main.text = "saree";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Add New Saree',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    final PickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (PickedFile == null) {
                      return;
                    } else {
                      File path = await File(PickedFile.path);
                      image = await uploadimage(path);
                      setState(() {});
                    }
                  },
                  child: image == null
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(
                                Icons.add_a_photo,
                                size: 40,
                              ),
                              Text("Add Image")
                            ],
                          ),
                        )
                      : Image.network(image!)),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Products Name',
                    hintText: 'Enter Your Products Name',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Products Description',
                    hintText: 'Enter Your Products Description',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: price,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Products price',
                    hintText: 'Enter Your Products Price',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: main,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Main Category',
                    hintText: 'Enter  Main category',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: stock,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Stocks Left',
                    hintText: 'Enter The stocks left',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Card(
                  child: DropdownButtonFormField(
                hint: Text("Category"),
                value: sareevalue,
                items: sareelist.map(
                  (item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    sareevalue = value.toString();
                  });
                },
              )),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  final PickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (PickedFile == null) {
                                    return;
                                  } else {
                                    File path = await File(PickedFile.path);
                                    coverimage = await uploadcoverimage(path);
                                    setState(() {});
                                  }
                                },
                                child: coverimage == null
                                    ? CircleAvatar(
                                        radius: 50,
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            NetworkImage(coverimage!),
                                      )),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                controller: newcategory,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Enter new category',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("cancel")),
                          TextButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("sareecategories")
                                    .add({
                                  'category': newcategory.text,
                                  'cover': coverimage,
                                });
                                setState(() {
                                  fetchsareecategories();
                                });
                                newcategory.clear();
                                coverimage == null;
                                Navigator.pop(context);
                              },
                              child: Text("Add")),
                        ],
                      ),
                    );
                  },
                  child: Text("Add new category")),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Elvbtn(
                    ontap: () {
                      create();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("New product added successfully"),
                      ));
                    },
                    txt: "Add Product",
                    height: 50,
                    width: 220,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
