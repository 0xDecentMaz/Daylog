# Logitall

#### Video Demo:  https://www.youtube.com/watch?v=ZrwGCcIHxFQ
#### Google play store: https://play.google.com/store/apps/details?id=decentmaz.android.logitall

#### Description:

Transform the way you track your daily activities with our easy-to-use app. Create and log your activities easily with just a few clicks.  
  
Features:  
  
1. Create activities with the simple + button  
2. Delete activities easily with a long press  
3. Log your activities in real time with a single click  
4. Keep all your logs organized locally with the [Activity][Date and Time] format ]  
5. Conveniently export your logs to Excel, Google Drive, or your preferred program in a comma-delimited text format.  
  
We are constantly working to improve our app and welcome any suggestions you may have for new features.  
  
Download now and keep track of your daily tasks!


#### Detailed description:

Logitall is a mobile app built in Dart using the Flutter framework, and it is designed specifically for Android devices. The app was created as the final project for CS50x, a well-known computer science course.

The app relies on an SQLite database to store and manage the activities that the user creates. When the user opens the app, all of their activities are dynamically added to the home view as elevated buttons with onclick events. When the user clicks on one of these buttons, the app logs the activity into the database, recording the name of the activity and the date and time it was performed.
To remove an activity, the user can simply long-press the corresponding button and choose to delete it.

Users can view their activity log at any time by navigating to the history view. The history view displays the activity log in a datatable, which is sorted in descending order based on the primary key of each log. This ensures that the most recent activity logs are always displayed at the top of the view.

In addition to viewing their activity log, users can also export their data as a CSV file. To do this, the app uses the csv.dart package in combination with the share_plus.dart package. This allows users to share the exported file without requiring any external storage permissions. Users can choose where to direct the file export and easily access their activity log data outside of the app.

Overall, Logitall is a user-friendly and intuitive app that helps users track and manage their daily activities.

#### Sources: 
**Database helper:** Many thanks to user manishdayma on GitHub, whose implementation of a database helper was of great help. You can find it at: [https://github.com/manishdayma/flutter_sqflite_crud/blob/main/lib/db_manager.dart](https://github.com/manishdayma/flutter_sqflite_crud/blob/main/lib/db_manager.dart)

**Formatting:** This README file and the Google Play app description were generated with the help of OpenAI's ChatGPT language model. It was a great tool to use!

#### Future updates:

Here are some features that are planned for future updates:

1.  Improve log management in the history view, allowing the user to selectively remove or update individual logs or a range of logs based on activity and date-time.
2.  Enhance the activity removal function in the home view, where the user can choose to delete the activity along with all associated logs with a long-press action.
3.  Make activities more dynamic by allowing users to add the following parameters to each activity and log:
    1.  A drop-down list with user-defined values
    2.  A free-text field with a user-defined pre-text label (e.g. "dl", "cl" or "inch")
    3.  A boolean checkbox.