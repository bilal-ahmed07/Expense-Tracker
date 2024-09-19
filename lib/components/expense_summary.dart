import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/date%20time/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMax(
    ExpenseData value,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    double? max = 1000;

    List<double> values = [
      value.calculateDailyExpense()[monday] ?? 0,
      value.calculateDailyExpense()[tuesday] ?? 0,
      value.calculateDailyExpense()[wednesday] ?? 0,
      value.calculateDailyExpense()[thursday] ?? 0,
      value.calculateDailyExpense()[friday] ?? 0,
      value.calculateDailyExpense()[saturday] ?? 0,
      value.calculateDailyExpense()[sunday] ?? 0,
    ];
    values.sort();

    max = values.last + 500;
    return max == 0 ? 1000 : max;
  }

  // Claculating week total
  String calculateWeekTotal(
    ExpenseData value,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    List<double> values = [
      value.calculateDailyExpense()[monday] ?? 0,
      value.calculateDailyExpense()[tuesday] ?? 0,
      value.calculateDailyExpense()[wednesday] ?? 0,
      value.calculateDailyExpense()[thursday] ?? 0,
      value.calculateDailyExpense()[friday] ?? 0,
      value.calculateDailyExpense()[saturday] ?? 0,
      value.calculateDailyExpense()[sunday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String monday =
        convertDateToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday =
        convertDateToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday =
        convertDateToString(startOfWeek.add(const Duration(days: 2)));
    String thursday =
        convertDateToString(startOfWeek.add(const Duration(days: 3)));
    String friday =
        convertDateToString(startOfWeek.add(const Duration(days: 4)));
    String saturday =
        convertDateToString(startOfWeek.add(const Duration(days: 5)));
    String sunday =
        convertDateToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(builder: (context, value, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                const Text(
                  "Week Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Rs.${calculateWeekTotal(
                  value,
                  monday,
                  tuesday,
                  wednesday,
                  thursday,
                  friday,
                  saturday,
                  sunday,
                )}"),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: BarGraph(
              maxY: calculateMax(
                value,
                monday,
                tuesday,
                wednesday,
                thursday,
                friday,
                saturday,
                sunday,
              ),
              monAmount: value.calculateDailyExpense()[monday] ?? 0,
              tuesAmount: value.calculateDailyExpense()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpense()[wednesday] ?? 0,
              thursAmount: value.calculateDailyExpense()[thursday] ?? 0,
              friAmount: value.calculateDailyExpense()[friday] ?? 0,
              satAmount: value.calculateDailyExpense()[saturday] ?? 0,
              sunAmount: value.calculateDailyExpense()[sunday] ?? 0,
            ),
          ),
        ],
      );
    });
  }
}
