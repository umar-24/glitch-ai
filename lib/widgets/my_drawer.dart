import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          // Optional Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Your Chats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      
          // History List
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                _DrawerHistoryItem(
                  icon: Icons.code,
                  title: 'Code tutor',
                  subtitle: 'How to use Visual Studio',
                ),
                _DrawerHistoryItem(
                  icon: Icons.text_fields,
                  title: 'Text writer',
                  subtitle: 'Healthy eating tips',
                ),
                _DrawerHistoryItem(
                  icon: Icons.image,
                  title: 'Image generator',
                  subtitle: 'Dog in red plaid in house in winter',
                ),
                _DrawerHistoryItem(
                  icon: Icons.text_fields,
                  title: 'Text writer',
                  subtitle: 'Best clothing combinations',
                ),
                // Add more as needed
              ],
            ),
          ),
      
          // Bottom User Info Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
          
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/user_avatar.png'), // Your asset image
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Sign out',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  onPressed: () {
                    // Handle sign out
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHistoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _DrawerHistoryItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.2),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.arrow_forward, color: Colors.white),
      onTap: () {
        // Handle history tap
      },
    );
  }
}
