// import 'package:app_vote/candidates_page.dart';
// import 'package:app_vote/electionList.dart';
// import 'package:flutter/material.dart';

// import 'auth_page.dart';

// class PhoneNumber extends StatefulWidget {
//   @override
//   State<PhoneNumber> createState() => _PhoneNumberState();
// }

// class _PhoneNumberState extends State<PhoneNumber> {
//   int _selectedIndex = 0;
//   void _navigationBottomNavbar(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   final List _children = [
//     AuthPage(),
//     ElectionList(),
//     // CandidatesPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.indigo,
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         title: Text(
//           "B-Voter",
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: _children[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _selectedIndex,
//           onTap: _navigationBottomNavbar,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.black,
//           unselectedItemColor: Colors.grey,
//           showUnselectedLabels: false,
//           showSelectedLabels: false,
//           elevation: 5.9,
//           items: [
//             BottomNavigationBarItem(
//                 backgroundColor: Colors.indigo,
//                 icon: Icon(
//                   Icons.phone_android_sharp,
//                 ),
//                 label: "OTP"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.list_alt_rounded), label: "ElectionList"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.list_sharp), label: "CandidateList"),
//             BottomNavigationBarItem(icon: Icon(Icons.check), label: "Result"),
//           ]),
//     );
//   }
// }
