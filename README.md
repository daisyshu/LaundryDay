# Laundry Day App
making laundry day easier!

iOS: Sage Lee (sl2364) and Daisy Shu (dds86)
backend: Ethan Fine (ef376)
design: Samantha Chu (sc2855)

link to backend repo: https://github.com/usubzero/Laundry-App-Backend

brief description

laundry day is an app dedicated to making your laundry routine easier! pick a home location and easily access a list of all washer and dryer machines available in your location. start a timer for your machine, or report it as broken. view the current running statuses and timers of the other machines to find an open and working machine easily. create a 'to-wash' list so you don't forget your load.

iOS requirements

AutoLayout using NSLayoutConstraint or SnapKit:
  we implemented NSLayoutConstraints.
  
Use at least one UICollectionView or UITableView:
  both were used! the home screen (list of machines) and detail screen (info for specific machine) utilize UICollectionViews, while the list function and list of locations (available through personal settings) utilize UITableViews.
  
Use some form of navigation (UINavigationController or UITabBarController) to navigate between screens:
  we use a UITabBarController for navigation.
  
Integrate an API - this API must provide some meaningful value to your app. For example, if you’re creating a music app, you could use the Spotify API.:
  backend created an API for us that provides a list of locations, machines for each location (and each machine's attributes).
  
note to grader

the current state of the app is nowhere near its full (and intended) potential. due to the time crunch, we were unfortunately unable to implement many of our ideas and functionalities.

where we meant to expand

  - access to CornellGet so users can see their laundry account balances (security reasons)
  - washer/dryer filtering based upon attributes in backend (lack of time)
  - UITabBar icons (oddly buggy)
  - more thorough locations and machines (lack of time to flesh this out)
  - proper status/time_remaining updates (again, lack of time to properly implement)
  - checkboxes on list (buggy??)
  - design specifics (especially in list and profile)
  
there are a lot more, but ... that's the gist. please excuse our flawed execution, and thank you for your time.
