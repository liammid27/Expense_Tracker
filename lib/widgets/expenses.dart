import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpeneses = [
    ExpenseModel(
      title: 'Flutter Course',
      amount: 219.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'Movie',
      amount: 109.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openExpenseAddOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpeneses.add(expense);
    });
  }

  void _deleteExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpeneses.indexOf(expense);

    setState(() {
      _registeredExpeneses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpeneses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: const Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpeneses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpeneses,
        onDeleteExpense: _deleteExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openExpenseAddOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpeneses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
