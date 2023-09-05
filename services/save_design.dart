import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class _SavePosition {
  final double dx;
  final double dy;
  final String tool;

  _SavePosition({
    required this.dx,
    required this.dy,
    required this.tool,
  });

  factory _SavePosition.fromJson(Map<String, dynamic> json) {
    return _SavePosition(
      tool: json["tool"],
      dx: json["dx"],
      dy: json["dy"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tool'] = this.tool;
    data['dx'] = this.dx;
    data['dy'] = this.dy;
    return data;
  }
}

Future<List<_SavePosition>> fetch_SavePosition() async{
  var url = 'https://test.devdev.kr';
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
    List list = jsonDecode(response.body);
    var SaveList = list.map((element)=> _SavePosition.fromJson(element)).toList();
    print('확인');
    return SaveList;
  }
  else {throw Exception("노우우우");}

}
