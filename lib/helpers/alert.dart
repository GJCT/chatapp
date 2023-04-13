import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlert(BuildContext context, String titulo, String subtitulo){
  
  if(Platform.isAndroid){
    return showDialog(
      context: context, 
      builder: ( _) => AlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          MaterialButton(
            child: const Text('Revisar'),
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context) 
          )
        ],
      )
    );
  } else {
    return showCupertinoDialog(
      context: context, 
      builder: ( _) => CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          CupertinoDialogAction(
            child: const Text('Revisar'),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context) 
          )
        ],
      )
    );
  }
}