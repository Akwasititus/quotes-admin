

























import 'package:adminquote/post_request.dart';
import 'package:adminquote/view_created_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _quoteController.dispose();
    super.dispose();
  }

  clearAll() {
    _quoteController.clear();
    _authorController.clear();
  }

  // String getGreeting() {
  //   final currentHour = DateTime.now().hour;
  //
  //   if (currentHour >= 5 && currentHour < 12) {
  //     return 'Good Morning';
  //   } else if (currentHour >= 12 && currentHour < 17) {
  //     return 'Good Afternoon';
  //   } else {
  //     return 'Good evening';
  //   }
  // }


  String getGreeting() {
    final currentHour = DateTime.now().hour;
    if (currentHour >= 5 && currentHour < 12) {
      return 'Good Morning';
    } else if (currentHour >= 12 && currentHour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String getGreetingEmoji() {
    final currentHour = DateTime.now().hour;
    if (currentHour >= 5 && currentHour < 12) {
      return '☀️';
    } else if (currentHour >= 12 && currentHour < 17) {
      return '🌤️';
    } else {
      return '🌙';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: UpgradeAlert(
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/bg-wallpepper.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.amber.withValues(alpha: 0.3),
                              Colors.orange.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.2),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              getGreetingEmoji(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${getGreeting()}, Pastor",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Text(
                      //   "${getGreeting()}, Pastor",
                      //   style: const TextStyle(
                      //       fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                      // ),
                      const Text(
                        "What do you have for us today?",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w100, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        child:
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                maxLines: 10,
                                controller: _quoteController,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  hintText: 'Enter Quote here...',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a quote';
                                  }
                                  // Split the input by whitespace to get the words
                                  List<String> words = value.trim().split(RegExp(r'\s+'));
                                  if (words.length > 100) {
                                    return 'The quote should not exceed 100 words.';
                                  }
                                  return null;
                                },
                              ),
                              const Divider(),
                              const SizedBox(height: 16),
                              Container(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    controller: _authorController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Who's the Author",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the author\'s name';
                                      }
                                      return null;
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            // Creating user registration mapData
                            final Map<String, dynamic> quoteData = {
                              "quote": _quoteController.text,
                              "author": _authorController.text,
                              'createdAt': FieldValue.serverTimestamp(),
                            };
                            _quoteController.clear();
                            _authorController.clear();
                            await PostQuote.createPost(quoteData);
                          }
                        },
                        child: const Text('Create Post'),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          bottomNavigationBar: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuotesListPage()),
              );
            },
            child: const Text("View Created Post"),
          )),
    );
  }
}

//
//
// import 'package:adminquote/post_request.dart';
// import 'package:adminquote/view_created_post.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:upgrader/upgrader.dart';
//
// class Admin extends StatefulWidget {
//   const Admin({super.key});
//
//   @override
//   _AdminState createState() => _AdminState();
// }
//
// class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
//   final TextEditingController _quoteController = TextEditingController();
//   final TextEditingController _authorController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
//       ),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.4),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
//       ),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
//       ),
//     );
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _quoteController.dispose();
//     _authorController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   String getGreeting() {
//     final currentHour = DateTime.now().hour;
//     if (currentHour >= 5 && currentHour < 12) {
//       return 'Good Morning';
//     } else if (currentHour >= 12 && currentHour < 17) {
//       return 'Good Afternoon';
//     } else {
//       return 'Good Evening';
//     }
//   }
//
//   String getGreetingEmoji() {
//     final currentHour = DateTime.now().hour;
//     if (currentHour >= 5 && currentHour < 12) {
//       return '☀️';
//     } else if (currentHour >= 12 && currentHour < 17) {
//       return '🌤️';
//     } else {
//       return '🌙';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: UpgradeAlert(
//           child: Stack(
//             children: [
//               // Background Image
//               Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('asset/bg-wallpepper.jpeg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//
//               // Gradient Overlay
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.4),
//                       Colors.black.withOpacity(0.7),
//                       Colors.black.withOpacity(0.85),
//                     ],
//                     stops: const [0.0, 0.5, 1.0],
//                   ),
//                 ),
//               ),
//
//               // Main Content
//               SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 24.0),
//                   child: Column(
//                     children: [
//                       // Header Section with Animation
//                       FadeTransition(
//                         opacity: _fadeAnimation,
//                         child: SlideTransition(
//                           position: _slideAnimation,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Time-based Badge
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 8,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Colors.amber.withOpacity(0.3),
//                                       Colors.orange.withOpacity(0.2),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(24),
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.4),
//                                     width: 1.5,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.amber.withOpacity(0.2),
//                                       blurRadius: 12,
//                                       spreadRadius: 2,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       getGreetingEmoji(),
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       getGreeting(),
//                                       style: const TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white,
//                                         letterSpacing: 0.8,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 20),
//
//                               // Main Title
//                               ShaderMask(
//                                 shaderCallback: (bounds) => LinearGradient(
//                                   colors: [
//                                     Colors.white,
//                                     Colors.white.withOpacity(0.9),
//                                   ],
//                                 ).createShader(bounds),
//                                 child: const Text(
//                                   "Pastor",
//                                   style: TextStyle(
//                                     fontSize: 42,
//                                     fontWeight: FontWeight.w900,
//                                     color: Colors.white,
//                                     height: 1.1,
//                                     letterSpacing: -0.5,
//                                   ),
//                                 ),
//                               ),
//
//                               const SizedBox(height: 10),
//
//                               // Subtitle
//                               Text(
//                                 "What inspiring words do you have for us today?",
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.white.withOpacity(0.85),
//                                   letterSpacing: 0.2,
//                                   height: 1.4,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 50),
//
//                       // Form Container with Enhanced Glassmorphism
//                       ScaleTransition(
//                         scale: _scaleAnimation,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(32.0),
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Colors.white.withOpacity(0.15),
//                                 Colors.white.withOpacity(0.08),
//                               ],
//                             ),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.3),
//                               width: 2,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.3),
//                                 blurRadius: 30,
//                                 spreadRadius: 5,
//                               ),
//                               BoxShadow(
//                                 color: Colors.white.withOpacity(0.1),
//                                 blurRadius: 10,
//                                 spreadRadius: -5,
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(32.0),
//                             child: Container(
//                               padding: const EdgeInsets.all(28.0),
//                               child: Form(
//                                 key: _formKey,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Quote Section
//                                     Row(
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.15),
//                                             borderRadius: BorderRadius.circular(12),
//                                           ),
//                                           child: const Icon(
//                                             Icons.format_quote_rounded,
//                                             color: Colors.white,
//                                             size: 24,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 12),
//                                         const Text(
//                                           "YOUR QUOTE",
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w700,
//                                             color: Colors.white,
//                                             letterSpacing: 1.8,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//                                     // Quote Input Field
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.black.withOpacity(0.2),
//                                         borderRadius: BorderRadius.circular(20.0),
//                                         border: Border.all(
//                                           color: Colors.white.withOpacity(0.15),
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       child: TextFormField(
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           height: 1.6,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         maxLines: 8,
//                                         controller: _quoteController,
//                                         decoration: InputDecoration(
//                                           border: InputBorder.none,
//                                           contentPadding: const EdgeInsets.all(20),
//                                           hintText: 'Share your inspirational message...',
//                                           hintStyle: TextStyle(
//                                             color: Colors.white.withOpacity(0.35),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return '📝 Please enter a quote';
//                                           }
//                                           List<String> words = value.trim().split(RegExp(r'\s+'));
//                                           if (words.length > 100) {
//                                             return '⚠️ Quote should not exceed 100 words';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//
//                                     const SizedBox(height: 28),
//
//                                     // Author Section
//                                     Row(
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.15),
//                                             borderRadius: BorderRadius.circular(12),
//                                           ),
//                                           child: const Icon(
//                                             Icons.person_outline_rounded,
//                                             color: Colors.white,
//                                             size: 24,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 12),
//                                         const Text(
//                                           "AUTHOR",
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w700,
//                                             color: Colors.white,
//                                             letterSpacing: 1.8,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//                                     // Author Input Field
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.black.withOpacity(0.2),
//                                         borderRadius: BorderRadius.circular(20.0),
//                                         border: Border.all(
//                                           color: Colors.white.withOpacity(0.15),
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       child: TextFormField(
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         controller: _authorController,
//                                         decoration: InputDecoration(
//                                           border: InputBorder.none,
//                                           contentPadding: const EdgeInsets.all(20),
//                                           hintText: "Who's the author?",
//                                           hintStyle: TextStyle(
//                                             color: Colors.white.withOpacity(0.35),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return '✍️ Please enter the author\'s name';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 32),
//
//                       // Create Post Button
//                       Container(
//                         width: double.infinity,
//                         height: 62,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           gradient: const LinearGradient(
//                             colors: [Colors.white, Color(0xFFF0F0F0)],
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.white.withOpacity(0.4),
//                               blurRadius: 20,
//                               spreadRadius: 2,
//                               offset: const Offset(0, 8),
//                             ),
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               blurRadius: 15,
//                               spreadRadius: -5,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               final Map<String, dynamic> quoteData = {
//                                 "quote": _quoteController.text,
//                                 "author": _authorController.text,
//                                 'createdAt': FieldValue.serverTimestamp(),
//                               };
//
//                               _quoteController.clear();
//                               _authorController.clear();
//
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Row(
//                                     children: [
//                                       const CircularProgressIndicator(
//                                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                         strokeWidth: 2,
//                                       ),
//                                       const SizedBox(width: 16),
//                                       const Text('Creating your post...'),
//                                     ],
//                                   ),
//                                   backgroundColor: Colors.black.withOpacity(0.8),
//                                   behavior: SnackBarBehavior.floating,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   margin: const EdgeInsets.all(16),
//                                 ),
//                               );
//
//                               await PostQuote.createPost(quoteData);
//
//                               if (context.mounted) {
//                                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: const Row(
//                                       children: [
//                                         Icon(Icons.check_circle, color: Colors.white),
//                                         SizedBox(width: 12),
//                                         Text('Post created successfully! ✨'),
//                                       ],
//                                     ),
//                                     backgroundColor: Colors.green.withOpacity(0.9),
//                                     behavior: SnackBarBehavior.floating,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     margin: const EdgeInsets.all(16),
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.transparent,
//                             foregroundColor: Colors.black87,
//                             elevation: 0,
//                             shadowColor: Colors.transparent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(Icons.send_rounded, size: 22),
//                               const SizedBox(width: 12),
//                               const Text(
//                                 'Create Post',
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w700,
//                                   letterSpacing: 0.3,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 120),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         // Enhanced Bottom Navigation
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.transparent,
//                 Colors.black.withOpacity(0.6),
//                 Colors.black.withOpacity(0.8),
//               ],
//             ),
//             border: Border(
//               top: BorderSide(
//                 color: Colors.white.withOpacity(0.15),
//                 width: 1.5,
//               ),
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
//               child: Container(
//                 height: 58,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(18),
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white.withOpacity(0.12),
//                       Colors.white.withOpacity(0.08),
//                     ],
//                   ),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.25),
//                     width: 1.5,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 15,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const QuotesListPage(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.grid_view_rounded, size: 22),
//                       const SizedBox(width: 10),
//                       const Text(
//                         'View Created Posts',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 0.3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }