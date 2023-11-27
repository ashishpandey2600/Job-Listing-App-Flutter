import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joblisting_app_allview/main.dart';
import 'package:joblisting_app_allview/model/applyForjobmodel.dart';
import 'package:joblisting_app_allview/model/uploadDatamodel.dart';

import '../../ChatFunctionality/model/usermodel.dart';

class ApplyForJob extends StatefulWidget {
  final String JobId;
  final UserModel userModel;
  final User firebaseuser;
  const ApplyForJob(
      {super.key,
      required this.JobId,
      required this.userModel,
      required this.firebaseuser});

  @override
  State<ApplyForJob> createState() => _ApplyForJobState();
}

class _ApplyForJobState extends State<ApplyForJob> {
  TextEditingController placeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController expirenceController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  void ApplyJob() {
    ApplyforJobModel applyforJobModel = ApplyforJobModel(
      jobid: widget.JobId,
      applicantid: widget.firebaseuser.uid.toString(),
      place: placeController.text.trim(),
      name: nameController.text.trim(),
      age: ageController.text.trim(),
      expirence: expirenceController.text.trim(),
      resumeLink: resumeController.text.trim(),
      aboutyou: aboutController.text.trim(),
      gender: genderController.text.trim(),
      uploadedon: DateTime.now()
    );

    FirebaseFirestore.instance
        .collection("AppliedForJobs")
        .doc(uuid.v1())
        .set(applyforJobModel.toMap());
    log("Applied Job Data Uploaded!!");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Successfully Applied!",
        selectionColor: Colors.white,
      ),
      backgroundColor: Colors.green,
    ));
   
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Publish a Job")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Full Name',
                    hintText: 'Full Name'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Age',
                    hintText: 'Age'),
              ),
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Gender',
                    hintText: 'Gender'),
              ),
              TextField(
                controller: expirenceController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Expirence',
                    hintText: 'Expirence'),
              ),
              TextField(
                controller: aboutController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'About Yourself',
                    hintText: 'About Yourself'),
              ),
              TextField(
                controller: resumeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Resume Link',
                    hintText: 'Resume Link'),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                  color: Colors.teal,
                  child: Text("Apply for Post"),
                  onPressed: () {
                   ApplyJob();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
