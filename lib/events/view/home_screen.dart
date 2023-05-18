import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/constants/constants.dart';
import 'package:tif_assignment/events/bloc/events_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tif_assignment/events/models/size_config.dart';

import 'events_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical * 10),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Constants.events,
                  style: TextStyle(
                    color: Constants.blackTextColor,
                    fontSize: SizeConfig.blockSizeVertical * 2.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      // TODO: Implement onPressed
                      onPressed: null,
                      icon: Icon(
                        Icons.search,
                        color: Constants.blackTextColor,
                        size: SizeConfig.blockSizeVertical * 2.5,
                      ),
                    ),
                    IconButton(onPressed: null, icon: Icon(
                      Icons.more_vert,
                      color: Constants.blackTextColor,
                      size: SizeConfig.blockSizeVertical * 2.5,
                    ),)
                  ],
                )
              ],
            ),
          ),
        ),
        body: BlocProvider(
          create: (_) =>
              EventsBloc(httpClient: http.Client())..add(EventsFetched()),
          child: const EventsList(),
        ),
      ),
    );
  }
}
