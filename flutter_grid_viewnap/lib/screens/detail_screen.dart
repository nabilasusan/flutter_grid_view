import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_viewnap/models/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final Home varHome;
  const DetailScreen({super.key, required this.varHome});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteHomes = prefs.getStringList('favoriteHomes') ?? [];
    setState(() {
      _isFavorite = favoriteHomes.contains(widget.varHome.name);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteHomes = prefs.getStringList('favoriteHomes') ?? [];

    setState(() {
      if (_isFavorite) {
        favoriteHomes.remove(widget.varHome.name);
        _isFavorite = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.varHome.name} removed from favorites')));
      } else {
        favoriteHomes.add(widget.varHome.name);
        _isFavorite = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.varHome.name} added to favorites')));
      }
    });

    await prefs.setStringList('favoriteHomes', favoriteHomes);
  }

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
                      widget.varHome.imageAsset,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.varHome.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(_isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: _isFavorite ? Colors.red : null,
                      )
                    ],
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
                      Text(': ${widget.varHome.location}')
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
                      Text(': ${widget.varHome.built}')
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
                      Text(': ${widget.varHome.type}')
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
                    widget.varHome.description,
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
                    itemCount: widget.varHome.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: widget.varHome.imageUrls[index],
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