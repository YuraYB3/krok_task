// ignore_for_file: file_names
class UserModel {
  final String uid;

  UserModel({
    required this.uid,
  });

  toJson() {
    return {
      'uid': uid,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
      );
}
