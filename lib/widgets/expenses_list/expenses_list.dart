import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_items.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDeleteExpense,
  });

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel) onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        child: ExpensesItems(expense: expenses[index]),
        onDismissed: (direction) {
          onDeleteExpense(expenses[index]);
        },
      ),
    );
  }
}
