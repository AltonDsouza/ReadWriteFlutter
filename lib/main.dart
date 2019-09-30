import 'dart:io' as prefix0;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

void main() async{

  var data = await readData();

  if(data != null){
    String message = await readData();
    print(message);
  }


  runApp(MaterialApp(
    title: "IO",
    home: new Home(),
  ));
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _enterDataField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read/Write"),
        
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      
      body: Container(
        
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(
              labelText: "Write Something"
            ),
          ),
          
          subtitle: FlatButton(
            onPressed: (){

              if(_enterDataField.text.isNotEmpty){
                writeData(_enterDataField.text);
              }
              else{

              }

            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Save Data"),
                
                Padding(padding: EdgeInsets.all(14.5),),
                
                FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context, AsyncSnapshot<String> data){

                    if(data.hasData != null) {
                      return Text(
                        data.data.toString(),
                        style: TextStyle(color: Colors.blueAccent),
                      );
                    }
                    else{
                      return Text("No data saved");
                    }
                  },
                )
                
              ],
            ),
          ),
        ),
      ),
      
    );
  }





}






Future<String>  get localPath async{

  final directory = await getApplicationDocumentsDirectory(); //home/directory:text
  return directory.path;
}



Future<File> get _localFile async{

  final path = await localPath;

  return new File("$path/data.txt");
}


//Write and read from our file
Future<File> writeData(String message) async{
  final file = await _localFile;

  return file.writeAsString("$message");
}


Future<String> readData() async{
  try{
    final file = await _localFile;

    String data =  await file.readAsString();

    return data;
  }catch(e){
    return "Nothing saved yet";
  }
}



