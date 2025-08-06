import 'package:card_repository/card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinkland_task/edit_card/bloc/edit_card_bloc.dart';

class GradientPicker extends StatefulWidget {
  const GradientPicker({super.key});

  @override
  State<GradientPicker> createState() => _GradientPickerState();
}

class _GradientPickerState extends State<GradientPicker> {
  List<Color> selectedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  Future<void> _pickColor(int index) async {
    Color? selected = await showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: Colors.primaries.map((color) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(color),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );

    if (selected != null && mounted) {
      setState(() => selectedColors[index] = selected);
      context.read<EditCardBloc>().add(
        GradientChanged(
          gradient: GradientModel(colors: selectedColors.map((e) => e.toARGB32()).toList()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: List.generate(4, (index) {
        return GestureDetector(
          onTap: () => _pickColor(index),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: selectedColors[index],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26),
            ),
          ),
        );
      }),
    );
  }
}
