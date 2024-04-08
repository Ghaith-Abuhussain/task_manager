import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../blocs/signup/signup_event.dart';
import '../widgets/arc_bacground.dart';
import '../../presentation/blocs/signup/signup_bloc.dart';
import '../../presentation/blocs/signup/signup_state.dart';
import '../../utils/constants/colors.dart';
import '../../presentation/widgets/custom_edit_text.dart';
import '../../presentation/widgets/custom_elevated_button.dart';
import '../../config/router/router.dart';
import '../widgets/dialogs.dart';
import '../widgets/phone_number_edit_text.dart';
import '../widgets/custom_dropdown_menu.dart';
import '../../utils/constants/values.dart';
import '../widgets/custom_back_button.dart';
import '../../utils/constants/strings.dart';

// Screens
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/register';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sureNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _signUpFormKey = GlobalKey();
  SignUpScreen({super.key});

  bool _chechValidation() {
    final isValid = _signUpFormKey.currentState?.validate();
    if (!isValid!) {
      return false;
    }
    _signUpFormKey.currentState?.save();
    return true;
  }

  String? choosedGenderValue = '';
  String? chooseCityValue = '';
  String completeNumberValue = '';


  @override
  Widget build(BuildContext context) {
    var signupBlocProvider = BlocProvider.of<SignUpBloc>(context);
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: BlocConsumer<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ArcBackground(
                          height: 300,
                          originHeigth: 200,
                          child: ClipRRect(
                            child: Image.asset(
                              "assets/images/task_signup.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        CustomBackButton(
                          icon: Icons.arrow_back_sharp,
                          onPressed: () {
                            navigateToPrevious(context);
                          },
                          color: Colors.transparent,
                          iconSize: 24,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          padding: const EdgeInsets.all(16),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 250),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                fontFamily: 'RobotoCondes',
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: CustomColors.darkBlue),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "create your account",
                      style: TextStyle(
                          fontFamily: 'RobotoCondes',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: CustomColors.darkBlue),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CustomEditText(
                                  label: 'Name',
                                  controller: _nameController,
                                  validator: (_) {
                                    if (_nameController.text
                                        .trim()
                                        .isEmpty) {
                                      return 'Must Enter Value Here !!!';
                                    }
                                    return null;
                                  },
                                  icon: Icons.drive_file_rename_outline,
                                  focusedBorderSideColor:
                                      CustomColors.primaryColor,
                                  defaultBorderSideColor:
                                      CustomColors.darkBlue,
                                  textStyle: const TextStyle(
                                      color: CustomColors.darkBlue),
                                  width: MediaQuery.of(context).size.width *
                                          (4 / 10) -
                                      15,
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                ),
                                CustomEditText(
                                  label: 'Surname',
                                  controller: _sureNameController,
                                  validator: (_) {
                                    if (_sureNameController.text
                                        .trim()
                                        .isEmpty) {
                                      return 'Must Enter Value Here !!!';
                                    }
                                    return null;
                                  },
                                  icon: Icons.drive_file_rename_outline,
                                  focusedBorderSideColor:
                                      CustomColors.primaryColor,
                                  defaultBorderSideColor:
                                      CustomColors.darkBlue,
                                  textStyle: const TextStyle(
                                      color: CustomColors.darkBlue),
                                  width: MediaQuery.of(context).size.width *
                                          (4 / 10) -
                                      15,
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PhoneNumberEditText(
                            label: 'Phone',
                            initialCountryCode: 'SY',
                            controller: _phoneNumberController,
                            textStyle:
                                const TextStyle(color: CustomColors.darkBlue),
                            defaultBorderSideColor: CustomColors.darkBlue,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                            onChange: (PhoneNumber phone) {
                              completeNumberValue = phone.completeNumber;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomDropDownMenu(
                            label: 'City',
                            onChange: (newValue) {
                              chooseCityValue = newValue;
                            },
                            valuesList: syrianCities,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 30),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            textStyle:
                                const TextStyle(color: CustomColors.darkBlue),
                            defaultBorderSideColor: CustomColors.darkBlue,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            label: 'Address',
                            controller: _addressController,
                            validator: (_) {
                              if (_addressController.text.trim().isEmpty) {
                                return 'Must Enter Value Here !!!';
                              }
                              return null;
                            },
                            icon: Icons.account_circle,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                            defaultBorderSideColor: CustomColors.darkBlue,
                            textStyle:
                                const TextStyle(color: CustomColors.darkBlue),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            label: 'Username',
                            controller: _usernameController,
                            validator: (_) {
                              if (_usernameController.text.trim().isEmpty) {
                                return 'Must Enter Value Here !!!';
                              }
                              return null;
                            },
                            icon: Icons.account_circle,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                            defaultBorderSideColor: CustomColors.darkBlue,
                            textStyle:
                                const TextStyle(color: CustomColors.darkBlue),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            label: 'Email',
                            controller: _emailController,
                            validator: (_) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_emailController.text);
                              if (_emailController.text.trim().isEmpty) {
                                return 'Must Enter Value Here !!!';
                              }
                              if (!emailValid) {
                                return 'Not a correct email address !!!';
                              }
                              return null;
                            },
                            icon: Icons.email,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                            defaultBorderSideColor: CustomColors.darkBlue,
                            textStyle:
                                const TextStyle(color: CustomColors.darkBlue),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            label: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                            validator: (_) {
                              if (_passwordController.text.trim().isEmpty) {
                                return 'Must Enter Value Here !!!';
                              }
                              return null;
                            },
                            icon: Icons.lock,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                            defaultBorderSideColor: CustomColors.darkBlue,
                            textStyle:
                                const TextStyle(color: CustomColors.darkBlue),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            label: 'Confirm Password',
                            controller: _confirmPasswordController,
                            obscureText: true,
                            validator: (_) {
                              if (_confirmPasswordController.text
                                  .trim()
                                  .isEmpty) {
                                return 'Must Enter Value Here !!!';
                              }
                              if (_confirmPasswordController.text.trim() !=
                                  _passwordController.text.trim()) {
                                return 'Please enter the same password value !!!';
                              }
                              return null;
                            },
                            icon: Icons.password_rounded,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                            defaultBorderSideColor: CustomColors.darkBlue,
                            textStyle:
                                const TextStyle(color: CustomColors.darkBlue),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Be registering, you are agreeing to our\nTerms of use Privacy policy',
                      style: TextStyle(
                          fontFamily: 'RobotoCondes',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: CustomColors.darkBlue),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                      text: "REGISTER",
                      // Login UI Functionality
                      onPressed: () {
                        if (!_chechValidation()) {
                          return;
                        }

                        signupBlocProvider.add(
                          SignUpEventSignUp(
                            name: _nameController.text,
                            surname: _sureNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            dateOfBirth: _dateOfBirthController.text,
                            gender: choosedGenderValue!,
                            city: chooseCityValue!,
                            address: _addressController.text,
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                      width: 240,
                      height: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: railwayFontFamily,
                      fontSize: 20,
                      color: CustomColors.primaryColor,
                      shadowColor: CustomColors.primaryColor,
                      elevation: 20,
                      textColor: CustomColors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontFamily: 'RobotoCondes',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: CustomColors.darkBlue),
                        ),
                        TextButton(
                          onPressed: () {
                            navigateToRouteReplacement(
                                context, LoginScreen.routeName);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: CustomColors.buttonColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontFamily: railwayFontFamily,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
              listener: (context, state) {
                if (state is SignUpStateWaitingForSignUp) {
                  showWaitingDialog();
                } else if (state is SignUpStateSignUpSuccess) {
                  hideWaitingDialog();
                  showNotifyDialog(
                      "Successfull Sign Up", "assets/images/success.gif", CustomColors.white);
                } else if (state is SignUpStateSignUpFailure) {
                  hideWaitingDialog();
                  showNotifyDialog(
                      "Error With Sign Up", "assets/images/error2.gif", CustomColors.lightOrange);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
