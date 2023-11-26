import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joblisting_app_allview/main.dart';
import 'package:joblisting_app_allview/model/uploadDatamodel.dart';

class PublishJob extends StatefulWidget {
  const PublishJob({super.key});

  @override
  State<PublishJob> createState() => _PublishJobState();
}

class _PublishJobState extends State<PublishJob> {
  TextEditingController jobdiscriptionController = TextEditingController();
  TextEditingController jobnameController = TextEditingController();
  TextEditingController technameController = TextEditingController();
  TextEditingController jobtypeController = TextEditingController();
  TextEditingController tenureController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  void publishJob() {
    UploadDataModel uploadDataModel = UploadDataModel(
        id: "8932", //job Id
        userid: "89430", //
        jobdiscription: jobdiscriptionController.text,
        name: jobnameController.text,
        tech: technameController.text,
        type: jobtypeController.text,
        tenure: tenureController.text,
        freeString: salaryController.text,
        uploadedon: DateTime.now());

    FirebaseFirestore.instance
        .collection("Jobs")
        .doc(uuid.v1())
        .set(uploadDataModel.toMap());
    log("Data Uploaded!!");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "File Uploaded!",
        selectionColor: Colors.white,
      ),
      backgroundColor: Colors.green,
    ));
    jobdiscriptionController.clear();
    jobnameController.clear();
    technameController.clear();
    jobtypeController.clear();
    tenureController.clear();
    salaryController.clear();
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
                controller: jobdiscriptionController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Job description',
                    hintText: 'Job description'),
              ),
              TextField(
                controller: jobnameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Job Name',
                    hintText: 'Job Name'),
              ),
              TextField(
                controller: technameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'tech',
                    hintText: 'tech'),
              ),
              TextField(
                controller: jobtypeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Remote/In-office',
                    hintText: 'Remote/In-office'),
              ),
              TextField(
                controller: tenureController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Tenure',
                    hintText: 'Tenure'),
              ),
              TextField(
                controller: salaryController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Salary',
                    hintText: 'Salary'),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                  color: Colors.teal,
                  child: Text("Post the job"),
                  onPressed: () {
                    publishJob();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
