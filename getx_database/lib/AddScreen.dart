import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UserController.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: userController.nameControl,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  hintText: "Enter  your  Name ",
                  hintStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  userController.name = value;
                },
                onSaved: (value) {
                  userController.name = value!;
                },
                cursorColor: Colors.white,
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: userController.contactControl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  hintText: "Enter  your  Contact ",
                  hintStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  userController.contact = value;
                },
                onSaved: (value) {
                  userController.contact = value!;
                },
                cursorColor: Colors.white,
              ),
              SizedBox(
                height: 14,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userController.addUser();
                      Get.back();
                    });
                  },
                  child: Text("Add User")),
            ],
          ),
        ),
      ),
    );
  }
}
