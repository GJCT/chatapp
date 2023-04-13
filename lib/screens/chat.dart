import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
   
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];

  bool _escribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xaaA4F4F4),
        centerTitle: true,
        title: Row(
          children: [
            CircleAvatar(
              child: const Text('Test', style: TextStyle(fontSize: 14)),
              backgroundColor: Colors.blueAccent[400],
              maxRadius: 23,
            ),
            const SizedBox(width: 10),
            const Text('Usuario', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),)
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

    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text, 
      uid: '1232', 
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