import 'package:flutter/material.dart';
import 'package:flutter_application_9/widgets/bottomnav.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final List<Produk> produkList = [
    Produk(nama: "Blankon", icon: Icons.checkroom, image: Image.asset('assets/logonama.png'),),
    Produk(nama: "Beskap", icon: Icons.checkroom, image: Image.asset('assets/logonama.png'),),
    Produk(nama: "Kebaya", icon: Icons.checkroom, image: Image.asset('assets/logonama.png'),),
    Produk(nama: "Surjan", icon: Icons.checkroom, image: Image.asset('assets/logonama.png'),),
    Produk(nama: "Jawi Jangkep", icon: Icons.checkroom, image: Image.asset('assets/logonama.png'),),
    Produk(nama: "Basahan", icon: Icons.checkroom, image: Image.asset('assets/logonama.png'),),
    Produk(nama: "Kanigaran", icon: Icons.checkroom, image: Image.asset('assets/logonama.png'),),
    Produk(nama: "Kain Jarik", icon: Icons.checkroom,image: Image.asset('assets/logonama.png'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2EFE9),
        automaticallyImplyLeading: false,
        title: const Text("Data Produk", style: TextStyle(color: Colors.brown)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: produkList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final produk = produkList[index];
            return ProdukCard(produk: produk);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }
}

class ProdukCard extends StatelessWidget {
  final Produk produk;

  const ProdukCard({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8E6DA),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(produk.icon, size: 48, color: Colors.brown),
          const SizedBox(height: 12),
          Text(
            produk.nama,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Tersedia",
              style: TextStyle(fontSize: 12, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

class Produk {
  final String nama;
  final IconData icon;
  final Image image;

  Produk({required this.nama, required this.icon, required this.image});
}
