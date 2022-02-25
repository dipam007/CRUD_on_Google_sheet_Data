import 'package:googlesheet_flutter_app/model/sheetForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SheetController{
  final void Function(String) callback;

  static const String URL = "https://script.google.com/macros/s/AKfycbxrmdjwzUVFMSmsEft3zxWx5fHjUG1RF9a5FBCxQqGpAbRN5zXZS2jfT_lS7l3ku5GF/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  SheetController(this.callback);

  Future<void> submitForm(SheetForm sheetForm) async {
      try {

          await http.get(
              URL + sheetForm.toParam()
          ).then((response){
              callback(convert.jsonDecode(response.body)['status']);
          });

      }catch(err){

      }
  }
}