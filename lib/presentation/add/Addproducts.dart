import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silkspaceadmin/Buttons/buttons.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({super.key});

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  String? image;
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

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController main = TextEditingController();

  List categorylist = [
    "under skirt",
    "lining",
    "crepe",
    "shape wear",
    "satin",
    "leggings",
    "shawl",
    "running",
  ];

  String? categoryvalue;
  create() async {
    await FirebaseFirestore.instance.collection('products').add({
      'name': name.text,
      'price': price.text,
      'description': description.text,
      'stock': int.tryParse(stock.text) ?? 0,
      'image': image,
      'category': categoryvalue,
      'maincategory': main.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 40,
          shadowColor: Colors.black38,
          title: const Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Add New Products',
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
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: const Column(
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
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: main,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Main category',
                    hintText: 'Enter main category',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Card(
                  child: DropdownButtonFormField(
                hint: const Text("Category"),
                value: categoryvalue,
                items: categorylist.map(
                  (item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    categoryvalue = value.toString();
                  });
                },
              )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: elvbtn(
                    ontap: () {
                      create();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
