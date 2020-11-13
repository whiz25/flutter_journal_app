# SPECIFICATIONS
  ## USER STORIES
  - A user should be able to log into the app using their email and password
  - A user should be able to log in anonymously if they don't have an account
  - A user should be able to log out of the app
  - A user should be able to signup for an account using email and password
  - A user should be able to create a journal
  - A user should be able to edit a journal
  - A user should be able to delete a journal 
  - A user should be able choose a background color for a journal
  - A default background color should be automatically assigned
  to a journal if a user doesn't choose one
  - A user should be able to change the theme of the app from 
  light to dark and vice versa

# DESIGN
  ## MODELS
  ### User Model 
  - A UserModel class with final fields of id and email. The id and email fields are of type string
  #### Methods
  - toEntity - This method converts a user model to a user entity. This method is called when signing up a user.
  This method is of type UserEntity
  - fromEntity - This a factory constructor method converts a firebase document to a user model object. This
  method is called when loging in a user
  - props - This class extends Equatable. This allows us to compare instances of a user object. Props is an inherited method
  - toString - This method helps in debuging a user object. This prints to the console the user object

  ### Note Model 
  - A NoteModel class with final fields of id, userId, content, color, timestamp. The fields of id, userId, content and color
  are of type string while the timestamp is of type DateTime
  #### Methods 
  - toEntity - This method converts the note model object to a note entity object. This method is called when adding a new note.
  This method is of type NoteEntity
  - fromEntity - This is a factory method that returns a note model from a note entity. This method is called to return 
  a note object from firebase document
  - props - This class extends Equatable. This allows us to compare instances of a note object. Props is an inherited method
  - toString - This method helps in debuging a note object. This prints to the console the note object

  ## ENTITIES
  ### User Entity 
  - A UserEntity class is responsible for converting a firebase document to a user model object. This class is
  very useful when the data source changes from firebase to something like mongodb. Only this class will change
  while the user model class will remain the same. This minimizes bugs
  #### Methods
  - toDocument - This is factory constructor method that converts a user model object to firebase snapshot 
  document type
  - fromDocument - This is also a factory constructor method that converts a firebase snapshot document to 
  a user model object

  ### Note Entity 
  - A NoteEntity class is responsible for converting a firebase document to a note model object. This class is 
  very useful when the data source changes from firebase to something like mongodb.Only this class will change 
  while the note model class will remain the same. This minimizes bugs
  #### Methods
  - toDocument - This is factory constructor method that converts a note model object to firebase snapshot 
  document type
  - fromDocument - This is also a factory constructor method that converts a firebase snapshot document to 
  a note model object

  ## BLOCS

  ## REPOSITORIES

  ## SCREENS

  ## WIDGETS

  ## CONSTANTS

  ## HELPERS

  ## PACKAGES
