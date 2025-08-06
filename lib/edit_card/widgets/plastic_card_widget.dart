import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:thinkland_task/edit_card/bloc/edit_card_bloc.dart';

class PlasticCard extends StatefulWidget {
  const PlasticCard({super.key});

  @override
  State<PlasticCard> createState() => _PlasticCardState();
}

class _PlasticCardState extends State<PlasticCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCardBloc, EditCardState>(
      buildWhen: (previous, current) =>
          !(previous.cardNumber != current.cardNumber) &&
          !(previous.cardExpirationDate != current.cardExpirationDate),
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth * .9;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    offset: Offset(0, 8),
                  ),
                ],
                gradient: state.gradient != null
                    ? LinearGradient(
                        colors: state.gradient!.colors
                            .map((color) => Color(color))
                            .toList(),
                      )
                    : null,
              ),
              width: cardWidth,
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (state.backGroundImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 3.0,
                        child: Image.memory(
                          Uint8List.fromList(state.backGroundImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if ((state.blurAmount ?? 0) > 0)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(
                            sigmaX: state.blurAmount!,
                            sigmaY: state.blurAmount!,
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 40,
                        ),
                        const Spacer(),
                        _CardNumberField(),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Spacer(),
                            SizedBox(width: cardWidth / 3, child: _ThruField()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ThruField extends StatefulWidget {
  const _ThruField();

  @override
  State<_ThruField> createState() => _ThruFieldState();
}

class _ThruFieldState extends State<_ThruField> {
  final maskFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {'#': RegExp('[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCardBloc>().state;

    return TextFormField(
      initialValue: maskFormatter.maskText(state.cardExpirationDate.value),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: const TextStyle(color: Colors.white70, fontSize: 14),
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        hintText: 'MM/YY',
        hintStyle: const TextStyle(color: Colors.white54),
        errorText: state.cardExpirationDate.displayError?.errorText(),
        border: InputBorder.none,
        isDense: true,
      ),
      keyboardType: TextInputType.datetime,
      onChanged: (cardExpirationDate) => context.read<EditCardBloc>().add(
        ValidThruChanged(validThru: maskFormatter.getUnmaskedText()),
      ),
    );
  }
}

class _CardNumberField extends StatefulWidget {
  const _CardNumberField();

  @override
  State<_CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<_CardNumberField> {
  final maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {'#': RegExp('[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCardBloc>().state;
    return TextFormField(
      initialValue: maskFormatter.maskText(state.cardNumber.value),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      inputFormatters: [maskFormatter],
      readOnly: state.status.isLoadingOrSuccess,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: '1234 5678 9012 3456',
        hintStyle: const TextStyle(color: Colors.white54),
        errorText: state.cardNumber.displayError?.errorText(),
        border: InputBorder.none,
        isDense: true,
      ),
      keyboardType: TextInputType.number,
      onChanged: (cardNumber) => context.read<EditCardBloc>().add(
        CardNumberChanged(cardNumber: maskFormatter.getUnmaskedText()),
      ),
    );
  }
}
