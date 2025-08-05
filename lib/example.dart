import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

void main() {
  runApp(const MaterialApp(
    home: InteractiveScreenshotCardPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class InteractiveScreenshotCardPage extends StatefulWidget {
  const InteractiveScreenshotCardPage({super.key});

  @override
  State<InteractiveScreenshotCardPage> createState() => _InteractiveScreenshotCardPageState();
}

class _InteractiveScreenshotCardPageState extends State<InteractiveScreenshotCardPage> {
  final GlobalKey _repaintKey = GlobalKey();
  Uint8List? _capturedImage;
  double _blurAmount = 0.0; // 🔥 blur darajasi

  Future<void> _captureCard() async {
    try {
      RenderRepaintBoundary boundary =
          _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      setState(() {
        _capturedImage = pngBytes;
      });
    } catch (e) {
      debugPrint('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zoom, Drag, Blur & Screenshot')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            RepaintBoundary(
              key: _repaintKey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 300,
                  height: 200,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(100),
                        minScale: 0.5,
                        maxScale: 3.0,
                        child: Image.network(
                          'https://static.vecteezy.com/system/resources/previews/008/951/892/non_2x/cute-puppy-pomeranian-mixed-breed-pekingese-dog-run-on-the-grass-with-happiness-photo.jpg',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // 🔥 BLUR OVERLAY
                      if (_blurAmount > 0)
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                              sigmaX: _blurAmount,
                              sigmaY: _blurAmount,
                            ),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),

                      // TEXT
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            '1234 5678 9012 3456',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [Shadow(blurRadius: 2)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔧 BLUR SLIDER
            Column(
              children: [
                const Text("Blur darajasi:"),
                Slider(
                  value: _blurAmount,
                  min: 0.0,
                  max: 10.0,
                  divisions: 20,
                  label: _blurAmount.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _blurAmount = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _captureCard,
              child: const Text("Screenshot olish"),
            ),
            const SizedBox(height: 20),
            if (_capturedImage != null) ...[
              const Text("Yakuniy holat:"),
              const SizedBox(height: 10),
              Image.memory(_capturedImage!, width: 300),
            ]
          ],
        ),
      ),
    );
  }
}