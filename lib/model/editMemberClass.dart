//For Add Member
class EditMemberClass{
  String _id;
  String _name;
  String _mobile;
  String _email;

  EditMemberClass(this._id, this._name, this._mobile, this._email);

  String toParam() => "?id=$_id&name=$_name&mobile=$_mobile&email=$_email";
}