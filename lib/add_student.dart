import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_information/Database/db_helper.dart';
import 'package:student_information/homepage.dart';

import 'Model/info.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  late DatabaseHelper dbHelper;

  var nameeditingcontroller = TextEditingController();
  var ideditingcontroller = TextEditingController();
  var phoneeditingcontroller = TextEditingController();
  var emaileditingcontroller = TextEditingController();
  var loactioneditingcontroller = TextEditingController();

  final GlobalKey<FormState> infoFormKey = GlobalKey();

  //adding information to database
  Future AddStudents() async {
    final newinfo = Info(
      id: int.parse(ideditingcontroller.text),
      name: nameeditingcontroller.text,
      phone: int.parse(phoneeditingcontroller.text),
      email: emaileditingcontroller.text,
      location: loactioneditingcontroller.text,
    );
    int check = await dbHelper.insertData(newinfo.toMap());
    print("Check=$check");
    if (check > 0) {
      Get.snackbar("success", "Student Info Added",
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(Homepage());
    } else {
      Get.snackbar("Error", "failed in Student adding",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New student",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: infoFormKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: nameeditingcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Enter Your Name",
                      hintText: "Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Your name";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: ideditingcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter Your Student ID",
                      hintText: "ID",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your id";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: phoneeditingcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter Your Contact Number",
                      hintText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Your number";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emaileditingcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Enter Your Email",
                      hintText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Email";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: loactioneditingcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Enter Your Location",
                      hintText: "Present Address",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Your location";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        )),
                    onPressed: () async {
                      if (infoFormKey.currentState!.validate()) {
                        infoFormKey.currentState!.save();
                        AddStudents();
                      }
                      else{
                        AddStudents();
                      }
                    },
                    child: Text(
                      "Save Student",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
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
