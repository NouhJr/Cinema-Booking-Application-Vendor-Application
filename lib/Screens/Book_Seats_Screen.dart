import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_app/Components/Seats.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';

class BookSeat extends StatefulWidget {
  BookSeat({this.movieDocID});
  final String movieDocID;
  @override
  _BookSeatState createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
  final fireStore = FirebaseFirestore.instance;
  var list = [];

  void getData() async {
    final doc =
        await fireStore.collection('Movies').doc(widget.movieDocID).get();
    var tempSeats = doc['Seats'];
    setState(() {
      list = tempSeats;
    });
    for (int j = 0; j < seats.length; j++) {
      setState(() {
        seats[j]["id"] = list[j]["ID"];
        seats[j]["isReserved"] = list[j]["Is Reserved"];
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  var seats = [
    {
      "id": 1,
      "isReserved": false,
    },
    {
      "id": 2,
      "isReserved": false,
    },
    {
      "id": 3,
      "isReserved": false,
    },
    {
      "id": 4,
      "isReserved": false,
    },
    {
      "id": 5,
      "isReserved": false,
    },
    {
      "id": 6,
      "isReserved": false,
    },
    {
      "id": 7,
      "isReserved": false,
    },
    {
      "id": 8,
      "isReserved": false,
    },
    {
      "id": 9,
      "isReserved": false,
    },
    {
      "id": 10,
      "isReserved": false,
    },
    {
      "id": 11,
      "isReserved": false,
    },
    {
      "id": 12,
      "isReserved": false,
    },
    {
      "id": 13,
      "isReserved": false,
    },
    {
      "id": 14,
      "isReserved": false,
    },
    {
      "id": 15,
      "isReserved": false,
    },
    {
      "id": 16,
      "isReserved": false,
    },
    {
      "id": 17,
      "isReserved": false,
    },
    {
      "id": 18,
      "isReserved": false,
    },
    {
      "id": 19,
      "isReserved": false,
    },
    {
      "id": 20,
      "isReserved": false,
    },
    {
      "id": 21,
      "isReserved": false,
    },
    {
      "id": 22,
      "isReserved": false,
    },
    {
      "id": 23,
      "isReserved": false,
    },
    {
      "id": 24,
      "isReserved": false,
    },
    {
      "id": 25,
      "isReserved": false,
    },
    {
      "id": 26,
      "isReserved": false,
    },
    {
      "id": 27,
      "isReserved": false,
    },
    {
      "id": 28,
      "isReserved": false,
    },
    {
      "id": 29,
      "isReserved": false,
    },
    {
      "id": 30,
      "isReserved": false,
    },
    {
      "id": 31,
      "isReserved": false,
    },
    {
      "id": 32,
      "isReserved": false,
    },
    {
      "id": 33,
      "isReserved": false,
    },
    {
      "id": 34,
      "isReserved": false,
    },
    {
      "id": 35,
      "isReserved": false,
    },
    {
      "id": 36,
      "isReserved": false,
    },
    {
      "id": 37,
      "isReserved": false,
    },
    {
      "id": 38,
      "isReserved": false,
    },
    {
      "id": 39,
      "isReserved": false,
    },
    {
      "id": 40,
      "isReserved": false,
    },
    {
      "id": 41,
      "isReserved": false,
    },
    {
      "id": 42,
      "isReserved": false,
    },
    {
      "id": 43,
      "isReserved": false,
    },
    {
      "id": 44,
      "isReserved": false,
    },
    {
      "id": 45,
      "isReserved": false,
    },
    {
      "id": 46,
      "isReserved": false,
    },
    {
      "id": 47,
      "isReserved": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        margin: EdgeInsets.only(top: SizeConfig.defaultSize * 10.0),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.defaultSize - 5.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Seats",
                  style: AppBarFontStyle,
                ),
              ),
              Center(
                child: Image.asset(
                  "Assets/screen.png",
                  height: SizeConfig.defaultSize * 9.0,
                ),
              ),

              // First Seat Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #1
                  Seat(
                    selectedSeatID: seats[0]["id"],
                    isReserved: seats[0]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #2
                  Seat(
                    selectedSeatID: seats[1]["id"],
                    isReserved: seats[1]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #3
                  Seat(
                    selectedSeatID: seats[2]["id"],
                    isReserved: seats[2]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #4
                  Seat(
                    selectedSeatID: seats[3]["id"],
                    isReserved: seats[3]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #5
                  Seat(
                    selectedSeatID: seats[4]["id"],
                    isReserved: seats[4]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #6
                  Seat(
                    selectedSeatID: seats[5]["id"],
                    isReserved: seats[5]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #7
                  Seat(
                    selectedSeatID: seats[6]["id"],
                    isReserved: seats[6]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),
                ],
              ),

              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Seat #8
                  Seat(
                    selectedSeatID: seats[7]["id"],
                    isReserved: seats[7]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #9
                  Seat(
                    selectedSeatID: seats[8]["id"],
                    isReserved: seats[8]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #10
                  Seat(
                    selectedSeatID: seats[9]["id"],
                    isReserved: seats[9]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #11
                  Seat(
                    selectedSeatID: seats[10]["id"],
                    isReserved: seats[10]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #12
                  Seat(
                    selectedSeatID: seats[11]["id"],
                    isReserved: seats[11]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #13
                  Seat(
                    selectedSeatID: seats[12]["id"],
                    isReserved: seats[12]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #14
                  Seat(
                    selectedSeatID: seats[13]["id"],
                    isReserved: seats[13]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),
                ],
              ),

              // Third  Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Seat #15
                  Seat(
                    selectedSeatID: seats[14]["id"],
                    isReserved: seats[14]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #16
                  Seat(
                    selectedSeatID: seats[15]["id"],
                    isReserved: seats[15]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #17
                  Seat(
                    selectedSeatID: seats[16]["id"],
                    isReserved: seats[16]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #18
                  Seat(
                    selectedSeatID: seats[17]["id"],
                    isReserved: seats[17]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #19
                  Seat(
                    selectedSeatID: seats[18]["id"],
                    isReserved: seats[18]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #20
                  Seat(
                    selectedSeatID: seats[19]["id"],
                    isReserved: seats[19]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #21
                  Seat(
                    selectedSeatID: seats[20]["id"],
                    isReserved: seats[20]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),
                ],
              ),

              // 4TH Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Seat #22
                  Seat(
                    selectedSeatID: seats[21]["id"],
                    isReserved: seats[21]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #23
                  Seat(
                    selectedSeatID: seats[22]["id"],
                    isReserved: seats[22]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #24
                  Seat(
                    selectedSeatID: seats[23]["id"],
                    isReserved: seats[23]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #25
                  Seat(
                    selectedSeatID: seats[24]["id"],
                    isReserved: seats[24]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #26
                  Seat(
                    selectedSeatID: seats[25]["id"],
                    isReserved: seats[25]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #27
                  Seat(
                    selectedSeatID: seats[26]["id"],
                    isReserved: seats[26]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #28
                  Seat(
                    selectedSeatID: seats[27]["id"],
                    isReserved: seats[27]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),
                ],
              ),

              // 5TH Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Seat #29
                  Seat(
                    selectedSeatID: seats[28]["id"],
                    isReserved: seats[28]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #30
                  Seat(
                    selectedSeatID: seats[29]["id"],
                    isReserved: seats[29]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #31
                  Seat(
                    selectedSeatID: seats[30]["id"],
                    isReserved: seats[30]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #32
                  Seat(
                    selectedSeatID: seats[31]["id"],
                    isReserved: seats[31]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #33
                  Seat(
                    selectedSeatID: seats[32]["id"],
                    isReserved: seats[32]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #34
                  Seat(
                    selectedSeatID: seats[33]["id"],
                    isReserved: seats[33]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #35
                  Seat(
                    selectedSeatID: seats[34]["id"],
                    isReserved: seats[34]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),
                ],
              ),

              // 6TH Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Seat #36
                  Seat(
                    selectedSeatID: seats[35]["id"],
                    isReserved: seats[35]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #37
                  Seat(
                    selectedSeatID: seats[36]["id"],
                    isReserved: seats[36]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #38
                  Seat(
                    selectedSeatID: seats[37]["id"],
                    isReserved: seats[37]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #39
                  Seat(
                    selectedSeatID: seats[38]["id"],
                    isReserved: seats[38]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #40
                  Seat(
                    selectedSeatID: seats[39]["id"],
                    isReserved: seats[39]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #41
                  Seat(
                    selectedSeatID: seats[40]["id"],
                    isReserved: seats[40]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #42
                  Seat(
                    selectedSeatID: seats[41]["id"],
                    isReserved: seats[41]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),
                ],
              ),

              // final Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #43
                  Seat(
                    selectedSeatID: seats[42]["id"],
                    isReserved: seats[42]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #44
                  Seat(
                    selectedSeatID: seats[43]["id"],
                    isReserved: seats[43]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #45
                  Seat(
                    selectedSeatID: seats[44]["id"],
                    isReserved: seats[44]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Seat #46
                  Seat(
                    selectedSeatID: seats[45]["id"],
                    isReserved: seats[45]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  //Seat #47
                  Seat(
                    selectedSeatID: seats[46]["id"],
                    isReserved: seats[46]["isReserved"],
                    movieDOC: widget.movieDocID,
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),
                ],
              ),

              SizedBox(
                height: SizeConfig.defaultSize * 5.0,
              ),

              //Hints Row
              Row(
                children: [
                  //Available hint.
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.defaultSize * 6.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 19.0,
                          height: 19.0,
                          decoration: BoxDecoration(
                            color: FreeSeatColor,
                            border: Border.all(
                              color: SubMainColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.defaultSize - 3.0,
                        ),
                        Container(
                          child: Text(
                            "Available",
                            style: HintLabelFontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),

                  //Reserved hint
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.defaultSize * 5.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 19.0,
                          height: 19.0,
                          decoration: BoxDecoration(
                            color: BookedSeatColor,
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.defaultSize - 3.0,
                        ),
                        Container(
                          child: Text(
                            "Reserved",
                            style: HintLabelFontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
