
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  const ChatPage({super.key, required this.conversationId});
  @override State<ChatPage> createState()=>_ChatPageState();
}
class _ChatPageState extends State<ChatPage>{
  final controller=TextEditingController();
  final client=Supabase.instance.client;

  Future<void> send() async{
    final text=controller.text.trim();
    final uid=client.auth.currentUser?.id;
    if(text.isEmpty||uid==null)return;
    await client.from('messages').insert({'conversation_id':widget.conversationId,'sender_id':uid,'body':text});
    controller.clear();
  }

  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(title: const Text('Conversa')),
    body: Column(children:[
      Expanded(child: StreamBuilder<List<Map<String,dynamic>>>(
        stream: client.from('messages').stream(primaryKey:['id']).eq('conversation_id',widget.conversationId).order('created_at'),
        builder:(context,s){
          if(!s.hasData)return const Center(child:CircularProgressIndicator());
          return ListView(children:s.data!.map((m)=>ListTile(title:Text(m['body']??''))).toList());
        },
      )),
      SafeArea(child:Row(children:[
        Expanded(child:TextField(controller:controller,decoration:const InputDecoration(hintText:'Digite sua mensagem'))),
        IconButton(onPressed:send,icon:const Icon(Icons.send)),
      ])),
    ]),
  );
}
