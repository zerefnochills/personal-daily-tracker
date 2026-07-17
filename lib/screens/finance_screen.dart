import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../main.dart';
import '../data/database.dart';
import '../widgets/app_drawer.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final now = DateTime.now();

  void _setIncomeDialog(BuildContext context, double currentIncome) {
    final controller =
        TextEditingController(text: currentIncome > 0 ? currentIncome.toStringAsFixed(0) : '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set monthly income'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Income for this month'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final amount = double.tryParse(controller.text) ?? 0;
              await db.setMonthlyIncome(now.year, now.month, amount);
              if (ctx.mounted) Navigator.pop(ctx);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addExpenseDialog(BuildContext context) {
    final amountController = TextEditingController();
    final categoryController = TextEditingController();
    final descController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                  labelText: 'Category (e.g. food, rent, travel)'),
            ),
            TextField(
              controller: descController,
              decoration:
                  const InputDecoration(labelText: 'Description (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              final category = categoryController.text.trim().isEmpty
                  ? 'uncategorized'
                  : categoryController.text.trim();
              if (amount <= 0) return;
              db.addExpense(ExpensesCompanion(
                amount: Value(amount),
                category: Value(category),
                description: Value(descController.text.trim().isEmpty
                    ? null
                    : descController.text.trim()),
                date: Value(DateTime.now()),
              ));
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finance')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addExpenseDialog(context),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<double>(
        future: db.incomeForMonth(now.year, now.month),
        builder: (context, incomeSnapshot) {
          final income = incomeSnapshot.data ?? 0;
          return StreamBuilder<List<Expense>>(
            stream: db.watchExpensesForMonth(now.year, now.month),
            builder: (context, expenseSnapshot) {
              final expenses = expenseSnapshot.data ?? [];
              final totalSpent =
                  expenses.fold<double>(0, (sum, e) => sum + e.amount);
              final remaining = income - totalSpent;

              final byCategory = <String, double>{};
              for (final e in expenses) {
                byCategory[e.category] =
                    (byCategory[e.category] ?? 0) + e.amount;
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('This month',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              TextButton(
                                onPressed: () =>
                                    _setIncomeDialog(context, income),
                                child: const Text('Set income'),
                              ),
                            ],
                          ),
                          Text('Income: ${income.toStringAsFixed(0)}'),
                          Text('Spent: ${totalSpent.toStringAsFixed(0)}'),
                          Text(
                            'Remaining: ${remaining.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: remaining < 0 ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (byCategory.isNotEmpty) ...[
                    Text('By category',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ...byCategory.entries.map((entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key),
                              Text(entry.value.toStringAsFixed(0)),
                            ],
                          ),
                        )),
                    const SizedBox(height: 16),
                  ],
                  Text('Recent expenses',
                      style: Theme.of(context).textTheme.titleMedium),
                  if (expenses.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('No expenses logged this month'),
                    ),
                  ...expenses.map((e) => Dismissible(
                        key: ValueKey(e.id),
                        onDismissed: (_) => db.deleteExpense(e.id),
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text(e.category),
                          subtitle: Text(e.description ??
                              e.date.toString().split(' ').first),
                          trailing: Text(e.amount.toStringAsFixed(0)),
                        ),
                      )),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
