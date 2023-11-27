import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joblisting_app_allview/presentation/listingScreen.dart';

import '../../email_auth/login.dart';
import '../ChatFunctionality/model/usermodel.dart';
import '../model/applyForjobmodel.dart';

class ProfilePage extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const ProfilePage(
      {super.key, required this.userModel, required this.firebaseUser});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            child: userModel.profilepic == null ? Icon(Icons.person) : null,
            backgroundImage: NetworkImage(
              userModel.profilepic.toString(),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
              child: Text(
            userModel.fullname.toString(),
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
          )),
          const SizedBox(
            height: 100,
          ),
          CupertinoButton(
              color: Colors.red,
              child: Text("Logout"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // Navigator.popUntil(
                //     context,
                //     (route) => route
                //         .isFirst); //closes all pages before current page which is going to be the first
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => ListingScreen()));
              }),
          // Padding(
          //   padding: const EdgeInsets.all(100),
          //   child: FloatingActionButton(
          //       backgroundColor: Colors.pink,
          //       child: const Icon(Icons.search),
          //       onPressed: () {
          //         // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         //   return SearchPage(
          //         //       userModel: userModel, firebaseUser: firebaseUser);
          //         // }));
          //       }),
          // ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("AppliedForJobs")
                    // .where(userModel.uid.toString(),
                    //     isEqualTo: "FOBA6RQr6ChWG5D2OxEJsD1kptF2")
                    .snapshots(),
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
                            ApplyforJobModel currentdata =
                                ApplyforJobModel.fromMap(
                                    datasnapshot.docs[index].data()
                                        as Map<String, dynamic>);
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
                                            currentdata.name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(currentdata.place.toString()),
                                    ), //company name
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(currentdata.aboutyou.toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          currentdata.applicantid.toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(currentdata.resumeLink
                                          .toString()
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
      ),
    );
  }
}
