import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_real/models/band.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands =[
    Band(id: '1', name: 'Mana', votes: 3),    
    Band(id: '2', name: 'Enanitos verdes', votes: 5),    
    Band(id: '3', name: 'Muse', votes: 2),    
    Band(id: '4', name: 'Sebastian Romero', votes: 1),    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
        // centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, int i) => _bandTitle(bands[i])
        ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),),
   );
  }

  Widget _bandTitle(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('Direccion : ${direction}');
        print('id: ${band.id}');
        this.bands.remove(band);
        print(bands);
        // setState(() {
        // });
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child:const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 20,),
              Text('Dele Band',style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              // ignore: sort_child_properties_last
              child: Text(band.name.substring(0,2)),
               backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name),
            trailing: Text('${band.votes}',style: const TextStyle(fontSize: 20),),
            onTap: () => print(band.name),
           
          ),
    );
        
  }
   addNewBand() {
    final textController = TextEditingController();
    if(Platform.isAndroid){
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('new band name'),
          content: TextField(
            controller: textController,
            
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed:() =>  addBandToList(textController.text)
              ),
          ],
        );
      },
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('new band name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child:Text('Add'),
              onPressed:() =>  addBandToList(textController.text)
              ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              // isDefaultAction: true,
              child:Text('Dismiss'),
              onPressed:() =>  Navigator.pop(context)
              ),
              
              
          ],
          
        );
      },
      );


  
}
void addBandToList(String name){
  if(name.length > 1){
    //podemos agregar
    print("Agregando..");
    this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
  setState(() { });
  }

  Navigator.pop(context);
}


}

