import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_information/Database/db_helper.dart';
import 'package:student_information/Model/info.dart';
import 'package:student_information/add_student.dart';

class ViewAllNotes extends StatefulWidget {
  const ViewAllNotes({super.key});

  @override
  State<ViewAllNotes> createState() => _ViewAllNotesState();
}

class _ViewAllNotesState extends State<ViewAllNotes> {
  late DatabaseHelper dbHelper;
  List<Info> infos = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    loadAllStudents();
  }
  Future loadAllStudents() async {
    final data = await dbHelper.getAllData();
    try {
      setState(() {
        infos = data.map((e) => Info.fromMap(e)).toList();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load data: \$e");
    }
    setState(() {
      infos = data.map((e) => Info.fromMap(e)).toList();
    });
  }

  Future deleteNote(int id) async {
    int check = await dbHelper.deleteData(id);
    if (check > 0) {
      Fluttertoast.showToast(
          msg: "Students Data has been deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      loadAllStudents();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Students",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: infos.isEmpty
          ? const Center(
        child: Text("No Students Data available!"),
      )
          : ListView.builder(
          itemCount: infos.length,
          itemBuilder: (context, index) {
            Info info = infos[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                title: Text(
                  info.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(info.email!),
                leading: const Icon(
                  Icons.mail_outline,
                  size: 40,
                ),
                trailing: IconButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        headerAnimationLoop: false,
                        animType: AnimType.bottomSlide,
                        title: 'Delete',
                        desc: 'Want to delete note ?',
                        buttonsTextStyle:
                        const TextStyle(color: Colors.white),
                        showCloseIcon: true,
                        btnCancelOnPress: () {},
                        btnOkText: 'YES',
                        btnCancelText: 'NO',
                        btnOkOnPress: () {
                          deleteNote(info.id!);
                          Get.back();
                        },
                      ).show();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    )),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: "Add Student",
        mini: false,
        onPressed: () {
          Get.to(() => AddStudent(), transition: Transition.cupertino);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
