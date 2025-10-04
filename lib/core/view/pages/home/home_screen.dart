import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_machine_task/core/bloc/home/bloc/home_bloc.dart';
import 'package:ui_machine_task/core/model/models/category_model.dart';
import 'package:ui_machine_task/core/view/pages/utils/collections.dart';
import 'package:ui_machine_task/core/view/pages/utils/message_generator.dart';

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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
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
                      onPressed: () {
                        context.push('/notification');
                      },
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.redAccent,
                        size: 28.h,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.local_offer_outlined,
                        color: Colors.amberAccent,
                        size: 28.h,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final isExpand = state.isExpanded;
                  final visibleCategories =
                      isExpand ? categories : categories.take(8).toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          MessageGenerator.getMessage("category_title"),
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 21.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.9,
                        ),
                        shrinkWrap: true,
                        itemCount: visibleCategories.length,
                        itemBuilder: (context, index) {
                          final category = visibleCategories[index];
                          return buildCategoryItem(category);
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            context.read<HomeBloc>().add(ToggleCategoryEvent());
                          },
                          child: Container(
                            width: 65.w,
                            height: 34.h,

                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isExpand ? "Less" : "More",
                                  style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                      color: Color(0xFF06C25E),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                Icon(
                                  isExpand
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 22.sp,
                                  color: Color(0xFF06C25E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      MessageGenerator.getMessage("top_picks"),
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 21.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 155.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 320.w,
                            height: 155.h,
                            decoration: BoxDecoration(
                              color: Color(0xFF06C25E),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 18.h,
                                  left: 18.w,

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DISCOUNT\n25% ALL\nFRUITS",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          shape: RoundedRectangleBorder(),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 40.w,
                                            vertical: 10.h,
                                          ),
                                        ),

                                        child: Text(
                                          "Check Now",

                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            height: 0.2,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    "assets/icons/ice_cream.png",
                                    width: 148.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        MessageGenerator.getMessage("Trending"),
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 21.sp,
                          ),
                        ),
                      ),
                      Text(
                        MessageGenerator.getMessage("See all"),
                        style: GoogleFonts.quicksand(
                          color: Color(0xFF06C25E),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (contex, index) {
                        return SizedBox(
                          width: 240.w,
                          height: 80.h,

                          child: Row(
                            children: [
                              Image.asset("assets/icons/Ice_cream2.png"),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 3.h,
                                  children: [
                                    Text(
                                      MessageGenerator.getMessage(
                                        "Mithas Bhandar",
                                      ),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      MessageGenerator.getMessage(
                                        "Sweets, North Indian",
                                      ),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      MessageGenerator.getMessage(
                                        "(store location)  |  6.4 kms",
                                      ),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Color(0xFF474747),
                                        ),
                                        Text(
                                          MessageGenerator.getMessage(
                                            "4.1  |  45 mins",
                                          ),
                                          style: GoogleFonts.quicksand(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (contex, index) {
                        return SizedBox(
                          width: 240.w,
                          height: 80.h,

                          child: Row(
                            children: [
                              Image.asset("assets/icons/Ice_cream2.png"),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 3.h,
                                  children: [
                                    Text(
                                      MessageGenerator.getMessage(
                                        "Mithas Bhandar",
                                      ),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      MessageGenerator.getMessage(
                                        "Sweets, North Indian",
                                      ),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      MessageGenerator.getMessage(
                                        "(store location)  |  6.4 kms",
                                      ),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Color(0xFF474747),
                                        ),
                                        Text(
                                          MessageGenerator.getMessage(
                                            "4.1  |  45 mins",
                                          ),
                                          style: GoogleFonts.quicksand(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MessageGenerator.getMessage("Craze deals"),
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 21.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 132.h,
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Container(
                        width: 310.w,
                        height: 132.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF262626),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: -8,
                              child: Image.asset(
                                "assets/icons/vegitable_fly.png",
                                height: 130.h,
                              ),
                            ),
                            Positioned(
                              top: 28.h,
                              left: 18.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MessageGenerator.getMessage("craze_title"),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Container(
                                    color: Colors.transparent,
                                    width: 120.w,
                                    height: 30.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      spacing: 8.w,
                                      children: [
                                        Text(
                                          MessageGenerator.getLabel("Explore"),
                                          style: GoogleFonts.quicksand(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFEA7E00),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Color(0xFFEA7E00),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  width: double.infinity,
                  height: 75.h,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF29D177),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              MessageGenerator.getLabel("Refer"),
                              style: GoogleFonts.quicksand(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                MessageGenerator.getMessage("refer_message"),
                                style: GoogleFonts.quicksand(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              CircleAvatar(
                                radius: 8.r,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Color(0xFF29D177),
                                    size: 12.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset("assets/icons/Gift.png", width: 72.w),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        MessageGenerator.getMessage("Nearby stores"),
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 21.sp,
                          ),
                        ),
                      ),
                      Text(
                        MessageGenerator.getMessage("See all"),
                        style: GoogleFonts.quicksand(
                          color: Color(0xFF06C25E),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 120.h,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icons/Food.png",
                              width: 72.w,
                              height: 80.h,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 2.h,
                                          children: [
                                            Text(
                                              MessageGenerator.getLabel(
                                                "Freshly Baker",
                                              ),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              MessageGenerator.getMessage(
                                                "Sweets, North Indian",
                                              ),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              MessageGenerator.getMessage(
                                                "Site No - 1  |  6.4 kms",
                                              ),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              width: 40.w,
                                              height: 13.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                  255,
                                                  218,
                                                  217,
                                                  217,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(2.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Top Store",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 45.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star_purple500_sharp,
                                                  color: Color(0xFF474747),
                                                  size: 15.w,
                                                ),
                                                Text(
                                                  "4.1",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "45 mins",
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18.sp,
                                                color: Color(0xFFEA7E00),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.h),
                                    Divider(
                                      color: Color(0xFFDEDEDE),
                                      thickness: 2,
                                    ),
                                    Row(
                                      spacing: 8.w,
                                      children: [
                                        Row(
                                          spacing: 5.w,
                                          children: [
                                            Image.asset(
                                              "assets/icons/percentage.png",
                                              width: 16.w,
                                              height: 16.h,
                                            ),
                                            Text(
                                              MessageGenerator.getMessage(
                                                "Upto 10% OFF",
                                              ),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          spacing: 5.w,
                                          children: [
                                            Image.asset(
                                              "assets/icons/grocerys.png",
                                              width: 16.w,
                                              height: 16.h,
                                            ),
                                            Text(
                                              MessageGenerator.getMessage(
                                                "3400+ items available",
                                              ),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF06C25E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                ),
                child: Text(
                  MessageGenerator.getLabel("view"),
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCategoryItem(Category category) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 57.h,
            width: 57.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Image.asset(category.iconPath, height: 30)),
          ),
          if (category.hasDiscount)
            Positioned(
              right: 1,
              top: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "10% Off",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 6),
      Text(category.title, style: const TextStyle(fontSize: 12)),
    ],
  );
}
