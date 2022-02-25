import 'package:googlesheet_flutter_app/model/editMemberClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EditSheetController{
  final void Function(String) callback;

  static const String URL = "https://script.google.com/macros/s/AKfycbzvBPIb5bpCWvjetejdhgbyPfquRac-2Jw9c7-pISPMoBh-g8vl3qNg7Pflg3z7LZk3/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  EditSheetController(this.callback);

  Future<void> editForm(EditMemberClass editMemberClass) async {
    try {

      await http.get(
          URL + editMemberClass.toParam()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });

    }catch(err){

    }
  }
}