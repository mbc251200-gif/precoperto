
class Offer {
  final String id;
  final String title;
  final String price;
  final String seller;
  final double rating;
  final double? distance;
  final bool sponsored;
  final String type;

  Offer({
    required this.id,
    required this.title,
    required this.price,
    required this.seller,
    required this.rating,
    this.distance,
    this.sponsored = false,
    required this.type,
  });

  factory Offer.fromMap(Map<String, dynamic> m) {
    final product = m['products'] as Map<String, dynamic>?;
    final service = m['services'] as Map<String, dynamic>?;
    final seller = m['sellers'] as Map<String, dynamic>?;

    return Offer(
      id: '${m['id']}',
      title: (product?['name'] ?? service?['name'] ?? 'Oferta').toString(),
      price: 'R\$ ${m['price']}',
      seller: (seller?['business_name'] ?? 'Vendedor').toString(),
      rating: double.tryParse('${seller?['rating'] ?? 0}') ?? 0,
      distance: null,
      sponsored: false,
      type: product != null ? 'product' : 'service',
    );
  }
}
