# quizzy

**Created by: Kristen Chen**

Quizzy is intended to be a trivia/quiz app. Users can log in, play games in different categories, and view their statistics. 

<img src="/README_images/startquiz.png" width="250"> <img src="/README_images/player_stats.png" width="250">
<img src="/README_images/questions.png" width="250"> <img src="/README_images/answeres_reveal.png" width="250">

## Files

### Views

**ContentView**:  If a user is logged in, it allows users to navigate through the game page, player stats page, or their own profile. If a user is not logged in, they can log in or sign up. 

**LoginView**: Allows user to sign in via email and password.

**OpenAppView**: If a user isn't signed in, they can either sign up for an account or log in. 

**SignUpView**: Allows user to sign up via email and password.

**GameView**:  Before a game begins, the user can pick the game category and number of questions. Then the user progresses through the questions. After all the questions, the user gets a summary of how they scored. 

**StatsView**: Shows player statistics.

**ProfileView**:  Shows the user's email and allows the user to log out.

**Modifiers**:  All the custom modifiers and button styles used throughout the views.

### ViewModels

**GameViewModel**: View Model for GameView (handles user interactions)

**StatsViewModel**: View Model for StatsView (handles user interactions)

### Models

**Game**: Game Model. Retrieves questions from API and saves back to database.

**QuestionSet**: Turns the JSON questions into the QuestionSet Codable struct.

**GameRepository**:  Handles saving and retrieving games from the database.

**CompletedGame**: Game information that needs to be saved to database. 

**Constants**: Random constants used throughout the views.

**User**: User information

### Other

**SessionStore**: Handles user authentication (log in, log out, sign up)

## APIs, Libraries or Frameworks

**Trivia API**: https://opentdb.com/api_config.php

**Alamofire**: retrieves JSON from API

**SwiftyJSON**: handles JSON after retrieval

**Firebase**: manages sign in/up, database

**Resolver**:  handles repository

**ChartViewLibrary**: Used to create the charts in statsView

