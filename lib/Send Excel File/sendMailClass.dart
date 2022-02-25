//For Send Mail
class SendMailClass{
  String _title;
  String _body;
  String _email;

  SendMailClass(this._title, this._body, this._email);

  String toParam() => "?title=$_title&body=$_body&email=$_email";
}