import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinkland_task/edit_card/bloc/edit_card_bloc.dart';

class BlurWidget extends StatelessWidget {
  const BlurWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final blurAmount = context.select(
      (EditCardBloc bloc) => bloc.state.blurAmount,
    );
    return Slider(
      value: blurAmount ?? 0,
      min: 0.0,
      max: 10.0,
      divisions: 20,
      label: (blurAmount ?? 0).toStringAsFixed(1),
      onChanged: (blurAmount) {
        context.read<EditCardBloc>().add(
          BlurAmountChanged(blurAmount: blurAmount),
        );
      },
    );
  }
}
