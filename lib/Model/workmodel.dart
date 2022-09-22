// To parse this JSON data, do
//
//     final workModel = workModelFromJson(jsonString);

import 'dart:convert';

List<WorkModel> workModelFromJson(String str) => List<WorkModel>.from(json.decode(str).map((x) => WorkModel.fromJson(x)));

String workModelToJson(List<WorkModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkModel {
  WorkModel({
    required this.data,
    required this.id,
    required this.logo,
    required this.text,
  });

  List<Datum> data;
  int id;
  String logo;
  String text;

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    id: json["id"],
    logo: json["logo"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "id": id,
    "logo": logo,
    "text": text,
  };
}

class Datum {
  Datum({
   required this.jobtype,
   required this.address,
   required this.availability,
   required this.contact,
   required this.experience,
   required this.gender,
   required this.id,
   required this.name,
   required this.preferedworkarea,
   required this.servicetype,
  });

  String jobtype;
  String address;
  String availability;
  String contact;
  String experience;
  String gender;
  int id;
  String name;
  String preferedworkarea;
  String servicetype;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jobtype: json[" jobtype"],
    address: json["address"],
    availability: json["availability"],
    contact: json["contact"],
    experience: json["experience"],
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    preferedworkarea: json["preferedworkarea"],
    servicetype: json["servicetype"],
  );

  Map<String, dynamic> toJson() => {
    " jobtype": jobtype,
    "address": address,
    "availability": availability,
    "contact": contact,
    "experience": experience,
    "gender": gender,
    "id": id,
    "name": name,
    "preferedworkarea": preferedworkarea,
    "servicetype": servicetype,
  };
}

