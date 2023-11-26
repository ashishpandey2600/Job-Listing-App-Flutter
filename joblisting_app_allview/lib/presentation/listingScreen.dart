import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joblisting_app_allview/email_auth/login.dart';

import '../ChatFunctionality/model/messageModel.dart';
import '../ChatFunctionality/model/usermodel.dart';
import '../ChatFunctionality/ui/chatroom.dart';
import '../model/uploadDatamodel.dart';
import '../publishApp/publishjob.dart';

class ListingScreen extends StatefulWidget {
  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
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
                    "login/SignUp",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PublishJob()));
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
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const PublishJob()));
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