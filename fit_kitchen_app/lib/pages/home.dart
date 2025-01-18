import 'package:fitness/models/category_model.dart';
import 'package:fitness/models/diet_model.dart';
import 'package:fitness/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitness/constants/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(
            height: 40,
          ),
          _categoriesSection(),
          const SizedBox(
            height: 40,
          ),
          _dietSection(),
          const SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Popular",
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                itemCount: popularDiets.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: popularDiets[index].boxIsSelected
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: popularDiets[index].boxIsSelected
                            ? [
                                BoxShadow(
                                    color: AppColors.cardShadow.withOpacity(0.07),
                                    offset: const Offset(0, 10),
                                    blurRadius: 40,
                                    spreadRadius: 0)
                              ]
                            : []),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          popularDiets[index].iconPath,
                          width: 65,
                          height: 65,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularDiets[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                  fontSize: 16),
                            ),
                            Text(
                              popularDiets[index].level +
                                  ' | ' +
                                  popularDiets[index].duration +
                                  ' | ' +
                                  popularDiets[index].calorie,
                              style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/icons/button.svg",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Recommendation\nfor Diets",
            style: TextStyle(
                color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: AppColors.accent2.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(diets[index].iconPath),
                    Text(
                      diets[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                          fontSize: 16),
                    ),
                    Text(
                      '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                      style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 45,
                      width: 130,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColors.primary,
                            AppColors.accent2,
                          ]),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          "View",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: diets.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
          ),
        ),
      ],
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Category",
            style: TextStyle(
                color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 25,
                  ),
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.accent2.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                SvgPicture.asset(categories[index].iconPath)),
                      ),
                      Text(
                        categories[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withOpacity(0.12),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          hintText: "Feeling hungry?",
          hintStyle: TextStyle(
            color: AppColors.textSecondary.withOpacity(0.7),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                "assets/icons/Search.svg",
                color: AppColors.primary,
              ),
            ),
          ),
          suffixIcon: Container(
            padding: const EdgeInsets.only(right: 8),
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 35,
                    width: 1,
                    color: AppColors.textSecondary.withOpacity(0.15),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.accent2,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Filter.svg",
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.textSecondary.withOpacity(0.1),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.primary.withOpacity(0.5),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0.0,
      title: const Text(
        "Fit Kitchen",
        style: TextStyle(
            color: AppColors.textLight, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            "assets/icons/Arrow - Left 2.svg",
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              "assets/icons/dots.svg",
              height: 5,
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}
