import 'dart:ui';
import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void add() {
    if (amountController.text.isNotEmpty) {
      ExpenseItem expense = ExpenseItem(
        name: titleController.text,
        amount: amountController.text,
        dateTime: DateTime.now(),
      );
      Provider.of<ExpenseData>(context, listen: false).addExpense(expense);
      Navigator.of(context).pop();
      clear();
    }
  }

  void back() {
    Navigator.of(context).pop();
    clear();
  }

  void clear() {
    titleController.clear();
    amountController.clear();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) {
        // ignore: no_leading_underscores_for_local_identifiers
        String? _amntError;
        // ignore: no_leading_underscores_for_local_identifiers
        String? _titleError;
        return StatefulBuilder(
          builder: (context, setState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                elevation: 80,
                title: const Text(
                  'Add New Expense',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //padding 12
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        errorText: _titleError,
                        hintText: "Title",
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        fillColor: const Color.fromARGB(255, 228, 227, 227),
                        filled: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: amountController,
                        decoration: InputDecoration(
                          errorText: _amntError,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Amount",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          fillColor: const Color.fromARGB(255, 228, 227, 227),
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          clear();
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(53, 79, 82, 1)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (amountController.text.isNotEmpty &&
                              titleController.text.isNotEmpty) {
                            ExpenseItem expense = ExpenseItem(
                              name: titleController.text,
                              amount: amountController.text,
                              dateTime: DateTime.now(),
                            );
                            Provider.of<ExpenseData>(context, listen: false)
                                .addExpense(expense);
                            Navigator.of(context).pop();
                            clear();
                          } else {
                            setState(() {
                              if (amountController.text.isEmpty &&
                                  titleController.text.isNotEmpty) {
                                _amntError = 'Please enter an amount.';
                              } else if (titleController.text.isEmpty &&
                                  amountController.text.isNotEmpty) {
                                _titleError = 'Please enter a title.';
                              } else if (amountController.text.isEmpty &&
                                  titleController.text.isEmpty) {
                                _amntError = 'Please enter an amount.';
                                _titleError = 'Please enter a title.';
                              }
                            });
                          }
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(53, 79, 82, 1)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
    //notifyListeners();
  }

  @override
  void initState() {
    super.initState();

    //prepare data to startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            backgroundColor: const Color.fromRGBO(53, 79, 82, 1),
            title: const Text(
              "Expense Tracker",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          //backgroundColor: const Color.fromRGBO(100, 147, 136, 1),
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
            elevation: 15,
            child: const Icon(
              Icons.add,
              color: Color.fromRGBO(231, 255, 249, 1),
            ),
          ),
          body: ListView(
            children: [
              //Weekly Bar
              ExpenseSummary(
                startOfWeek: value.getStartOfWeek(),
              ),

              const SizedBox(
                height: 25,
              ),
              //Expense List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenses().length,
                itemBuilder: (context, index) {
                  return ExpenseTile(
                    name: value.getAllExpenses()[index].name,
                    amount: value.getAllExpenses()[index].amount,
                    dateTime: value.getAllExpenses()[index].dateTime,
                    deleteTap: (p0) =>
                        deleteExpense(value.getAllExpenses()[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
