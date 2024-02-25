import 'dart:developer';
import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';

class SeatScreen extends StatefulWidget {
  const SeatScreen({Key? key}) : super(key: key);

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  Set<SeatNumber> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Text("Front of bus is this side"),
          Image.asset('asset/image/Group seat.png'),
          const SizedBox(
            height: 32,
          ),
          Flexible(
            child: SizedBox(
              height: 400,
              child: SeatLayoutWidget(
                onSeatStateChanged: (rowI, colI, seatState) {
                  if (seatState == SeatState.selected) {
                    selectedSeats
                        .add(SeatNumber(rowI: rowI, colI: colI));
                    log(selectedSeats.toString());
                  } else {
                    selectedSeats
                        .remove(SeatNumber(rowI: rowI, colI: colI));
                    log(selectedSeats.toString());
                  }
                },
                stateModel: SeatLayoutStateModel(
                    rows: 40,
                    cols: 30,
                    seatSvgSize: 20,
                    pathSelectedSeat: 'asset/image/seat_selected.svg',
                    pathDisabledSeat: 'asset/image/seat_disabled.svg',
                    pathSoldSeat: 'asset/image/seat_sold.svg',
                    pathUnSelectedSeat:
                        'asset/image/seat_unselected.svg',
                    currentSeatsState: List.generate(40, (rowIndex) {
                      return List.generate(38, (colIndex) {
                        return SeatState.unselected;
                      });
                    })),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 2),
                    const Text('Disabled')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: Colors.lightBlueAccent,
                    ),
                    const SizedBox(width: 2),
                    const Text('Sold')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0FFF50))),
                    ),
                    const SizedBox(width: 2),
                    const Text('Available')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: const Color(0xff0FFF50),
                    ),
                    const SizedBox(width: 2),
                    const Text('Selected by you')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => const Color(0xFFfc4c4e)),
            ),
            child: const Text('Show my selected seat numbers'),
          ),
          const SizedBox(height: 12),
          Text(selectedSeats.join(" , "))
        ],
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == other.colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[ Row: $colI][Seat $colI]';
  }
}
