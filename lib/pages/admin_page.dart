
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  Future<int> count(String table) async {
    final r=await Supabase.instance.client.from(table).select('id');
    return (r as List).length;
  }

  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(title: const Text('Painel administrativo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children:[
        const Text('PreçoPerto Admin',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
        const SizedBox(height:20),
        _metric('Usuários','profiles'),
        _metric('Vendedores','sellers'),
        _metric('Produtos','products'),
        _metric('Serviços','services'),
        _metric('Ofertas','offers'),
        _metric('Eventos de anúncios','ad_events'),
      ],
    ),
  );

  Widget _metric(String label,String table)=>FutureBuilder<int>(
    future:count(table),
    builder:(context,s)=>Card(child:ListTile(
      title:Text(label),
      trailing:Text(s.hasData?'${s.data}':'... ',style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
    )),
  );
}
