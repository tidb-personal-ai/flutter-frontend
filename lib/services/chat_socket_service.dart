import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumios/models/audio_message.dart';
import 'package:lumios/models/chat_message.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class StreamSocket<T>{
  final _socketResponse= StreamController<T>();

  void Function(T) get addResponse => _socketResponse.sink.add;

  Stream<T> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

class ChatSocketService {
  final io.Socket _socket;
  final StreamSocket<ChatMessage> _streamSocket = StreamSocket();
  final StreamSocket<AudioMessage> _audioStreamSocket = StreamSocket();

  Stream<ChatMessage> get stream => _streamSocket.getResponse;
  Stream<AudioMessage> get audioStream => _audioStreamSocket.getResponse;

  ChatSocketService(this._socket) {
    _socket.onDisconnect((_) => print('Websocket disconnected'));
    _socket.onConnect((_) => print('Websocket connected'));
    _socket.onReconnect((_) => print('Websocket reconnected'));
    _socket.onReconnectFailed((_) => print('Websocket reconnection failed'));
    _socket.on('chat', (data) => onMessage(data as Map<String, dynamic>));
    _socket.on('speech', (data) => onAudioMessage(data as Map<String, dynamic>));
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

  Future<void> sendAudio(String base64Message) {
    final future = Completer<void>();
    _socket.emitWithAck('speech', base64Message, ack: (_) {
        print('audio ack received');
        future.complete();
      },
    );

    return future.future;
  }
  
  void onMessage(Map<String, dynamic> data) {
    print('Message received');
    final chatMessage = ChatMessage.fromApi(data);
    _streamSocket.addResponse(chatMessage);
  }

  void onAudioMessage(Map<String, dynamic> data) {
    print('Audio message received');
    _audioStreamSocket.addResponse(AudioMessage.fromApi(data));
  }

  void close() {
    try {
      _socket.close();
    } finally {
      _streamSocket.dispose();
      _audioStreamSocket.dispose();
    }
  }
}
