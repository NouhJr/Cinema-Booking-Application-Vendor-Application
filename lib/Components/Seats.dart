import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Constants.dart';

// ignore: must_be_immutable
class Seat extends StatefulWidget {
  Seat({
    this.selectedSeatID,
    this.isReserved,
    this.movieDOC,
  });
  bool isSelected = false;
  bool isReserved = false;
  int selectedSeatID;
  String movieDOC;

  @override
  _CienmaSeatState createState() => _CienmaSeatState();
}

class _CienmaSeatState extends State<Seat> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.width / 15,
          decoration: BoxDecoration(
              color: widget.isSelected && !widget.isReserved
                  ? AvailableSeatColor
                  : widget.isReserved
                      ? BookedSeatColor
                      : FreeSeatColor,
              borderRadius: BorderRadius.circular(5.0))),
    );
  }
}
