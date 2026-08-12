
import 'package:flutter/material.dart';
import '../models.dart';
import '../repositories/offer_repository.dart';
import 'offer_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  final repo = OfferRepository();
  List<Offer> offers = [];
  bool loading = false;

  Future<void> search() async {
    setState(() => loading = true);
    try {
      offers = await repo.search(controller.text);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void initState() { super.initState(); search(); }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Buscar', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => search(),
          decoration: InputDecoration(
            hintText: 'Ex.: eletricista, celular, pintura...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(onPressed: search, icon: const Icon(Icons.arrow_forward)),
            filled: true, fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        if (loading) const Center(child: CircularProgressIndicator()),
        if (!loading && offers.isEmpty) const Padding(
          padding: EdgeInsets.all(30),
          child: Center(child: Text('Nenhuma oferta encontrada.')),
        ),
        ...offers.map((o) => Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.local_offer_outlined)),
            title: Text(o.title),
            subtitle: Text('${o.seller}\n⭐ ${o.rating}'),
            isThreeLine: true,
            trailing: Text(o.price, style: const TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OfferPage(offer: o))),
          ),
        )),
      ],
    ),
  );
}
