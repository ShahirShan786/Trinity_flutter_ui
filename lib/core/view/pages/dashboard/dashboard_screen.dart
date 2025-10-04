import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/nav_icons/home.png", width: 25.w),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/nav_icons/cart.png", width: 25.w),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/nav_icons/order.png", width: 25.w),
            label: "My Order",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/nav_icons/account.png", width: 25.w),
            label: "Account",
          ),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(12), child: Column(children: [
          
          ],
        )),
    );
  }
}
