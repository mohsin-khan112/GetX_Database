import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_database/AddScreen.dart';
import 'package:getx_database/Model/User.dart';
import 'package:getx_database/UserController.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.to(AddScreen());
            },
            child: Text(" Next Screen"),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 100),
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
                  var id = userController.id;
                  if (id == null) {
                    userController.addUser();
                  } else {
                    userController.updateUser(id);
                  }
                  userController.id = null;
                });
              },
              child: Text("Add User"),
            ),
            Expanded(
              child: Obx(
                () => ReorderableListView.builder(
                  itemCount: userController.listUsers.length,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final element =
                          userController.listUsers.removeAt(oldIndex);
                      userController.listUsers.insert(newIndex, element);
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      key: ValueKey(index),
                      child: GestureDetector(
                        onTap: () {
                          userController.id =
                              userController.listUsers[index].id;
                          userController.contactControl.text =
                              userController.listUsers[index].contact!;
                          userController.nameControl.text =
                              userController.listUsers[index].name!;
                          userController.position = index;
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userController.listUsers[index].name ?? "",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${userController.listUsers[index].id ?? 2}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    userController.listUsers[index].contact ??
                                        "",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => userController.delete(
                                          userController.listUsers[index].id ??
                                              0)),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
