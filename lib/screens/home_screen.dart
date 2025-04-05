import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with menu and premium button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.015,
                        ),
                        textStyle: TextStyle(
                          fontSize: size.width * 0.035,
                        ),
                      ),
                      child: const Text('Try premium'),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                // Tagline
                Text(
                  'Create, explore,\nbe inspired',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(height: size.height * 0.02),
                // AI Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                        context,
                        'AI text writer',
                        () {},
                        size,
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: _buildButton(
                        context,
                        'AI image generator',
                        () {},
                        size,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                // History Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See all',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: const [
                      HistoryItem(
                        icon: Icons.code,
                        title: 'Code tutor',
                        subtitle: 'How to use Visual Studio',
                      ),
                      HistoryItem(
                        icon: Icons.text_fields,
                        title: 'Text writer',
                        subtitle: 'Healthy eating tips',
                      ),
                      HistoryItem(
                        icon: Icons.image,
                        title: 'Image generator',
                        subtitle: 'Dog in red plaid in house in winter',
                      ),
                      HistoryItem(
                        icon: Icons.text_fields,
                        title: 'Text writer',
                        subtitle: 'Best clothing combinations',
                      ),
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

  Widget _buildButton(BuildContext context, String title, VoidCallback onTap, Size size) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const HistoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple.withOpacity(0.3),
            child: Icon(icon, color: Colors.white, size: size.width * 0.06),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.width * 0.035,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    );
  }
}
