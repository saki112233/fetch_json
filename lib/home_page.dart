import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url =  "https://app.schertech.com/task_visu/php/task_visu_data_service.php?"
      "service=get_all_task&user_id=101004&start_date=01.01.2019%2000:"
      "00&end_date=01.01.2050%2000:00&status=offen&task_type=my_task&team_id=0"
      "&stage_key=";
  List myAllData=[];
  loadData()async{
http.Response response=await http.get(Uri.parse(url));
if(response.statusCode==200){
  String data=response.body;
  var decodeData=jsonDecode(data);
  List global=decodeData.map((x)=>Records.fromJson(x)).toList();
  setState(() {
    myAllData=global;
  });
  return decodeData;
}else{
  setState(() {
    myAllData=[];
  });
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myAllData==null?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: myAllData.length,
        itemBuilder: (BuildContext context,int index){
         return Container(
           child: Text("ID: ${myAllData[index].id}"),
         );
        },
      ),
    );
  }
}
