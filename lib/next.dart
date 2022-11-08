import 'package:drawing_test/signature.dart';
import 'package:flutter/material.dart';

class Next extends StatefulWidget {
  const Next({Key? key}) : super(key: key);

  @override
  State<Next> createState() => _NextState();
}

class _NextState extends State<Next> {
  final GlobalKey _key = GlobalKey();
  List<Offset> points = <Offset>[];
  double? _x, _y;

  void _getOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? points = box?.localToGlobal(Offset.zero);
    if (points != null) {
      setState(() {
        _x = points.dx;
        _y = points.dy;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Center(
        child: Stack(children: [
          // Positioned(
          //   top: 80,
          //   left: 25,
          //   // The amber box
          //   child: Container(
          //     key: _key,
          //     width: 200,
          //     height: 200,
          //     padding: const EdgeInsets.all(30),
          //     color: Colors.amber,
          //     child: Text(
          //       _x != null
          //           ? "X: $_x, \nY: $_y"
          //           : 'Press the button to calculate',
          //       style: const TextStyle(fontSize: 24),
          //     ),
          //   ),
          // ),
          Positioned(
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox? renderBox =
                      context.findRenderObject() as RenderBox;
                  Offset _localPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  points = List.from(points)..add(_localPosition);
                });
              },
              onPanEnd: (DragEndDetails details) =>
                  points.add(Offset(double.infinity, double.infinity)),
              child: Column(
                children: [
                  CustomPaint(
                    painter: Signature(points: points),
                    size: Size.infinite,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _getOffset(_key),
          child: const Icon(Icons.calculate)),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kindacode.com',
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // This key will be associated with the amber box
//   final GlobalKey _key = GlobalKey();
//
//   // Coordinates
//   double? _x, _y;
//
//   // This function is called when the user presses the floating button
//   void _getOffset(GlobalKey key) {
//     RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
//     Offset? position = box?.localToGlobal(Offset.zero);
//     if (position != null) {
//       setState(() {
//         _x = position.dx;
//         _y = position.dy;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Center(
//         child: Stack(children: [
//           Positioned(
//             top: 100,
//             left: 25,
//             // The amber box
//             child: Container(
//               key: _key,
//               width: 200,
//               height: 300,
//               padding: const EdgeInsets.all(30),
//               color: Colors.amber,
//               child: Text(
//                 _x != null
//                     ? "X: $_x, \nY: $_y"
//                     : 'Press the button to calculate',
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ),
//           ),
//         ]),
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () => _getOffset(_key),
//           child: const Icon(Icons.calculate)),
//     );
//   }
// }
