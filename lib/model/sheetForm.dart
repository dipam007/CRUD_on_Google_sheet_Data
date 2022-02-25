//For Add Member
class SheetForm{
  String _id;
  String _name;
  String _mobile;
  String _email;

  SheetForm(this._id, this._name, this._mobile, this._email);

  String toParam() => "?id=$_id&name=$_name&mobile=$_mobile&email=$_email";
}