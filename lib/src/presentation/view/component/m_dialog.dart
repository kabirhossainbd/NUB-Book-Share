// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
// import 'dart:async';
//
// void main() {
//   runApp(
//       new MaterialApp(
//           home: new Scaffold(
//             body: new CircleLoader(),
//           )
//       )
//   );
// }
//
// class CircleLoader extends StatefulWidget {
//   @override
//   _CircleLoaderState createState() => new _CircleLoaderState();
// }
//
// class _CircleLoaderState extends State<CircleLoader>
//     with TickerProviderStateMixin {
//   Animation<double> animation;
//   Animation<double> animation2;
//   Animation<double> animation3;
//   AnimationController controller;
//   AnimationController controller2;
//   AnimationController controller3;
//   int duration = 1000;
//   Widget circle = new Container(
//     height: 10.0,
//     width: 10.0,
//     decoration: new BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.grey[300],
//     ),
//   );
//
//   @override
//   initState() {
//     super.initState();
//     controller = new AnimationController(
//         duration: new Duration(milliseconds: duration), vsync: this);
//     controller2 = new AnimationController(
//         duration: new Duration(milliseconds: duration), vsync: this);
//     controller3 = new AnimationController(
//         duration: new Duration(milliseconds: duration), vsync: this);
//
//     final CurvedAnimation curve =
//     new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
//     final CurvedAnimation curve2 =
//     new CurvedAnimation(parent: controller2, curve: Curves.easeInOut);
//     final CurvedAnimation curve3 =
//     new CurvedAnimation(parent: controller3, curve: Curves.easeInOut);
//
//     animation = new Tween(begin: 0.85, end: 1.5).animate(curve)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           controller.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           controller.forward();
//         }
//       });
//     animation2 = new Tween(begin: 0.85, end: 1.5).animate(curve2)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           controller2.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           controller2.forward();
//         }
//       });
//     animation3 = new Tween(begin: 0.85, end: 1.5).animate(curve3)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           controller3.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           controller3.forward();
//         }
//       });
//
//     controller.forward();
//     new Timer(const Duration(milliseconds: 300), () {
//       controller2.forward();
//     });
//     new Timer(const Duration(milliseconds: 600), () {
//       controller3.forward();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Center(
//       child: new Container(
//         width: 100.0,
//         height: 50.0,
//         color: Colors.grey,
//         child: new Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             new ScaleTransition(scale: animation, child: circle),
//             new ScaleTransition(scale: animation2, child: circle),
//             new ScaleTransition(scale: animation3, child: circle),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class CircleLoader extends StatefulWidget {
//   @override
//   _CircleLoaderState createState() => new _CircleLoaderState();
// }
//
// class _CircleLoaderState extends State<CircleLoader>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//
//   @override
//   initState() {
//     super.initState();
//     _controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//   }
//
//   @override
//   dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   buildCircle(double delay) {
//     return new ScaleTransition(
//       scale: new TestTween(begin: .85, end: 1.5, delay: delay)
//           .animate(_controller),
//       child: new Container(
//         height: 10.0,
//         width: 10.0,
//         decoration: new BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.grey[300],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Center(
//       child: new Container(
//         width: 100.0,
//         height: 50.0,
//         color: Colors.grey,
//         child: new Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             buildCircle(.0),
//             buildCircle(.2),
//             buildCircle(.4),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TestTween extends Tween<double> {
//   final double delay;
//
//   TestTween({double begin, double end, this.delay})
//       : super(begin: begin, end: end);
//
//   @override
//   double lerp(double t) {
//     return super.lerp((sin((t - delay) * 2 * PI) + 1) / 2);
//   }
// }