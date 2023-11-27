class ApplyforJobModel {
  String? jobid;
  String? applicantid;
  String? place;
  String? name;
  String? age;
  String? expirence;
  String? resumeLink;
  String? aboutyou;
  String? gender;
  DateTime? uploadedon;

  ApplyforJobModel(
      {this.jobid,
      this.applicantid,
      this.place,
      this.name,
      this.age,
      this.expirence,
      this.resumeLink,
      this.aboutyou,
      this.gender,
      this.uploadedon,
    
      });

  ApplyforJobModel.fromMap(Map<String, dynamic> map) {
    jobid = map['jobid'];
    applicantid = map['applicantid'];
    place = map['place'];
    name = map['name'];
    age = map['age'];
    expirence = map['expirence'];
    resumeLink = map['resumeLink'];
    aboutyou = map['aboutyou'];
    gender = map['gender'];
    uploadedon = map['uploadedon'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
  "jobid":jobid,
      "applicantid":applicantid,
      "place":place,
      "name":name,
      "age":age,
      "expirence":expirence,
      "resumeLink":resumeLink,
      "aboutyou":aboutyou,
      "gender":gender,
      "uploadedon":uploadedon
    };
  }
}
