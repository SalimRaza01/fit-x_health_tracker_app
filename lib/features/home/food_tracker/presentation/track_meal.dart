import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrackMealScreen extends StatelessWidget {
  const TrackMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundLineartop,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.backgroundLineartop,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: Color(0xffBABABA),
          ),
        ),
        title: const Text(
          "TRACK MEAL",
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              CupertinoIcons.info_circle,
              color: Color(0xffBABABA),
              size: 20,
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.backgroundLineartop,
              AppColor.backgroundLinearbottom,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              "SNAP OR ADD FROM GALLERY",
              style: TextStyle(
                color: Color(0xffBABABA),
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "OR",
                style: TextStyle(
                  color: Color(0xffBABABA),
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search Meal",
                  hintStyle: const TextStyle(
                    color: Color(0xffBABABA),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xffBABABA),
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xffBABABA), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xffBABABA), width: 0.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
                onTap: () {
                  context.push('/searchMeal');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
