import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/constants/constants.dart';
import 'package:tif_assignment/details/bloc/details_bloc.dart';
import 'package:tif_assignment/details/widgets/details_data_widget.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        switch (state.status) {
          case DetailsStatus.failure:
            return const Center(child: Text(Constants.failureText));
          case DetailsStatus.success:
            if (state.data == null) {
              return const Center(child: Text(Constants.noDataText));
            }
            return const DetailsDataWidget();
          case DetailsStatus.initial:
            if (state.data == null) {
              return const Center(child: Text(Constants.noDataText));
            }
            return const DetailsDataWidget();
            // return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
