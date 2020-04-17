# Laundry Day App
Making laundry days easier!

iOS: Sage Lee (sl2364) and Daisy Shu (dds86)
Backend: Ethan Fine (ef376)
Design: Samantha Chu (sc2855)

Link to Backend Repo: https://github.com/daisyshu/LaundryDay-Backend

Brief Description:

Laundry Day is an app dedicated to making your laundry routine easier! Pick a home location and easily access a list of all washer and dryer machines available in your location. Start a timer for your machine, or report it as broken. View the current running statuses and timers of the other machines to find an open and working machine easily. create a 'to-wash' list so you don't forget your load.

iOS Requirements:

AutoLayout using NSLayoutConstraint or SnapKit:
  We implemented NSLayoutConstraints.
  
Use at least one UICollectionView or UITableView:
  Both were used! The home screen (list of machines) and detail screen (info for specific machine) utilize UICollectionViews, while the list function and list of locations (available through personal settings) utilize UITableViews.
  
Use some form of navigation (UINavigationController or UITabBarController) to navigate between screens:
  We use a UITabBarController for navigation.
  
Integrate an API - this API must provide some meaningful value to your app. For example, if you’re creating a music app, you could use the Spotify API:
  Backend created an API for us that provides a list of locations, machines for each location (and each machine's attributes).
  
Note to Grader:

The current state of the app is nowhere near its full (and intended) potential. due to the time crunch, we were unfortunately unable to implement many of our ideas and functionalities.

Where We Meant to Expand:

  - Access to CornellGet so users can see their laundry account balances (security reasons)
  - Washer/dryer filtering based upon attributes in backend (lack of time)
  - UITabBar icons (oddly buggy)
  - More thorough locations and machines (lack of time to flesh this out)
  - Proper status/time_remaining updates (again, lack of time to properly implement)
  - Checkboxes on list (buggy??)
  - Design specifics (especially in list and profile)
  
There are a lot more, but please excuse our flawed execution. Thank you for your time.
