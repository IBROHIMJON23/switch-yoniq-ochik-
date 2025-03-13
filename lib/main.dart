import 'package:flutter/material.dart';

void main() {
  runApp(PaynetApp());
}

class PaynetApp extends StatefulWidget {
  @override
  _PaynetAppState createState() => _PaynetAppState();
}

class _PaynetAppState extends State<PaynetApp> {
  bool isDarkMode = false; // Tungi rejimni saqlash

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To‘lov Ilovasi',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        isDarkMode: isDarkMode,
        toggleDarkMode: () {
          setState(() {
            isDarkMode = !isDarkMode; // Rejimni o‘zgartirish
          });
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  HomePage({required this.isDarkMode, required this.toggleDarkMode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 50000.0; // Boshlang‘ich balans

  void addBalance() {
    setState(() {
      balance += 10000; // Balansga qo‘shimcha pul qo‘shish
    });
  }

  void makePayment(double amount) {
    if (balance >= amount) {
      setState(() {
        balance -= amount;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Balans yetarli emas!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To‘lov Xizmati"),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: widget.toggleDarkMode,
          ),
        ],
      ),
      body: Column(
        children: [
          // Balans ko‘rsatgich
          Card(
            margin: EdgeInsets.all(16),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet, size: 40),
              title: Text("Balans:"),
              subtitle: Text(
                "$balance so‘m",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: addBalance,
                child: Text("To‘ldirish"),
              ),
            ),
          ),
          SizedBox(height: 20),

          // To‘lov xizmatlari tugmalari
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: [
                ServiceButton(
                  icon: Icons.phone_android,
                  label: "Mobil aloqa",
                  amount: 5000,
                  onPay: makePayment,
                ),
                ServiceButton(
                  icon: Icons.wifi,
                  label: "Internet",
                  amount: 15000,
                  onPay: makePayment,
                ),
                ServiceButton(
                  icon: Icons.electric_bolt,
                  label: "Elektr energiyasi",
                  amount: 20000,
                  onPay: makePayment,
                ),
                ServiceButton(
                  icon: Icons.water,
                  label: "Suv ta’minoti",
                  amount: 10000,
                  onPay: makePayment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Xizmat tugmalari
class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final double amount;
  final Function(double) onPay;

  ServiceButton({
    required this.icon,
    required this.label,
    required this.amount,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child: InkWell(
        onTap: () => onPay(amount),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "$amount so‘m",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
