import 'package:flutter/material.dart';
import 'package:flutter_socket_io/core/view_models/chat_vm.dart';
import 'package:flutter_socket_io/widgets/chat_text_field.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin  {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Communication'),
      ),
      body: Column(
        children: [
          Text(provider.typing.isNotEmpty ? provider.typing : ''),
          Flexible(child: ListView(
            reverse: true,
            padding: const EdgeInsets.all(16),
            children: [...provider.messages],
          )),
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: const ChatTexField(),
          )
        ],
      ),
    );
  }
}
