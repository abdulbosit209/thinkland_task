import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:card_repository/card_repository.dart';
import 'package:flutter/material.dart';

extension CardNumberFormatter on String {
  /// Formats: 1234567891 => 1234 5678 7891
  String _formatAsCardNumber() {
    final digitsOnly = replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      if ((i + 1) % 4 == 0 && i != digitsOnly.length - 1) {
        buffer.write(' ');
      }
    }

    return buffer.toString();
  }

  /// Formats: 1229 => 12/29
  String _formatAsExpiryDate() {
    final digitsOnly = replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 4) return this;

    return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2, 4)}';
  }
}

class PlasticCard extends StatelessWidget {
  const PlasticCard({
    required this.cardNumber,
    required this.expiryDate,
    this.gradient,
    this.image,
    this.ontap,
    this.cardHolder,
    this.blur,
    super.key,
  });

  final String cardNumber;
  final String? cardHolder;
  final String expiryDate;
  final List<int>? image;
  final double? blur;
  final GradientModel? gradient;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth * 0.9;
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    offset: Offset(0, 8),
                  ),
                ],
                gradient: gradient != null
                    ? LinearGradient(
                        colors: gradient!.colors
                            .map((color) => Color(color))
                            .toList(),
                      )
                    : null,
              ),
              margin: const EdgeInsets.all(8),
              width: cardWidth,
              height: 200,
              child: Stack(
                children: [
                  // Background image
                  if (image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        Uint8List.fromList(image!),
                        fit: BoxFit.cover,
                        width: cardWidth,
                        height: 200,
                      ),
                    ),

                  // Blur layer
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(
                        sigmaX: blur ?? 0,
                        sigmaY: blur ?? 0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: cardWidth,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.credit_card,
                                color: Colors.white,
                                size: 40,
                              ),
                              const Spacer(),
                              Text(
                                cardNumber._formatAsCardNumber(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    expiryDate._formatAsExpiryDate(),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: cardWidth / 2.5),
                                ],
                              ),
                              if (cardHolder != null)
                                Text(
                                  cardHolder!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
