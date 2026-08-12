
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/offer_repository.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});
  @override State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final name = TextEditingController();
  final desc = TextEditingController();
  final price = TextEditingController();
  bool loading = false;

  Future<void> save() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entre na sua conta primeiro.')));
      return;
    }
    setState(() => loading = true);
    try {
      var seller = await client.from('sellers').select('id').eq('owner_id', user.id).maybeSingle();
      if (seller == null) {
        seller = await client.from('sellers').insert({
          'owner_id': user.id,
          'business_name': 'Meu negócio',
        }).select('id').single();
      }
      await OfferRepository().createService(
        sellerId: seller['id'],
        name: name.text.trim(),
        description: desc.text.trim(),
        price: double.parse(price.text.replaceAll(',', '.')),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Serviço cadastrado!')));
        name.clear(); desc.clear(); price.clear();
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Cadastrar serviço')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Nome do serviço')),
        TextField(controller: desc, maxLines: 4, decoration: const InputDecoration(labelText: 'Descrição')),
        TextField(controller: price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Preço inicial')),
        const SizedBox(height: 20),
        FilledButton(onPressed: loading ? null : save, child: Text(loading ? 'Salvando...' : 'Publicar oferta')),
      ],
    ),
  );
}
