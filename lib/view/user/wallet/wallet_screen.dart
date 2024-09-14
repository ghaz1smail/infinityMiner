import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet Balance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            '\$5,420.75',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'Recent Transactions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildTransactionCard(
                  context,
                  date: '2024-09-10',
                  description: 'Purchase at Store XYZ',
                  amount: '-\$120.00',
                  color: Colors.redAccent,
                ),
                _buildTransactionCard(
                  context,
                  date: '2024-09-08',
                  description: 'Salary Deposit',
                  amount: '+\$1,500.00',
                  color: Colors.greenAccent,
                ),
                _buildTransactionCard(
                  context,
                  date: '2024-09-05',
                  description: 'Online Subscription',
                  amount: '-\$30.00',
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(
    BuildContext context, {
    required String date,
    required String description,
    required String amount,
    required Color color,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: color),
        title: Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
