
import 'package:flutter/material.dart';
import '../services/location_service.dart';

class NearbyPage extends StatefulWidget {
  const NearbyPage({super.key});
  @override State<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  String status='Localização não definida';

  Future<void> locate() async {
    final p=await LocationService().currentPosition();
    setState(() => status=p == null ? 'Não foi possível obter localização' : 'Localização encontrada: ${p.latitude.toStringAsFixed(4)}, ${p.longitude.toStringAsFixed(4)}');
  }

  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(title: const Text('Perto de mim')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
        const Text('Encontre ofertas próximas', style: TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
        const SizedBox(height:12),
        Text(status),
        const SizedBox(height:20),
        FilledButton.icon(onPressed: locate, icon: const Icon(Icons.my_location), label: const Text('Usar minha localização')),
      ]),
    ),
  );
}
