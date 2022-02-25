//For Show Member
class Member{
  final id;
  final name;
  final mobile;
  final email;

  Member({this.id, this.name, this.mobile, this.email});

  factory Member.fromJson(dynamic json){
      return Member(
        id: "${json['id']}",
        name: "${json['name']}",
        mobile: "${json['mobile']}",
        email: "${json['email']}",
      );
  }

  Map toJson() => {
  "id": id,
  "name": name,
  "mobile": mobile,
  "email": email
  };
}