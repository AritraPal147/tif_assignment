import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/constants/constants.dart';
import 'package:tif_assignment/events/bloc/events_bloc.dart';

import '../widgets/events_list_item.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        switch (state.status) {
          case EventsStatus.failure:
            return const Center(child: Text(Constants.failureText));
          case EventsStatus.success:
            if (state.data.isEmpty) {
              return const Center(child: Text(Constants.noPostsText));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == state.data.length) {
                  return const SizedBox();
                } else if (index < state.data.length) {
                  return EventsListItem(model: state.data[index]);
                }
                return null;
              },
              itemCount: state.hasReachedMax
                  ? state.data.length
                  : state.data.length + 1,
              controller: _scrollController,
            );
          case EventsStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<EventsBloc>().add(EventsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
