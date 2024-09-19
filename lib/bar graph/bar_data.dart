import 'package:expense_tracker/bar%20graph/individual_bar.dart';

class BarData {
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thursAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData({
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];

  //initialize data
  void initializeBarData() {
    barData = [
      //Monday
      IndividualBar(x: 0, y: monAmount),
      //Tuesday
      IndividualBar(x: 1, y: tuesAmount),
      //Wedneday
      IndividualBar(x: 2, y: wedAmount),
      //Thursday
      IndividualBar(x: 3, y: thursAmount),
      //Friday
      IndividualBar(x: 4, y: friAmount),
      //Saturday
      IndividualBar(x: 5, y: satAmount),
      //Sunday
      IndividualBar(x: 6, y: sunAmount),
    ]; 
  }
}