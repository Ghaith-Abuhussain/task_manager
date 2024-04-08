import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/Colors.dart';
import '../../utils/constants/strings.dart';
import 'custom_back_button.dart';
import 'custom_elevated_button.dart';

class TaskCard extends StatelessWidget {
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Color? shimmerBackColor;

  final TextStyle? titleTextStyle;
  final TextStyle? nameTextStyle;

  final Function editTask;
  final Function deleteTask;

  TaskCard({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
    this.shimmerBackColor = CustomColors.gray,
    this.shimmerBaseColor = CustomColors.lightGray,
    this.shimmerHighlightColor = CustomColors.white,
    required this.editTask,
    required this.deleteTask,
    required this.titleTextStyle,
    required this.nameTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.background,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Container(
        width: MediaQuery.of(context).size.width * (90 / 100),
        height: MediaQuery.of(context).size.height * (30 / 100),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FancyShimmerImage(
                    width: 100,
                    height: 100,
                    imageUrl: avatar,
                    shimmerBaseColor: shimmerBaseColor,
                    shimmerHighlightColor: shimmerHighlightColor,
                    shimmerBackColor: shimmerBackColor,
                  ),
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleDataRow("First Name:", first_name),
                    titleDataRow("Last Name:", last_name),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10,),
            titleDataRow("Email:", email),
            Row(
              children: [
                CustomBackButton(
                  icon: Icons.edit,
                  onPressed: () {
                    editTask();
                  },
                  color: Colors.green,
                  iconSize: 24,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(16),
                ),
                CustomBackButton(
                  icon: Icons.delete,
                  onPressed: () {
                    deleteTask();
                  },
                  color: Colors.red,
                  iconSize: 24,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget titleDataRow(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextStyle,
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            child: Text(
              data,
              style: nameTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
