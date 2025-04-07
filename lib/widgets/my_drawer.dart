import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:glitch_ai/constants/colors.dart';
// import 'package:glitch_ai/constants/images.dart';
import 'package:glitch_ai/screens/authentication/welcome_screen.dart';

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({super.key});

//   @override
//   _MyDrawerState createState() => _MyDrawerState();
// }

// class _MyDrawerState extends State<MyDrawer> {
//   String? _username;
//   String? _profileImageUrl;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _database = FirebaseDatabase.instance.ref().child('User');

//   @override
//   void initState() {
//     super.initState();
//     _getUserInfo();
//   }

//   // Fetch the username and profile picture of the logged-in user
//   Future<void> _getUserInfo() async {
//     User? user = _auth.currentUser;

//     if (user != null) {
//       if (user.displayName != null && user.displayName!.isNotEmpty) {
//         setState(() {
//           _username = user.displayName;
//           _profileImageUrl = user.photoURL;
//         });
//       } else {
//         final userSnapshot = await _database.child(user.uid).get();
//         if (userSnapshot.exists) {
//           setState(() {
//             _username = userSnapshot.child('username').value.toString();
//             _profileImageUrl = null;
//           });
//         }
//       }
//     }
//   }

//   // Show confirmation dialog before logging out
//   Future<void> _showLogoutDialog() async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.grey.shade900,
//           title: const Text(
//             'Are you sure you want to sign out?',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: const Text(
//             'You will be logged out from your account.',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.grey.shade800,
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: AppColors.primaryColor,
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 _auth.signOut();
//                 Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//                 (Route<dynamic> route) => false,
//               );
//               //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
//               },
//               child: const Text('Sign Out'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   // Route _createRoute(Widget child) {
//   //   return PageRouteBuilder(
//   //     pageBuilder: (context, animation, secondaryAnimation) => child,
//   //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //       const begin = Offset(0.0, 1.1);
//   //       const end = Offset.zero;
//   //       const curve = Curves.easeInOut;

//   //       var tween = Tween(
//   //         begin: begin,
//   //         end: end,
//   //       ).chain(CurveTween(curve: curve));
//   //       var offsetAnimation = animation.drive(tween);

//   //       return SlideTransition(position: offsetAnimation, child: child);
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.black,
//       child: Column(
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: Colors.transparent,
//             ),
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Text(
//                 'Your Chats',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),

//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: const [
//                 _DrawerHistoryItem(
//                   icon: Icons.code,
//                   title: 'Code tutor',
//                   subtitle: 'How to use Visual Studio',
//                 ),
//                 _DrawerHistoryItem(
//                   icon: Icons.text_fields,
//                   title: 'Text writer',
//                   subtitle: 'Healthy eating tips',
//                 ),
//                 _DrawerHistoryItem(
//                   icon: Icons.image,
//                   title: 'Image generator',
//                   subtitle: 'Dog in red plaid in house in winter',
//                 ),
//                 _DrawerHistoryItem(
//                   icon: Icons.text_fields,
//                   title: 'Text writer',
//                   subtitle: 'Best clothing combinations',
//                 ),
//               ],
//             ),
//           ),

//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade900,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 24,
//                   backgroundColor: Colors.transparent,
//                   child: ClipOval(
//                     child: _profileImageUrl != null
//                         ? Image.network(
//                             _profileImageUrl!,
//                             width: 48,
//                             height: 48,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Image.asset(
//                                 AppImages.bot,
//                                 width: 48,
//                                 height: 48,
//                                 fit: BoxFit.cover,
//                               );
//                             },
//                           )
//                         : Image.asset(
//                             AppImages.bot,
//                             width: 48,
//                             height: 48,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _username != null
//                           ? Text(
//                               _username!,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             )
//                           : const CircularProgressIndicator(),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Sign out',
//                         style: TextStyle(
//                           color: Colors.redAccent,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.logout, color: Colors.redAccent),
//                   onPressed: _showLogoutDialog,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DrawerHistoryItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;

//   const _DrawerHistoryItem({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.white.withOpacity(0.2),
//         child: Icon(icon, color: Colors.white),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: const TextStyle(color: Colors.grey),
//       ),
//       trailing: const Icon(Icons.arrow_forward, color: Colors.white),
//       onTap: () {
//         // Handle history tap
//       },
//     );
//   }
// }


class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? _username;
  String? _profileImageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('User');

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? user = _auth.currentUser;

    if (user != null) {
      if (user.displayName != null && user.displayName!.isNotEmpty) {
        setState(() {
          _username = user.displayName;
          _profileImageUrl = user.photoURL;
        });
      } else {
        final userSnapshot = await _database.child(user.uid).get();
        if (userSnapshot.exists) {
          setState(() {
            _username = userSnapshot.child('username').value.toString();
            _profileImageUrl = null;
          });
        }
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: const Text(
            'Are you sure you want to sign out?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'You will be logged out from your account.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: _profileImageUrl != null ? NetworkImage(_profileImageUrl!) : null,
                  backgroundColor: Colors.grey.shade800,
                  child: _profileImageUrl == null
                      ? Icon(Icons.person, color: Colors.white, size: 40)
                      : null,
                ),
                SizedBox(height: 10),
                Text(
                  _username ?? "Username",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text("Sign Out", style: TextStyle(color: Colors.redAccent)),
            onTap: _showLogoutDialog,
          ),
        ],
      ),
    );
  }
}

