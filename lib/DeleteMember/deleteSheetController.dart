import 'package:googlesheet_flutter_app/model/deleteMemberClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DeleteSheetController{
  final void Function(String) callback;

  static const String URL = "https://script.google.com/macros/s/AKfycbydpbMtU8A9c96aSz-q1Vcr_bqxi-aeh-Wf_ukgSQXekPIpBvO6XMr3kHFtHmqwH3Ov/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  DeleteSheetController(this.callback);

  Future<void> deleteForm(DeleteMemberClass deleteMemberClass) async {
    try {

      await http.get(
          URL + deleteMemberClass.toParam()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });

    }catch(err){

    }
  }
}