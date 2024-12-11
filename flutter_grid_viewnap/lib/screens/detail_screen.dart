import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_viewnap/models/home.dart';

class DetailScreen extends StatelessWidget {
  final Home varHome;
  const DetailScreen({super.key, required this.varHome});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // ---------------- ATAS ------------------
            Stack(
              children: [
                // Image Utama
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      varHome.imageAsset,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                ),
                // Tombol Back
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                )
              ],
            ),
            const SizedBox(height: 16),
            // Di bawahnya Image Utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Judul
                  Text(
                    varHome.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Info lainnya
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text('Lokasi',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(': ${varHome.location}')
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text('Dibangun',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(': ${varHome.built}')
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.house,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text('Tipe',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(': ${varHome.type}')
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: Colors.deepPurple.shade100,
                    thickness: 1,
                  ),
                  const SizedBox(height: 16),
                  // Deskripsi
                  Text(
                    varHome.description,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: Colors.deepPurple.shade100,
                    thickness: 1,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            // ---------------- BAWAH ------------------
            Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: varHome.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: varHome.imageUrls[index],
                              placeholder: (context, url) => Transform.scale(
                                scale: 0.2,
                                child: const CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  ),
                ))
          ],
        ),
      )),
    );
  }
}