import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinkland_task/edit_card/bloc/edit_card_bloc.dart';

const String _imagePath =
    'https://flutter.github.io/assets-for-api-docs/assets/material';

Future<List<int>?> getImageBytesFromNetwork(String url) async {
  final uri = Uri.parse('$_imagePath/$url');
  final client = HttpClient();

  final request = await client.getUrl(uri);
  final response = await request.close();

  if (response.statusCode != HttpStatus.ok) return null;

  final bytes = await consolidateHttpClientResponseBytes(response);
  return bytes;
}

class ImageCaruselWidget extends StatefulWidget {
  const ImageCaruselWidget({required this.controller, super.key});

  final CarouselController controller;

  @override
  State<ImageCaruselWidget> createState() => _ImageCaruselWidgetState();
}

class _ImageCaruselWidgetState extends State<ImageCaruselWidget> {
  @override
  void initState() {
    super.initState();
    final state = context.read<EditCardBloc>().state;
    if (state.backGroundImage != null || state.gradient != null) return;
    Future.microtask(() async {
      final bytes = await getImageBytesFromNetwork(ImageInfo.values[0].url);
      if (mounted) {
        context.read<EditCardBloc>().add(
          BackgroundImageChanged(backGroundImage: bytes),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200),
      child: CarouselView.weighted(
        onTap: (index) async {
          context.read<EditCardBloc>().add(
            BackgroundImageChanged(
              backGroundImage: await getImageBytesFromNetwork(
                ImageInfo.values[index].url,
              ),
            ),
          );
        },
        controller: widget.controller,
        itemSnapping: true,
        flexWeights: const <int>[1, 7, 1],
        children: ImageInfo.values.map((ImageInfo image) {
          return HeroLayoutCard(imageInfo: image);
        }).toList(),
      ),
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({required this.imageInfo, super.key});

  final ImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 7 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage('$_imagePath/${imageInfo.url}'),
            ),
          ),
        ),
      ],
    );
  }
}

enum ImageInfo {
  image0('content_based_color_scheme_1.png'),
  image1('content_based_color_scheme_2.png'),
  image2('content_based_color_scheme_3.png'),
  image3('content_based_color_scheme_4.png'),
  image4('content_based_color_scheme_5.png'),
  image5('content_based_color_scheme_6.png');

  const ImageInfo(this.url);
  final String url;
}
