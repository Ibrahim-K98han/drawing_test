// import 'package:drawing_test/next.dart';
// import 'package:drawing_test/signature.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() => runApp(
//     GetMaterialApp(
//       home:  HomePage(),
//       debugShowCheckedModeBanner: false,
//     ));
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => new _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<Offset> points = <Offset>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             Positioned(
//               child: GestureDetector(
//                 onPanUpdate: (DragUpdateDetails details) {
//                   setState(() {
//                     RenderBox? renderBox =
//                     context.findRenderObject() as RenderBox;
//                     Offset _localPosition =
//                     renderBox.globalToLocal(details.globalPosition);
//                     points = List.from(points)..add(_localPosition);
//                   });
//                 },
//                 onPanEnd: (DragEndDetails details) =>
//                     points.add(Offset(double.infinity, double.infinity)),
//                 child: CustomPaint(
//                   painter: Signature(points: points),
//                   size: Size.infinite,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 200,
//               left: 80,
//               height: 200,
//               width: 200,
//               child: Container(
//                 width: 250,
//                 height: 250,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black,
//                     width: 2
//                   )
//                 ),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 500.0,left: 25),
//                 child: Row(
//                   children: [
//                     ElevatedButton(onPressed: ()=>points.clear(), child: Row(
//                       children: const [
//                         Text('Clear'),
//                         Icon(Icons.clear),
//                       ],
//                     )),
//                     const SizedBox(width: 20,),
//                     ElevatedButton(onPressed: (){}, child: Row(
//                       children: const [
//                         Text('Save'),
//                         Icon(Icons.save),
//                       ],
//                     )),
//                     const SizedBox(width: 20,),
//                     ElevatedButton(
//                         onPressed: ()=>Get.to(Next()), child: Row(
//                       children: const [
//                         Text('Next'),
//                         Icon(Icons.navigate_next),
//                       ],
//                     )),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//




import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This key will be associated with the amber box
  final GlobalKey _key = GlobalKey();

  // Coordinates
  double? _x, _y;

  // This function is called when the user presses the floating button
  void _getOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      setState(() {
        _x = position.dx;
        _y = position.dy;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing'),
      ),
      body: Center(
        child: Stack(children: [
          Positioned(
            top: 100,
            left: 25,
            // The amber box
            child: Container(
              key: _key,
              width: 200,
              height: 300,
              padding: const EdgeInsets.all(30),
              color: Colors.amber,
              child: Text(
                _x != null
                    ? "X: $_x, \nY: $_y"
                    : 'Press the button to calculate',
                style: const TextStyle(fontSize: 24),
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
