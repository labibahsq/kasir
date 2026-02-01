import 'package:flutter/material.dart';
import 'package:flutter_application_9/widgets/bottomnav.dart';

class KasirView extends StatefulWidget {
  const KasirView({super.key});

  @override
  State<KasirView> createState() => _KasirViewState();
}

class _KasirViewState extends State<KasirView> {
  int qty1 = 0;
  int qty2 = 0;

  int harga1 = 10000;
  int harga2 = 15000;

  int get total => (qty1 * harga1) + (qty2 * harga2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2EFE9),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF2EFE9),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _item(
              "Kanigaran",
              harga1,
              qty1,
              () {
                setState(() => qty1++);
              },
              () {
                if (qty1 > 0) setState(() => qty1--);
              },
            ),
            _item(
              "blangkon",
              harga2,
              qty2,
              () {
                setState(() => qty2++);
              },
              () {
                if (qty2 > 0) setState(() => qty2--);
              },
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp $total",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC5A059),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC5A059),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Transaksi berhasil")),
                        );
                      },
                      child: const Text(
                        "BAYAR",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1B264F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  Widget _item(
    String nama,
    int harga,
    int qty,
    VoidCallback tambah,
    VoidCallback kurang,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Rp $harga"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: kurang,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(qty.toString()),
                IconButton(
                  onPressed: tambah,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
