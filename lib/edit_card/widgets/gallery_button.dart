import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thinkland_task/edit_card/bloc/edit_card_bloc.dart';

Future<List<int>?> getImageBytesFromGallery() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);

  return await picked?.readAsBytes();
}

class GalleryButton extends StatelessWidget {
  const GalleryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        context.read<EditCardBloc>().add(
          BackgroundImageChanged(
            backGroundImage: await getImageBytesFromGallery(),
          ),
        );
      },
      child: Text('or upload from gallery'),
    );
  }
}
