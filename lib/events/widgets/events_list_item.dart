import 'package:flutter/material.dart';
import 'package:tif_assignment/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tif_assignment/events/models/size_config.dart';

import '../models/data.dart';

class EventsListItem extends StatelessWidget {
  const EventsListItem({required this.model, super.key});

  final Data model;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        tileColor: Colors.white,
        // TODO: Implement onTap
        onTap: null,
        visualDensity: const VisualDensity(vertical: 4, horizontal: 2),
        minVerticalPadding: SizeConfig.blockSizeVertical * 1.5,
        leading: SizedBox(
          child: Image.network(
            model.bannerImage,
            scale: 0.01,
            fit: BoxFit.fill,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.dateTime,
              style: GoogleFonts.inter(
                color: Constants.blueTextColor,
                fontSize: SizeConfig.blockSizeVertical,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 0.4),
            Text(
              model.title,
              style: GoogleFonts.inter(
                fontSize: SizeConfig.blockSizeVertical * 1.3,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical,)
          ],
        ),
        isThreeLine: true,
        subtitle: Row(
          children: [
            Icon(Icons.location_on, size: SizeConfig.blockSizeVertical * 1.5, color: Constants.greyIconColor,),
            SizedBox(width: SizeConfig.blockSizeHorizontal,),
            Flexible(
              child: Text(
                '${model.venueName} • ${model.venueCity}, ${model
                    .venueCountry}',
                style: GoogleFonts.inter(
                  color: Constants.greyTextColor,
                  fontSize: SizeConfig.blockSizeVertical,
                ),
              ),
            ),
          ],
        ),
        dense: true,
      ),
    );
  }
}
