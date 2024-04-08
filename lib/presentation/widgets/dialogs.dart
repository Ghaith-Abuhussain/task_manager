import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../utils/constants/Colors.dart';
import '../../utils/constants/strings.dart';
import 'custom_edit_text.dart';
import 'custom_elevated_button.dart';

void showWaitingDialog() {
  SmartDialog.show(
      builder: (context) {
        return Container(
          height: 80,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: ClipRRect(
            child: Image.asset(
              "assets/images/wait.gif",
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      clickMaskDismiss: false,
      backDismiss: false);
}

void showNotifyDialog(String msg, String image, Color color) {
  SmartDialog.show(
      builder: (context) {
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  height: 150,
                ),
              ),
              Text(
                msg,
                style: const TextStyle(
                  color: CustomColors.darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: railwayFontFamily,
                ),
              ),
            ],
          ),
        );
      },
      clickMaskDismiss: true,
      backDismiss: true,
      displayTime: const Duration(seconds: 5));
}

void hideWaitingDialog() {
  SmartDialog.dismiss();
}

void showEditTaskDialog({
  required GlobalKey<FormState> checkEditTaskKey,
  required Color color,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController emailController,
  required VoidCallback onSave,
  required VoidCallback onExit,
}) {
  SmartDialog.show(
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * (60 / 100),
          width: MediaQuery.of(context).size.width * (95 / 100),
          alignment: Alignment.center,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Form(
              key: checkEditTaskKey,
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30, left: 10),
                    child: Text(
                      "Edit Task",
                      style: TextStyle(
                          fontFamily: railwayFontFamily,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.darkBlue),
                    ),
                  ),
                  CustomEditText(
                    label: 'First Name',
                    margin: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * (95 / 100),
                    controller: firstNameController,
                    obscureText: false,
                    icon: Icons.drive_file_rename_outline,
                    textStyle: const TextStyle(
                      color: CustomColors.darkBlue,
                    ),
                    validator: (_) {
                      if (firstNameController.text.trim().isEmpty) {
                        return 'Must Enter Value Here !!!';
                      } else if (firstNameController.text.length > 32) {
                        return 'Too Long Firstname, 32 char is Max !!!';
                      }
                      return null;
                    },
                    defaultBorderSideColor: CustomColors.darkBlue,
                    focusedBorderSideColor: CustomColors.primaryColor,
                  ),
                  CustomEditText(
                    label: 'Last Name',
                    margin: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * (95 / 100),
                    controller: lastNameController,
                    obscureText: false,
                    icon: Icons.drive_file_rename_outline,
                    textStyle: const TextStyle(
                      color: CustomColors.darkBlue,
                    ),
                    validator: (_) {
                      if (lastNameController.text.trim().isEmpty) {
                        return 'Must Enter Value Here !!!';
                      } else if (lastNameController.text.length > 32) {
                        return 'Too Long Lastname, 32 char is Max !!!';
                      }
                      return null;
                    },
                    defaultBorderSideColor: CustomColors.darkBlue,
                    focusedBorderSideColor: CustomColors.primaryColor,
                  ),
                  CustomEditText(
                    label: 'Email',
                    margin: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * (95 / 100),
                    controller: emailController,
                    obscureText: false,
                    icon: Icons.email,
                    textStyle: const TextStyle(
                      color: CustomColors.darkBlue,
                    ),
                    validator: (_) {
                      bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text);

                      if (emailController.text.trim().isEmpty) {
                        return 'Must Enter Value Here !!!';
                      } else if (emailController.text.length > 64) {
                        return 'Too Long Email, 64 char is Max !!!';
                      }

                      if (!emailValid) {
                        return 'Not a correct email address !!!';
                      }
                      return null;
                    },
                    defaultBorderSideColor: CustomColors.darkBlue,
                    focusedBorderSideColor: CustomColors.primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        text: "Save",
                        onPressed: () {
                          final isValid = checkEditTaskKey.currentState?.validate();
                          if (!isValid!) {
                            return;
                          }
                          checkEditTaskKey.currentState?.save();

                          onSave();
                        },
                        width: 100,
                        height: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: railwayFontFamily,
                        fontSize: 14,
                        color: CustomColors.buttonColor,
                        shadowColor: CustomColors.buttonColor,
                        elevation: 20,
                        textColor: CustomColors.white,
                      ),
                      CustomElevatedButton(
                        text: "Exit",
                        // Login UI Functionality
                        onPressed: onExit,
                        width: 100,
                        height: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: railwayFontFamily,
                        fontSize: 14,
                        color: Colors.red,
                        shadowColor: Colors.red,
                        elevation: 20,
                        textColor: CustomColors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      clickMaskDismiss: true,
      backDismiss: true,
      displayTime: null);
}

void showAddTaskDialog({
  required GlobalKey<FormState> checkAddTaskKey,
  required Color color,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController emailController,
  required TextEditingController avatarController,
  required VoidCallback onAdd,
  required VoidCallback onExit,
}) {
  SmartDialog.show(
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * (70 / 100),
            width: MediaQuery.of(context).size.width * (95 / 100),
            alignment: Alignment.center,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Form(
                key: checkAddTaskKey,
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30, left: 10),
                      child: Text(
                        "Add New Task",
                        style: TextStyle(
                            fontFamily: railwayFontFamily,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.darkBlue),
                      ),
                    ),
                    CustomEditText(
                      label: 'First Name',
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * (95 / 100),
                      controller: firstNameController,
                      obscureText: false,
                      icon: Icons.drive_file_rename_outline,
                      textStyle: const TextStyle(
                        color: CustomColors.darkBlue,
                      ),
                      validator: (_) {
                        if (firstNameController.text.trim().isEmpty) {
                          return 'Must Enter Value Here !!!';
                        } else if (firstNameController.text.length > 32) {
                          return 'Too Long Firstname, 32 char is Max !!!';
                        }
                        return null;
                      },
                      defaultBorderSideColor: CustomColors.darkBlue,
                      focusedBorderSideColor: CustomColors.primaryColor,
                    ),
                    CustomEditText(
                      label: 'Last Name',
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * (95 / 100),
                      controller: lastNameController,
                      obscureText: false,
                      icon: Icons.drive_file_rename_outline,
                      textStyle: const TextStyle(
                        color: CustomColors.darkBlue,
                      ),
                      validator: (_) {
                        if (lastNameController.text.trim().isEmpty) {
                          return 'Must Enter Value Here !!!';
                        } else if (lastNameController.text.length > 32) {
                          return 'Too Long Lastname, 32 char is Max !!!';
                        }
                        return null;
                      },
                      defaultBorderSideColor: CustomColors.darkBlue,
                      focusedBorderSideColor: CustomColors.primaryColor,
                    ),
                    CustomEditText(
                      label: 'Email',
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * (95 / 100),
                      controller: emailController,
                      obscureText: false,
                      icon: Icons.email,
                      textStyle: const TextStyle(
                        color: CustomColors.darkBlue,
                      ),
                      validator: (_) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);

                        if (emailController.text.trim().isEmpty) {
                          return 'Must Enter Value Here !!!';
                        } else if (emailController.text.length > 64) {
                          return 'Too Long Email, 64 char is Max !!!';
                        }

                        if (!emailValid) {
                          return 'Not a correct email address !!!';
                        }
                        return null;
                      },
                      defaultBorderSideColor: CustomColors.darkBlue,
                      focusedBorderSideColor: CustomColors.primaryColor,
                    ),
                    CustomEditText(
                      label: 'Avatar',
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * (95 / 100),
                      controller: avatarController,
                      obscureText: false,
                      icon: Icons.email,
                      textStyle: const TextStyle(
                        color: CustomColors.darkBlue,
                      ),
                      validator: (_) {
                        if (avatarController.text.trim().isEmpty) {
                          return 'Must Enter Value Here !!!';
                        }

                        try {
                          Uri.parse(avatarController.text);
                        } catch (e) {
                          return 'Not a Valid URL !!!';
                        }
                        return null;
                      },
                      defaultBorderSideColor: CustomColors.darkBlue,
                      focusedBorderSideColor: CustomColors.primaryColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          text: "Add",
                          // Login UI Functionality
                          onPressed: () {
                            final isValid = checkAddTaskKey.currentState?.validate();
                            if (!isValid!) {
                              return;
                            }
                            checkAddTaskKey.currentState?.save();

                            onAdd();
                          },
                          width: 100,
                          height: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: railwayFontFamily,
                          fontSize: 14,
                          color: CustomColors.buttonColor,
                          shadowColor: CustomColors.buttonColor,
                          elevation: 20,
                          textColor: CustomColors.white,
                        ),
                        CustomElevatedButton(
                          text: "Exit",
                          // Login UI Functionality
                          onPressed: onExit,
                          width: 100,
                          height: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: railwayFontFamily,
                          fontSize: 14,
                          color: Colors.red,
                          shadowColor: Colors.red,
                          elevation: 20,
                          textColor: CustomColors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
      clickMaskDismiss: true,
      backDismiss: true,
      displayTime: null);
}
