# task_managing

Task Manager Application (Demo App)
This application is built using Flutter 3.19.0. The main purpose is to achieve many Key Features like:
1. User Authentication: Implemented using the /api/login endpoint from reqres.in. Both Login and Sign Up functionalities are implemented using Retrofit package. The remember user functionality is also implemented.
2. Task Management: VIEW, ADD, EDIT, and DELETE functionalities are implemented using /api/users endpoint and Retrofit package.
3. Pagination: This is done using Retrofit and ListView Scroll Listener.
4. State Management: Bloc architectural pattern is used for state management.
5. Local Storage: Floor Database is used to store the tasks after fetching them from the endpoint and after the update and deletion of any task.
6. Unit Testing: many unit tests are written using Mockito to test the CRUD operations in many situations like (no internet connection, and error fetching data from the server).

The project is structured into data, domain, and presentation layers using Clean Architecture. The presentation layer is responsible for displaying the data and contains many Screens:
-LoginScreen.
-SignUpScreen.
-HomeScreen.
each screen is connected to a Bloc Provider which runs the business logic (accepting events and emitting states).
The domain layer contains the models (the requests, the responses, and the local database entities) it also contains the interfaces of the app repositories.
the data layer contains the implementations of the local and remote repositories. It is responsible for fetching the data from the database and the remote endpoints.

How the app works:
when the user runs the app a screen will show up and the user can choose between logging in or signing up. If he chooses to sign up the app will transfer him/her to another screen to enter the user information, email, and password. Verification 
of the correction form of the email is applied. Note (the API returns true only when the user uses one of the predefined emails in the reqres API).
If the user chooses login the app will transfer him to a login screen and there he must enter the email (one of the predefined emails in reqres API only) and the password then hit Login. On the login page, the user can check the Remember me 
checkbox to remember the email and the password if the login was successful.
After login, the user will be transferred to the HomeScreen where he will be able to view the tasks (in our case "the users" when we use /api/users/page=x API). The user can notice that there are only 6 tasks but if he scrolls down to the last one
the pagination will be activated and the app will fetch the second page until there is no data to fetch then the app will show a Toast to inform the user.
Each task card contains two buttons one to delete the task after calling the /api/users/x DELETE api. and another one shows the user a dialog to edit the info of the task using /api/users/x PUT api.
in the bottom right of the screen, there is a button that shows the user a dialog to enter new info to add a new task using the /api/users POST api.
If the user scrolls up to the first task the Refresh Indicator will update the tasks by calling the first page from the remote endpoint and after this call, the database will be empty and refulled with the new data.
To achieve Persisting tasks locally a Floor database is used and the database is updated after fetching the data, updating it, and adding new tasks.
A 12-unit tests are done using Mokito to test the CRUD operations in many situations like (no internet connection, or error fetching data from the server).

You can watch a demo video of the application in the following Google Drive link:
https://drive.google.com/file/d/1bywJCIWIPIp-Zm0b35_GM4EJNCuBeohF/view?usp=sharing

To run the app just download the project from the GitHub repository:
https://github.com/Ghaith-Abuhussain/task_manager.git

and run the command:
flutter run -d [Targat Name]

 

samples, guidance on mobile development, and a full API reference.
