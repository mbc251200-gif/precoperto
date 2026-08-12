import 'package:flutter/material.dart';

void main() => runApp(const PrecoPertoApp());

class PrecoPertoApp extends StatelessWidget {
  const PrecoPertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preço Perto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = const [
    HomeContent(),
    Center(child: Text('Buscar')),
    Center(child: Text('Favoritos')),
    Center(child: Text('Conta')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preço Perto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Conta',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Encontre as melhores ofertas perto de você',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'O que você procura?',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const OfferPreview(
          title: 'Oferta especial',
          price: 'R\$ 29,90',
          rating: 4.8,
          seller: 'Parceiro',
          sponsored: true,
        ),
        const SizedBox(height: 12),
        const OfferPreview(
          title: 'Produto em promoção',
          price: 'R\$ 49,90',
          rating: 4.6,
          seller: 'Loja local',
        ),
      ],
    );
  }
}

class OfferPreview extends StatelessWidget {
  final String title;
  final String price;
  final double rating;
  final String seller;
  final bool sponsored;

  const OfferPreview({
    super.key,
    required this.title,
    required this.price,
    required this.rating,
    required this.seller,
    this.sponsored = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.local_offer_outlined),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sponsored)
              const Text(
                'PATROCINADO',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Text(title),
          ],
        ),
        subtitle: Text('⭐ $rating  •  $seller'),
        trailing: Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
