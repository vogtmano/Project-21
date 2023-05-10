# Project 21 - Local Notifications

Days 72-73 of 100 Days Of Swift

https://www.hackingwithswift.com/100

## Topics

Day 72: UNUserNotificationCenter, requesting permission for notifications, and the different kinds of notification trigger.

## Challenges

Day 73:

1. Update the code in didReceive so that it shows different instances of UIAlertController depending on which action identifier was passed in.
2. For a harder challenge, add a second UNNotificationAction to the alarm category of project 21. Give it the title “Remind me later”, and make it call scheduleLocal() so that the same alert is shown in 24 hours. (For the purpose of these challenges, a time interval notification with 86400 seconds is good enough – that’s roughly how many seconds there are in a day, excluding summer time changes and leap seconds.)
3. And for an even harder challenge, update project 2 so that it reminds players to come back and play every day. This means scheduling a week of notifications ahead of time, each of which launch the app. When the app is finally launched, make sure you call removeAllPendingNotificationRequests() to clear any un-shown alerts, then make new alerts for future days.

## Screenshots

<img src="https://github.com/vogtmano/Project-21/assets/92689831/6866e174-b2b6-48fd-b332-954fabcb85d0" width=300 height=520>

<img src="https://github.com/vogtmano/Project-21/assets/92689831/c9a0037e-78ae-426f-9fca-1e7f60d38199" width=300 height=520>
