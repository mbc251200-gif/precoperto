
import 'package:flutter/material.dart';
import '../models.dart';

class OfferPage extends StatelessWidget {
  final Offer offer;
  const OfferPage({super.key, required this.offer});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Oferta')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(height: 210, decoration: BoxDecoration(color: Colors.indigo.withValues(alpha: .08), borderRadius: BorderRadius.circular(18)), child: const Icon(Icons.photo_outlined, size: 80)),
        const SizedBox(height: 20),
        if (offer.sponsored) const Text('PATROCINADO', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(offer.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(offer.price, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Text('${offer.seller}  •  ⭐ ${offer.rating}'),
        if (offer.distance != null) Text('📍 ${offer.distance} km'),
        const SizedBox(height: 24),
        const Text('Compare antes de decidir. Verifique preço final, disponibilidade, entrega e condições diretamente com o vendedor.'),
        const SizedBox(height: 24),
        FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.chat_outlined), label: const Text('Entrar em contato')),
      ],
    ),
  );
}
