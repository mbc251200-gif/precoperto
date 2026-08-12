
import 'package:flutter/material.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Planos para vendedores')),
    body:ListView(
      padding:const EdgeInsets.all(16),
      children:[
        _plan('Grátis','R\$ 0','10 ofertas • perfil básico • contatos'),
        _plan('Profissional','R\$ 39,90/mês','100 ofertas • estatísticas • destaque'),
        _plan('Empresa','R\$ 99,90/mês','Ofertas ilimitadas • campanhas • relatórios'),
      ],
    ),
  );
  Widget _plan(String name,String price,String features)=>Card(
    child:Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(name,style:const TextStyle(fontSize:21,fontWeight:FontWeight.bold)),
      const SizedBox(height:6),Text(price,style:const TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
      const SizedBox(height:8),Text(features),
      const SizedBox(height:15),FilledButton(onPressed:(){},child:const Text('Escolher plano')),
    ])),
  );
}
