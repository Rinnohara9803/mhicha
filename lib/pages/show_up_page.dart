// import 'package:flutter/material.dart';

// class ShowUpPage extends StatefulWidget {
//   const ShowUpPage({Key? key}) : super(key: key);

//   @override
//   State<ShowUpPage> createState() => _ShowUpPageState();
// }

// class _ShowUpPageState extends State<ShowUpPage> {
//   int page = 1;
//   final _pageController = PageController();
//   List<Widget> widgets = [
//     // list of pages I'll be scrolling through
//     new Center(child: Text("Page 1", style: TextStyle(fontSize: 50))),
//     new Center(child: Text("Page 2", style: TextStyle(fontSize: 50))),
//     new Center(child: Text("Page 3", style: TextStyle(fontSize: 50))),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               flex: 5,
//               child: PageView(
//                   children: widgets,
//                   controller: _pageController,
//                   onPageChanged: (num) {
//                     setState(() {
//                       page = num;
//                     });
//                   }),
//             ),
//             Expanded(
//               flex: 1,
//               child: Container(
//                 color: Colors.white,
//                 child: Column(children: [
                  
//                 ],),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
