import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinkland_task/edit_card/bloc/edit_card_bloc.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCardBloc>().state;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 56)),
        icon: state.status.isLoadingOrSuccess
            ? CircularProgressIndicator.adaptive()
            : null,
        onPressed: state.isValid
            ? () {
                context.read<EditCardBloc>().add(Submit());
              }
            : null,
        label: const Text("Submit"),
      ),
    );
  }
}
