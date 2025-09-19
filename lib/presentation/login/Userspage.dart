import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silkspaceadmin/global_variables.dart';
import 'package:silkspaceadmin/Models/user_model.dart';

class Userspage extends StatefulWidget {
  const Userspage({super.key});

  @override
  State<Userspage> createState() => _UserspageState();
}

class _UserspageState extends State<Userspage> {
  TextEditingController user = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final users = context.watch<GlobalVariables>().allUsers;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.black,
          backgroundColor: Colors.blue[300],
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              "USERS",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index].name),
              subtitle: Text(users[index].email),
              leading: IconButton(
                  onPressed: () {
                    context.read<GlobalVariables>().changeInt(index);
                  },
                  icon: const Icon(Icons.check)),
              trailing: IconButton(
                  onPressed: () {
                    context.read<GlobalVariables>().delet(index);
                  },
                  icon: const Icon(Icons.delete)),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: TextField(
                          controller: user,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context
                                    .read<GlobalVariables>()
                                    .changeName(user.text.trim(), index);
                                user.clear();
                              },
                              child: const Text("submit"))
                        ],
                      );
                    });
              },
            );
          },
          itemCount: users.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add USer"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: name,
                        decoration: const InputDecoration(hintText: 'Name'),
                      ),
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.read<GlobalVariables>().addUser(UserModel(
                              name: name.text.trim(),
                              email: email.text.trim(),
                              password: 'password',
                              image: 'image'));
                          Navigator.pop(context);
                        },
                        child: const Text("OK")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"))
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
