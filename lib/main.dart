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

import 'package:drawing_test/signature.dart';
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
  final GlobalKey _key = GlobalKey();
  List<Offset> points = <Offset>[];

  double? _x, _y;

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
        // body: Center(
        //   child: Stack(children: [
        //     Positioned(
        //       top: 100,
        //       left: 25,
        //       // The amber box
        //       child: Container(
        //         key: _key,
        //         width: 200,
        //         height: 300,
        //         padding: const EdgeInsets.all(30),
        //         color: Colors.amber,
        //         child: Text(
        //           _x != null
        //               ? "X: $_x, \nY: $_y"
        //               : 'Press the button to calculate',
        //           style: const TextStyle(fontSize: 24),
        //         ),
        //       ),
        //     ),
        //   ]),
        // ),
        body: Stack(children: <Widget>[
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
              child: CustomPaint(
                painter: Signature(points: points),
                size: Size.infinite,
              ),
            ),
          ),
          Positioned(
            key: _key,
            top: 200,
            left: 60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: Text(
                _x != null
                    ? "X: $_x, \nY: $_y"
                    : 'Press the button to calculate',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 500.0, left: 25),
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () => points.clear(),
                        child: Row(
                          children: const [
                            Text('Clear'),
                            Icon(Icons.clear),
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () => _getOffset(_key),
                        child: Row(
                          children: const [
                            Text('calculate'),
                            Icon(Icons.clear),
                          ],
                        )),
                    // floatingActionButton: FloatingActionButton(
                    //     onPressed: () => _getOffset(_key),
                    //     child: const Icon(Icons.calculate)),
                  ])))
        ]));
  }
}














//
// import 'package:flutter/material.dart';
// import 'package:rect_getter/rect_getter.dart';
//
// void main() {
//   runApp(MaterialApp(home: MyApp()));
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   var globalKey1 = RectGetter.createGlobalKey(),
//       globalKey2 = RectGetter.createGlobalKey(),
//       globalKey3 = RectGetter.createGlobalKey(),
//       globalKey4 = RectGetter.createGlobalKey(),
//       globalKey5 = RectGetter.createGlobalKey();
//
//   showOverlayDot(BuildContext context,
//       double left, double top) async {
//     OverlayState overlayState = Overlay.of(context);
//     OverlayEntry overlayEntry;
//     overlayEntry = OverlayEntry(builder: (context) {
//       return Positioned(
//           left: left,
//           top: top,
//           child: Icon(
//             Icons.circle,
//             color: Colors.red,
//           ));
//     });
//
//     overlayState.insert(overlayEntry);
//     await Future.delayed(Duration(seconds: 2));
//     overlayEntry.remove();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black26,
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Center(
//           child: Text(
//             'GeeksForGeeks',
//             style: TextStyle(color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Flexible(
//                       child: RectGetter(
//                         key: globalKey1,
//                         child: GestureDetector(
//                           onTap: () {
//                             Rect rect = RectGetter.getRectFromKey(globalKey1);
//                             var left = rect.left;
//                             var top = rect.top;
//                             var right = rect.right;
//                             var bottom = rect.bottom;
//
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 backgroundColor: Colors.green,
//                                 content: Text(
//                                   'LTRB :($left, $top, $right, $bottom)',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 )));
//                             showOverlayDot(this.context, left, top);
//                           },
//                           child: Icon(
//                             Icons.message_outlined,
//                             color: Colors.white,
//                             size: 70,
//                           ),
//                         ),
//                       )),
//                   Flexible(
//                       child: RectGetter(
//                         key: globalKey2,
//                         child: GestureDetector(
//                           onTap: () {
//                             Rect rect = RectGetter.getRectFromKey(globalKey2);
//                             var left = rect.left;
//                             var top = rect.top;
//                             var right = rect.right;
//                             var bottom = rect.bottom;
//
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 backgroundColor: Colors.green,
//                                 content: Text(
//                                   'LTRB :($left, $top, $right, $bottom)',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 )));
//                             showOverlayDot(this.context, left, top);
//                           },
//                           child: Icon(
//                             Icons.message_outlined,
//                             color: Colors.white,
//                             size: 70,
//                           ),
//                         ),
//                       ))
//                 ],
//               ),
//               Flexible(
//                   child: RectGetter(
//                     key: globalKey3,
//                     child: GestureDetector(
//                       onTap: () {
//                         Rect rect = RectGetter.getRectFromKey(globalKey3);
//                         var left = rect.left;
//                         var top = rect.top;
//                         var right = rect.right;
//                         var bottom = rect.bottom;
//
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             backgroundColor: Colors.green,
//                             content: Text(
//                               'LTRB :($left, $top, $right, $bottom)',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )));
//                         showOverlayDot(this.context, left, top);
//                       },
//                       child: Icon(
//                         Icons.message_outlined,
//                         color: Colors.white,
//                         size: 120,
//                       ),
//                     ),
//                   )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Flexible(
//                       child: RectGetter(
//                         key: globalKey4,
//                         child: GestureDetector(
//                           onTap: () {
//                             Rect rect = RectGetter.getRectFromKey(globalKey4);
//                             var left = rect.left;
//                             var top = rect.top;
//                             var right = rect.right;
//                             var bottom = rect.bottom;
//
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 backgroundColor: Colors.green,
//                                 content: Text(
//                                   'LTRB :($left, $top, $right, $bottom)',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 )));
//                             showOverlayDot(this.context, left, top);
//                           },
//                           child: Icon(
//                             Icons.message_outlined,
//                             color: Colors.white,
//                             size: 70,
//                           ),
//                         ),
//                       )),
//                   Flexible(
//                       child: RectGetter(
//                         key: globalKey5,
//                         child: GestureDetector(
//                           onTap: () {
//                             Rect rect = RectGetter.getRectFromKey(globalKey5);
//                             var left = rect.left;
//                             var top = rect.top;
//                             var right = rect.right;
//                             var bottom = rect.bottom;
//
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 backgroundColor: Colors.green,
//                                 content: Text(
//                                   'LTRB :($left, $top, $right, $bottom)',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 )));
//                             showOverlayDot(this.context, left, top);
//                           },
//                           child: Icon(
//                             Icons.message_outlined,
//                             color: Colors.white,
//                             size: 70,
//                           ),
//                         ),
//                       ))
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }