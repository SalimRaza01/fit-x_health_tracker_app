

import 'package:fit_x/core/constants/Constants.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? profilePic;
  String? token;
  String? aboutMe;
  String? gender;
  String? dob;
  String? createdAt;
  String? lastSeen; // <-- added
  String? passcode; // <-- NEW passcode field

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.token,
    this.aboutMe,
    this.gender,
    this.dob,
    this.createdAt,
    this.lastSeen, // <-- added
    this.passcode, // <-- passcode in constructor
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map[Constants.UID] as String?;
    name = map[Constants.name] as String?;
    email = map[Constants.email] as String?;
    phone = map[Constants.phoneNumber] as String?;
    profilePic = map[Constants.image] as String?;
    token = map[Constants.token] as String?;
    aboutMe = map[Constants.aboutMe] as String?;
    gender = map[Constants.gender] as String?;
    dob = map[Constants.dob] as String?;
    createdAt = map[Constants.createdAT] as String?;
    lastSeen = map[Constants.lastSeen] as String?; // <-- added
    passcode = map[Constants.passcode] as String?; // <-- added passcode field

  }

  Map<String, dynamic> toMap() {
    return {
      Constants.UID: uid,
      Constants.name: name,
      Constants.email: email,
      Constants.phoneNumber: phone,
      Constants.image: profilePic,
      Constants.token: token,
      Constants.aboutMe: aboutMe,
      Constants.gender: gender,
      Constants.dob: dob,
      Constants.createdAT: createdAt,
      Constants.lastSeen: lastSeen, // <-- added
      Constants.passcode: passcode, // <-- added passcode field

    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? profilePic,
    String? token,
    String? aboutMe,
    String? gender,
    String? dob,
    String? createdAt,
    String? lastSeen,
    bool? isOnline,
    bool? isTyping, // <-- added
    List<String>? blockedUsers, // <-- added
    String? uniqueID, // <-- added
    String? passcode, // <-- added passcode in copyWith
    List<String>? friendsUids,
    List<String>? groupUids,
    List<String>? friendRequestUids,
    List<String>? sentFriendRequestUids,
    List<String>? blockedBy, // <-- NEW
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePic: profilePic ?? this.profilePic,
      token: token ?? this.token,
      aboutMe: aboutMe ?? this.aboutMe,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      createdAt: createdAt ?? this.createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
      passcode: passcode ?? this.passcode, // <-- added

    );
  }
}
