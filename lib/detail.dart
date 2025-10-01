import 'dart:ui';
import 'package:flutter/material.dart';
import 'vehicle.dart';

class DetailPage extends StatelessWidget {
  final Vehicle vehicle;
  final String username;

  const DetailPage({super.key, required this.vehicle, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Text(
            vehicle.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.black54, blurRadius: 6, offset: Offset(1, 1))
              ],
            ),
          ),
        ),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // membungkus konten detail yang ada
                Container(
                  margin: const EdgeInsets.only(top: 70), // menggeser kotak kontennya, biar margin top turun ke bawah
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // gambar utama
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            vehicle.imageUrls.isNotEmpty
                                ? vehicle.imageUrls.first
                                : '',
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              height: 220,
                              color: Colors.grey[800],
                              child: const Icon(Icons.image,
                                  size: 80, color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // judul deskripsi
                      _buildSectionTitle("Deskripsi"),
                      const SizedBox(height: 10),
                      Text(
                        vehicle.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 20),

                      // judul info kendaraan
                      _buildSectionTitle("Info Kendaraan"),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildInfoChip(
                              Icons.settings, "Mesin: ${vehicle.engine}"),
                          _buildInfoChip(Icons.local_gas_station,
                              "Bahan Bakar: ${vehicle.fuelType}"),
                          _buildInfoChip(
                              Icons.attach_money, "Harga: ${vehicle.price}"),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // judul foto lainnya
                      _buildSectionTitle("Foto lainnya "),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: vehicle.imageUrls.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, i) {
                            final url = vehicle.imageUrls[i];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                url,
                                width: 160,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  width: 160,
                                  height: 120,
                                  color: Colors.grey[800],
                                  child: const Icon(Icons.broken_image,
                                      color: Colors.white70),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// kotak judul section
  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black45,
              blurRadius: 5,
              offset: Offset(1, 1),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, color: const Color.fromARGB(255, 2, 2, 3), size: 18),
      label: Text(text),
      backgroundColor: const Color.fromARGB(255, 16, 2, 79).withOpacity(0.3),
      labelStyle: const TextStyle(color: Color.fromARGB(255, 30, 0, 0)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
            color: const Color.fromARGB(255, 25, 66, 170).withOpacity(0.2)),
      ),
    );
  }
}
