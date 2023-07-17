import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_ai/models/chat_message.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class StreamSocket{
  final _socketResponse= StreamController<ChatMessage>();

  void Function(ChatMessage) get addResponse => _socketResponse.sink.add;

  Stream<ChatMessage> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

class ChatSocketService {
  final io.Socket _socket;
  final StreamSocket _streamSocket = StreamSocket();

  Stream<ChatMessage> get stream => _streamSocket.getResponse;

  ChatSocketService(this._socket) {
    _socket.onDisconnect((_) => _streamSocket.dispose());
    _socket.on('chat', (data) => onMessage(data as Map<String, dynamic>));
    _socket.on('error', (message) => Fluttertoast.showToast(
          msg: message['message'] as String,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
      ),
    );
  }

  Future<ChatMessage> sendMessage(ChatMessage message) {
    final future = Completer<ChatMessage>();
    _socket.emitWithAck('chat', message.message, ack: (data) {
        print('ack received');
        final chatMessage = ChatMessage.fromApi(data as Map<String, dynamic>, sender: ChatMessageSender.user);
        future.complete(chatMessage);
      },
    );

    return future.future;
  }
  
  void onMessage(Map<String, dynamic> data) {
    print('Message received');
    final chatMessage = ChatMessage.fromApi(data, sender: ChatMessageSender.ai);
    _streamSocket.addResponse(chatMessage);
  }
}
