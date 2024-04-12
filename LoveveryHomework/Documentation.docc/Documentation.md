# ``LoveveryHomework``

Messages application on iOS for homework test to lovevery

## Overview

This application is created only for proved my knolage in iOS (SwiftUI), it is a 
application to post message in topics and show the messages by user and by topic.

In this documentation I'm goin to explain the follow steps to complete 
the assessment and describe some features 
that we can add later like automatitation.


## Topics

### Tasks

1 Fetch API
2 Show all messages
3 Show messages by User
4 Post messages

### Additional Requirements: 📦 ⚙️

Handler errors
Show all messages by Topic
Design App


### Thoughts and roadmap 💭
After read the requirements of the application, and known the app was about messages, the first thing I though was all the messaging apps that I use like messages of apple, slack, messenger of Facebook and WhatsApp.

I decided to make a Figma accordingly with the research I made of the applications. I decided to make a clean design.

Second I made a collection on insomnia for test the API. This help me to explore all the apis and know the return of the data.

Finally I started to develop the application


### Folders:
Architecture MVVM

 ViewModel: Handler all the business logic, connect the model with the View
 View: Shows the components who is going to see the user
 Models: The Model represents simple data.


### Thinking about automatisation:

My first thinks is use Jenkins as a CI/CD pipeline to automate testing and deployment, uncluding all the unit tests created in this project, with the help of Fastlane to run depending of the environment.

Use a cloud platform to install Jenkins with this guide: https://www.jenkins.io/doc/book/installing/.

In Jenkins add the pipeline and edit the scripts adding dirrefente stages.
Considering the basic steps would be:

Checkout Code: fetch for main or develop from Github.
Build and Test: run all test cases
Deploy: trigger conditionally based on an environment variable addingl Fastlane

//: ![image from google](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*gulkuCdiQ32NVHoN4MOiXA.png)


⌨️ with ❤️ by BodoqueZorrilla 😊
