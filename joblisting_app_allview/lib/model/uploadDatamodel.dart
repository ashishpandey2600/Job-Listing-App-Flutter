class UploadDataModel {
  String? id;
  String? userid;
  String? jobdiscription;
  String? name;
  String? tech;
  String? type;
  String? tenure;
  String? freeString;
  DateTime? uploadedon;

  UploadDataModel(
      {
      this.id,
      this.userid,
      this.jobdiscription,
      this.name,
      this.tech,
      this.type,
      this.tenure,
      this.freeString,
      this.uploadedon});

  UploadDataModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userid = map['userid'];
    jobdiscription = map['jobdiscription'];
    name = map['name'];
    tech = map['tech'];
    type = map['type'];
    tenure = map['tenure'];
    freeString = map['freeString'];
    uploadedon = map['uploadedon'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "jobdiscription": jobdiscription,
      "name": name,
      "tech": tech,
      "type": type,
      "tenure": tenure,
      "freeString": freeString,
      "uploadedon": uploadedon
    };
  }
}
