import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joblisting_app_allview/email_auth/login.dart';
import 'package:joblisting_app_allview/model/applyForjobmodel.dart';

import '../ChatFunctionality/model/usermodel.dart';
import '../model/uploadDatamodel.dart';
import 'ApplyingForJob.dart/ApplyingForJob.dart';
import 'publishApp/publishjob.dart';

class ListingScreen extends StatefulWidget {
  UserModel? userModel;
  User? firebaseuser;

  ListingScreen({super.key, this.userModel, this.firebaseuser});
  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    log(widget.userModel.toString());
    log(widget.firebaseuser.toString());
  }

  logout() async {
    log(widget.userModel.toString());
    await FirebaseAuth.instance.signOut();
    widget.userModel = null;
    setState(() {});
    Navigator.popUntil(
        context,
        (route) => route
            .isFirst); //closes all pages before current page which is going to be the first
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => ListingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Jobs"),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 2, top: 10, bottom: 10),
            child: (widget.firebaseuser == null)
                ? TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.teal)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: const Text(
                        "login/SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    })
                : TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.teal)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      logout();
                    }),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 2, top: 10, bottom: 10),
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: const Text(
                    "Post a Job",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  if (widget.userModel != null) {
                    if (widget.userModel!.userType == "Jobprovider") {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PublishJob()));
                    } else if (widget.userModel!.userType == "JobSeeker") {
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          content: Text("Please register as Company First")));
                    }
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }
                }),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Jobs").snapshots(),
                // .collection("message")
                // .orderBy("createdOn", descending: true)
                // .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot datasnapshot =
                          snapshot.data as QuerySnapshot;
                      log(datasnapshot.toString());
                      return ListView.builder(
                          reverse: false,
                          itemCount: datasnapshot.docs.length,
                          itemBuilder: (context, index) {
                            UploadDataModel currentdata =
                                UploadDataModel.fromMap(datasnapshot.docs[index]
                                    .data() as Map<String, dynamic>);
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            currentdata.tech.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                        TextButton(
                                            style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.teal)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Text(
                                                "Apply",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (widget.firebaseuser != null) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ApplyForJob(
                                                            JobId: currentdata
                                                                .id
                                                                .toString(),
                                                            userModel: widget
                                                                .userModel!,
                                                            firebaseuser: widget
                                                                .firebaseuser!)));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginPage()));
                                              }
                                            }),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(currentdata.type.toString()),
                                    ), //company name
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          currentdata.freeString.toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(currentdata.tenure.toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(currentdata.jobdiscription
                                          .toString()),
                                    ),
                                    TextButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.teal)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            "Talk to Recriuiter",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //              ChatRoomPage(chatroom: ,firebaseUser: ,userModel: ,targetUser: ,)));
                                        }),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            "An error occured! Please check your internet connection"),
                      );
                    } else {
                      return const Center(
                        child: Text("Say hii to your new friend"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
/*
Card(
                              color: Colors.deepOrangeAccent,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(currentdata.name.toString()),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(currentdata.tech.toString()),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(currentdata.type.toString()),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(currentdata.uploadedon.toString()),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          currentdata.jobdiscription.toString())
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [Text("Google"), Text("Check")],
                                  )
                                ]),
                              ),
                            ); */