import 'dart:io';

import 'package:chatapp/models/models.dart';
import 'package:chatapp/providers/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
   
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatProvider chatProvider;
  late SocketProvider socketProvider;
  late AuthProvider authProvider;

  final List<ChatMessage> _messages = [];

  bool _escribiendo = false;

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    socketProvider = Provider.of<SocketProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    socketProvider.socket.on('mensaje-personal', _messageController);

    _cargarHistorial(chatProvider.usuarioMsg.uid);
  }

  void _cargarHistorial(String usuarioID) async{
    List<Mensaje> chat = await chatProvider.getChat(usuarioID);

    final history = chat.map((m) => ChatMessage(
      text: m.mensaje, 
      uid: m.de, 
      animation: AnimationController(
        vsync: this,
        duration:  const Duration(milliseconds: 0)
      )..forward(),
      ),
    );

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _messageController(dynamic data){
    print('mensajes');

    ChatMessage messages = ChatMessage(
      text: data('mensaje'), 
      uid: data('de'), 
      animation: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 10)
      ));

      setState(() {
        _messages.insert(0, messages);
      });

      messages.animation.forward();
  }

  @override
  Widget build(BuildContext context) {

  final usuario = chatProvider.usuarioMsg;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 23,
        backgroundColor: const Color(0xaaA4F4F4),
        centerTitle: true,
        title: Row(
          children: [
            const CircleAvatar(
              child: Image(image: AssetImage('assets/avatar.png')),
              maxRadius: 23,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(usuario.nombre, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body: SizedBox(
         child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: ( _, i) => _messages[i],
                reverse: true,
              ),
            ),
            
            //Espacio entre cajas de texto
            const Divider(height: 2,),
            
            //Caja de texto
            Container(
              color: Colors.lightBlueAccent[100],
              child: _inputChat(),
            )
          ],
         ),
      ),
    );
  }

  Widget _inputChat() {

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitText,
                onChanged: (String text){
                  //Realiza el cambio para enviar el mensaje
                  setState(() {
                    if(text.trim().isNotEmpty){
                      _escribiendo = true;
                    } else {
                      _escribiendo = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Hablemos',
                ),
                focusNode: _focusNode,
              )
            ),
            
            //Botón para enviar mensaje
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isAndroid 
              ? IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: const Icon(Icons.send_rounded),
                color: Colors.blue[900],
                onPressed: _escribiendo ? 
                () => _submitText(_textController.text.trim()) 
                : null,
              ) 
              : CupertinoButton(
                child: const Text('Enviar'), 
                onPressed: _escribiendo ? 
                () => _submitText(_textController.text.trim()) 
                : null,
              )
            )
          ],
        ),
      ) 
    );
  }

  _submitText(String text) {
    
    if(text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: authProvider.usuario.uid, 
      text: text, 
      animation: AnimationController(
        vsync: this, 
        duration: const Duration(milliseconds: 450)
        )
      );
    _messages.insert(0, newMessage);
    newMessage.animation.forward();

    setState(() {
      _escribiendo = false;
    });

    socketProvider.emit('mensaje-personal', {
      'de'  : authProvider.usuario.uid,
      'para': chatProvider.usuarioMsg.uid,
      'text': text
    });
  }
  @override
  void dispose() {
    //off del socket

    for(ChatMessage message in _messages){
      message.animation.dispose();
    }
    super.dispose();
  }
}