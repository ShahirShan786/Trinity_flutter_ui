import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCity = "New Delhi";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            spacing: 5.h,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 160.w,
                  height: 50,

                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Colors.green),
                      SizedBox(width: 0),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCity,
                          isDense: true,
                          items: [
                            DropdownMenuItem(
                              value: "New Delhi",
                              child: Text("ABCD, New Delhi"),
                            ),
                            DropdownMenuItem(
                              value: "Mumbai",
                              child: Text("EFGH, Mumbai"),
                            ),
                            DropdownMenuItem(
                              value: "Chennai",
                              child: Text("XYZ, Chennai"),
                            ),
                          ],
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.green,
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedCity = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search for Product/Stores",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            suffixIcon: Icon(Icons.search, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.redAccent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_square, color: Colors.amberAccent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
