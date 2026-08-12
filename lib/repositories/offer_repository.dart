
import '../models.dart';
import '../services/supabase_service.dart';

class OfferRepository {
  Future<List<Offer>> search(String term) async {
    final client = SupabaseService.client;
    if (client == null) return _demo(term);

    final productResponse = await client
        .from('offers')
        .select('id, price, promotional_price, products(name), sellers(business_name, rating)')
        .eq('status', 'active')
        .not('product_id', 'is', null)
        .order('price')
        .limit(30);

    final serviceResponse = await client
        .from('offers')
        .select('id, price, promotional_price, services(name), sellers(business_name, rating)')
        .eq('status', 'active')
        .not('service_id', 'is', null)
        .order('price')
        .limit(30);

    final rows = [...productResponse, ...serviceResponse]
        .where((r) {
          final product = r['products'];
          final service = r['services'];
          final title = '${product?['name'] ?? ''} ${service?['name'] ?? ''}'.toLowerCase();
          return term.trim().isEmpty || title.contains(term.toLowerCase());
        })
        .toList();

    rows.sort((a, b) =>
        (double.tryParse('${a['price']}') ?? 0)
            .compareTo(double.tryParse('${b['price']}') ?? 0));

    return rows.map((r) => Offer.fromMap(r)).toList();
  }

  Future<void> createService({
    required String sellerId,
    required String name,
    required String description,
    required double price,
  }) async {
    final client = SupabaseService.client;
    if (client == null) throw Exception('Configure o Supabase primeiro.');

    final service = await client.from('services').insert({
      'seller_id': sellerId,
      'name': name,
      'description': description,
      'starting_price': price,
    }).select('id').single();

    await client.from('offers').insert({
      'seller_id': sellerId,
      'service_id': service['id'],
      'price': price,
      'status': 'active',
    });
  }

  List<Offer> _demo(String term) {
    final data = [
      Offer(id: '1', title: 'Eletricista residencial', price: 'R\$ 80', seller: 'Eletricidade Silva', rating: 4.9, distance: 2.4, type: 'service'),
      Offer(id: '2', title: 'Instalação de ar-condicionado', price: 'R\$ 180', seller: 'Clima Sul', rating: 4.9, distance: 3.2, sponsored: true, type: 'service'),
      Offer(id: '3', title: 'Smartphone 128 GB', price: 'R\$ 1.899', seller: 'Loja Parceira', rating: 4.8, distance: 5.1, type: 'product'),
    ];
    if (term.trim().isEmpty) return data;
    return data.where((x) => x.title.toLowerCase().contains(term.toLowerCase())).toList();
  }
}
