import 'package:flutter/material.dart';

void main() => runApp( MaterialApp(
      home:  HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    RenderBox? renderBox =
                    context.findRenderObject() as RenderBox;
                    Offset _localPosition =
                    renderBox.globalToLocal(details.globalPosition);
                    _points = List.from(_points)..add(_localPosition);
                  });
                },
                onPanEnd: (DragEndDetails details) =>
                    _points.add(Offset(double.infinity, double.infinity)),
                child: CustomPaint(
                  painter: Signature(points: _points),
                  size: Size.infinite,
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 80,
              height: 200,
              width: 200,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2
                  )
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 500.0,left: 25),
                child: Row(
                  children: [
                    ElevatedButton(onPressed: ()=>_points.clear(), child: Row(
                      children: const [
                        Text('Clear'),
                        Icon(Icons.clear),
                      ],
                    )),
                    const SizedBox(width: 20,),
                    ElevatedButton(onPressed: ()=>_points.clear(), child: Row(
                      children: const [
                        Text('Save'),
                        Icon(Icons.save),
                      ],
                    )),
                    const SizedBox(width: 20,),
                    ElevatedButton(onPressed: ()=>_points.clear(), child: Row(
                      children: const [
                        Text('Next'),
                        Icon(Icons.navigate_next),
                      ],
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset>? points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points!.length - 1; i++) {
      if (points![i] != null && points![i + 1] != null) {
        canvas.drawLine(points![i], points![i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
