import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF8F9FB),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Encabezado
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  radius: 24,
                  backgroundImage: AssetImage('assets/icons/barber-icon.png'),
                ),
                const SizedBox(width: 12),
                Text(
                  "Hola,\nJohn Nicolas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.search,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Servicios principales
            Text(
              "Servicios principales",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 14),
            const SizedBox(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _ServiceIcon(icon: Icons.content_cut, label: "Corte"),
                    _ServiceIcon(icon: Icons.cut, label: "Barba"),
                    _ServiceIcon(icon: Icons.shower, label: "Shampoo"),
                    _ServiceIcon(icon: Icons.face, label: "Afeitado"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Barberos destacados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Barberos destacados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Text("Ver todos", style: TextStyle(color: Colors.amber)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _ArtistCard(
                    name: "Polash Miya",
                    rating: 4.8,
                    image: 'assets/images/barber1.jpg',
                    color: Colors.brown,
                  ),
                  _ArtistCard(
                    name: "Lamine Yamal",
                    rating: 4.7,
                    image: 'assets/images/barber2.jpg',
                    color: Colors.black87,
                  ),
                  _ArtistCard(
                    name: "Sergio Ramos",
                    rating: 4.5,
                    image: 'assets/images/barber3.jpg',
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Barberías cercanas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Barberías cercanas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Text("Ver todo", style: TextStyle(color: Colors.amber)),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _SalonCard(image: 'assets/images/salon-img1.jpg'),
                  _SalonCard(image: 'assets/images/salon-img2.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalonCard extends StatelessWidget {
  final String image;

  const _SalonCard({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

class _ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServiceIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: Icon(icon, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ArtistCard extends StatelessWidget {
  final String name;
  final double rating;
  final String image;
  final Color color;

  const _ArtistCard({
    required this.name,
    required this.rating,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              Text(
                rating.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
