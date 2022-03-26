import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/models/message_model.dart';
import 'package:flutter_socket_io/models/typing_model.dart';
import 'package:flutter_socket_io/widgets/message_item.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:username_gen/username_gen.dart';

class ChatViewModel extends ChangeNotifier {
  TextEditingController textController = TextEditingController();

  final username = UsernameGen.generateWith(
    data: UsernameGenData(
      names: ['name'],
      adjectives: ['new adjectives'],
    )
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<MessageItem> _messages = [];
  List<MessageItem> get messages => _messages;
  set messages(List<MessageItem> val) {
    _messages = val;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  late Socket _socket;
  Socket get socket => _socket;
  set socket(Socket val) {
    _socket = val;
    notifyListeners();
  }

  String _typing = "";
  String get typing => _typing;
  set typing(String val) {
    _typing = val;
    notifyListeners();
  }

  ChatViewModel() {
    connectToServer();
  }

  void connectToServer() {
    if (kDebugMode) {
      print('Connect to server');
    }
    try {
      socket = io('http://127.0.0.1:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket.connect();
      socket.on('connect', (_) {
        if (kDebugMode) {
          print('connect: ${socket.id}');
        }
      });
      // socket.on('location', handleLocationListen);
      socket.on('typing', handleTyping);
      socket.on('message', handleMessage);
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void sendMessage() {
    try {
      if (textController.text.isNotEmpty) {
        sendTyping(false);
        socket.emit("message", MessageModel(socket.id!, username, textController.text, DateTime.now()));
        textController.clear();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void sendTyping(bool typing) {
    socket.emit("typing", TypingModel(socket.id!, username, typing).toJson());
  }

  void handleMessage(data) {
    final value = MessageModel.fromJson(data);
    messages.insert(0, MessageItem(message: value, me: value.id == socket.id));
    notifyListeners();
  }

  void handleTyping(data) {
    final value = TypingModel.fromJson(data);
    typing = value.typing ? '${value.username} is typing ...' : '';
  }

  @override
  void dispose() {
    socket.disconnected;
    super.dispose();
  }
}
