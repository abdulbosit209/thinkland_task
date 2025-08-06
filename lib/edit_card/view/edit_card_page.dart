import 'package:card_repository/card_repository.dart';
import 'package:flutter/material.dart' hide ImageInfo;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:thinkland_task/config/locator_config.dart';
import 'package:thinkland_task/edit_card/bloc/edit_card_bloc.dart';
import 'package:thinkland_task/edit_card/widgets/widgets.dart';

class EditCardPage extends StatelessWidget {
  const EditCardPage({this.initialCard, super.key});

  final CardModel? initialCard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditCardBloc(
        cardRepository: locator<CardRepository>(),
        initialCard: initialCard,
      ),
      child: _EditCardView(),
    );
  }
}

class _EditCardView extends StatefulWidget {
  const _EditCardView();

  @override
  State<_EditCardView> createState() => _EditCardViewState();
}

class _EditCardViewState extends State<_EditCardView> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    final isNewCard = context.select(
      (EditCardBloc bloc) => bloc.state.isNewCard,
    );
    return BlocListener<EditCardBloc, EditCardState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final messanger = ScaffoldMessenger.of(context);

        if (state.status.isFailure) {
          messanger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('Edit Failure')));
        } else if (state.status.isSuccess) {
          messanger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('Successfully uploaded')));
          locator<RouterService>().back();
        }
      },
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(isNewCard ? "Qo'shish" : 'Tahrirlash'),
            actions: [
              Visibility(
                visible: !isNewCard,
                child: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ),
            ],
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.image)),
                Tab(icon: Icon(Icons.color_lens)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _ImageView(controller: controller),
              _ColorView(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({required this.controller});

  final CarouselController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        PlasticCard(),
        SizedBox(height: 8),
        ImageCaruselWidget(controller: controller),
        SizedBox(height: 8),
        GalleryButton(),
        SizedBox(height: 8),
        const Text("Blur darajasi:"),
        BlurWidget(),
        Spacer(),
        SubmitButton(),
        SizedBox(height: 20),
      ],
    );
  }
}

class _ColorView extends StatelessWidget {
  const _ColorView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        PlasticCard(),
        SizedBox(height: 8),
        const Text("Blur darajasi:"),
        BlurWidget(),
        SizedBox(height: 8),
        GradientPicker(),
        Spacer(),
        SubmitButton(),
        SizedBox(height: 20),
      ],
    );
  }
}
