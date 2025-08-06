import 'package:card_repository/card_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:thinkland_task/config/locator_config.dart';
import 'package:thinkland_task/fetch_cards/bloc/fetch_cards_bloc.dart';
import 'package:thinkland_task/fetch_cards/widgets/card_widget.dart';

class FetchAllCardsPage extends StatelessWidget {
  const FetchAllCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          FetchCardsBloc(cardRepository: locator<CardRepository>())
            ..add(CardsOverviewSubscriptionRequested()),
      child: _FetchAllCardsView(),
    );
  }
}

class _FetchAllCardsView extends StatelessWidget {
  const _FetchAllCardsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mening kartalarim')),
      body: BlocConsumer<FetchCardsBloc, FetchCardsState>(
        listenWhen: (previous, current) =>
            previous.status != current.status && current.status.isFailure,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('Fetch cards exception')));
        },
        builder: (context, state) {
          if (state.cards.isEmpty) {
            if (state.status == FetchCardsStatus.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state.status != FetchCardsStatus.success) {
              return const SizedBox();
            } else {
              return Center(
                child: Text(
                  'Karta qo\'shing',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }
          }

          return CupertinoScrollbar(
            child: ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (context, index) => PlasticCard(
                ontap: () => locator<RouterService>().goTo(
                  Path(name: '/edit_card', extra: state.cards[index]),
                ),
                cardHolder: 'John Doe',
                image: state.cards[index].backGroundImage,
                cardNumber: state.cards[index].cardNumber,
                expiryDate: state.cards[index].validThru,
                blur: state.cards[index].blurAmount,
                gradient: state.cards[index].gradient,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          locator<RouterService>().goTo(Path(name: '/edit_card'));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
