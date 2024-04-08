import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:oktoast/oktoast.dart';

import '../../domain/models/local/task.dart';
import '../../utils/constants/Colors.dart';
import '../../utils/constants/strings.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/dialogs.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  HomeScreen({super.key});

  final scrollController = ScrollController();

  // For Edit Task
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // For Add New Task
  final TextEditingController addTaskFirstNameController =
      TextEditingController();
  final TextEditingController addTaskLastNameController =
      TextEditingController();
  final TextEditingController addTaskEmailController = TextEditingController();
  final TextEditingController addTaskAvatarController = TextEditingController();

  final GlobalKey<FormState> _checkEditTaskFormKey = GlobalKey();

  final GlobalKey<FormState> _checkAddTaskFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var HomeBlocProvider = BlocProvider.of<HomeBloc>(context);

        HomeBlocProvider.add(const HomeEventDisplayData());
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: CustomAppBar(
                  title: 'Tasks',
                  firstColor: CustomColors.darkBlue,
                  secondColor: CustomColors.primaryColor,
                  isSearchExists: false,
                  isToggleDrowerExists: false,
                  firstIcon: Icons.more_vert,
                  secondIcon: Icons.search,
                  onFirstIconClicked: () {},
                  onSecondIconClicked: () {}),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add your button onPressed logic here
                //HomeBlocProvider.add(event)

                showAddTaskDialog(
                    checkAddTaskKey: _checkAddTaskFormKey,
                    color: CustomColors.lightOrange,
                    firstNameController: addTaskFirstNameController,
                    lastNameController: addTaskLastNameController,
                    emailController: addTaskEmailController,
                    avatarController: addTaskAvatarController,
                    onAdd: () {
                      HomeBlocProvider.add(
                        HomeEventAddingTask(
                          email: addTaskEmailController.text,
                          firstName: addTaskFirstNameController.text,
                          lastName: addTaskLastNameController.text,
                          avatar: addTaskAvatarController.text,
                        ),
                      );
                    },
                    onExit: () {
                      SmartDialog.dismiss();
                    });
              },
              backgroundColor: CustomColors.primaryColor,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: BlocConsumer<HomeBloc, HomeState>(
              builder: (context, state) {
                scrollController.addListener(() {
                  _scrollListener(
                      HomeBlocProvider, state is HomeStateGettingNewPageData);
                });
                if (state is FinishGettingPageDataSuccess) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is FinishGettingPageDataFailure) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is FinishGettingNewPageDataSuccess) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is FinishGettingNewPageDataFailure) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateGettingPageData) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateGettingNewPageData) {
                  return listView(HomeBlocProvider, state.tasks, true);
                } else if (state is NoMoreDataToFitch) {
                  showToast("No more Data To Fitch");
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateDisplayData) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateEditingTask) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateEditingTaskSuccess) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateEditingTaskFailure) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateDeletingTask) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateDeletingTaskSuccess) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateDeletingTaskFailure) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateAddingTask) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateAddingTaskSuccess) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else if (state is HomeStateAddingTaskFailure) {
                  return listView(HomeBlocProvider, state.tasks, false);
                } else {
                  return Container();
                }
              },
              listener: (context, state) {
                if (state is HomeStateGettingPageData) {
                  showWaitingDialog();
                } else if (state is FinishGettingPageDataSuccess) {
                  hideWaitingDialog();
                  showNotifyDialog("Successfull Getting Data",
                      "assets/images/success.gif", CustomColors.white);
                } else if (state is FinishGettingPageDataFailure) {
                  hideWaitingDialog();
                  showNotifyDialog("Error With Getting Data",
                      "assets/images/error2.gif", CustomColors.lightOrange);
                }

                if (state is HomeStateEditingTask) {
                  showWaitingDialog();
                } else if (state is HomeStateEditingTaskSuccess) {
                  hideWaitingDialog();
                  showNotifyDialog("Successfully Editing",
                      "assets/images/success.gif", CustomColors.white);
                } else if (state is HomeStateEditingTaskFailure) {
                  hideWaitingDialog();
                  showNotifyDialog("Error With Editing Data",
                      "assets/images/error2.gif", CustomColors.lightOrange);
                }

                if (state is HomeStateDeletingTask) {
                  showWaitingDialog();
                } else if (state is HomeStateDeletingTaskSuccess) {
                  hideWaitingDialog();
                  showNotifyDialog("Successfully Deleting",
                      "assets/images/success.gif", CustomColors.white);
                } else if (state is HomeStateDeletingTaskFailure) {
                  hideWaitingDialog();
                  showNotifyDialog("Error With Deleting Data",
                      "assets/images/error2.gif", CustomColors.lightOrange);
                }

                if (state is HomeStateAddingTask) {
                  showWaitingDialog();
                } else if (state is HomeStateAddingTaskSuccess) {
                  hideWaitingDialog();
                  showNotifyDialog("Successfully Added",
                      "assets/images/success.gif", CustomColors.white);
                } else if (state is HomeStateAddingTaskFailure) {
                  hideWaitingDialog();
                  showNotifyDialog("Error With Adding Data",
                      "assets/images/error2.gif", CustomColors.lightOrange);
                }
              },
            ));
      },
    );
  }

  void _scrollListener(HomeBloc bloc, bool isLoadingMore) {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      bloc.add(const HomeEventGetNewPage());
    }
  }

  Widget listView(HomeBloc bloc, List<Task> tasks, bool isLoadingMore) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            const Duration(microseconds: 200),
            () {
              bloc.add(const HomeEventGetPage(1));
            },
          );
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(15),
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < tasks.length) {
              return TaskCard(
                email: tasks[index].email,
                first_name: tasks[index].firstName,
                last_name: tasks[index].lastName,
                avatar: tasks[index].avatar,
                editTask: () {
                  firstNameController.text = tasks[index].firstName;
                  lastNameController.text = tasks[index].lastName;
                  emailController.text = tasks[index].email;
                  showEditTaskDialog(
                    checkEditTaskKey: _checkEditTaskFormKey,
                    color: CustomColors.lightOrange,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    emailController: emailController,
                    onSave: () {
                      SmartDialog.dismiss();
                      bloc.add(
                        HomeEventEditTask(
                          taskNumber: tasks[index].id!,
                          email: emailController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                        ),
                      );
                    },
                    onExit: () {
                      SmartDialog.dismiss();
                    },
                  );
                },
                deleteTask: () {
                  bloc.add(HomeEventDeletingTask(tasks[index].id!));
                },
                titleTextStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontFamily: railwayFontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                nameTextStyle: const TextStyle(
                    color: CustomColors.gray,
                    fontFamily: railwayFontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          itemCount: isLoadingMore ? tasks.length + 1 : tasks.length,
        ));
  }
}
