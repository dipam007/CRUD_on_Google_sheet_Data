//For Delete Member
class DeleteMemberClass{
  String _id;

  DeleteMemberClass(this._id);

  String toParam() => "?id=$_id";
}