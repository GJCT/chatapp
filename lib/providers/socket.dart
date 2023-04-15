import 'package:chatapp/global/environment..dart';
import 'package:chatapp/providers/provider.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}


class SocketProvider with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async{

    final token = await AuthProvider.getToken();
    
    _socket = IO.io(
        Environment.socketUrl, IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .enableForceNew()
        .setExtraHeaders({
          'Authorization': token
        })
        .build()
    );

    _socket.on('connect', (_) {
      print('conectados!');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      print('desconectado');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }


  void disconnect() {
    print('nos desconectamos');
    _socket.disconnect();
  }

}