import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: GradientPickerDemo(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class GradientPickerDemo extends StatefulWidget {
  const GradientPickerDemo({super.key});

  @override
  State<GradientPickerDemo> createState() => _GradientPickerDemoState();
}

class _GradientPickerDemoState extends State<GradientPickerDemo> {
  Color _startColor = Colors.blue;
  Color _endColor = Colors.red;
  Alignment _begin = Alignment.topLeft;
  Alignment _end = Alignment.bottomRight;

  final List<Map<String, dynamic>> _directions = [
    {
      'label': 'Top → Bottom',
      'begin': Alignment.topCenter,
      'end': Alignment.bottomCenter,
    },
    {
      'label': 'Left → Right',
      'begin': Alignment.centerLeft,
      'end': Alignment.centerRight,
    },
    {
      'label': 'Diagonal ↘️',
      'begin': Alignment.topLeft,
      'end': Alignment.bottomRight,
    },
    {
      'label': 'Diagonal ↙️',
      'begin': Alignment.topRight,
      'end': Alignment.bottomLeft,
    },
  ];

  Future<Color?> _showColorDialog(Color initialColor, String title) async {
    Color selectedColor = initialColor;

    final result = await showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) => selectedColor = color,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(selectedColor),
            ),
          ],
        );
      },
    );

    return result;
  }

  Future<void> _pickGradientColors() async {
    final first = await _showColorDialog(_startColor, 'Start color');
    if (first != null) {
      final second = await _showColorDialog(_endColor, 'End color');
      if (second != null) {
        setState(() {
          _startColor = first;
          _endColor = second;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [_startColor, _endColor],
      begin: _begin,
      end: _end,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Gradient Picker')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 300,
              height: 180,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Card Preview',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickGradientColors,
              child: const Text('Pick Gradient Colors'),
            ),
            const SizedBox(height: 10),
            DropdownButton<Map<String, dynamic>>(
              value: _directions.firstWhere(
                (d) => d['begin'] == _begin && d['end'] == _end,
                orElse: () => _directions[0],
              ),
              items: _directions.map((d) {
                return DropdownMenuItem(value: d, child: Text(d['label']));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _begin = value['begin'];
                    _end = value['end'];
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
