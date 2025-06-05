# Login Demo App

## Overview
This is a small mobile app that makes RESTFUL API requests and simulates a login authentication workflow.


**Clone the Repository**
   ```bash
   git clone https://github.com/airtimeEnthusiast/HelloLogin.git
   cd your-rep
   ```

## 🚀 How To Run

### 1. Run the Mock API Server
	
1.	Start the server:

```bash
npm start
```

3.	The server will be running at:

```
http://localhost:3000
```
#### 2. Open .xcodeproj 
1. 	Run LoginDemo from a mobile phone or iOS Simulator.

### Assumptions
- The iOS App utilized standard MVVM architecture where all views that handle data flow contain functions and variables to change the state of the view.
- The API server returns a fake JWT upon a successful POST of the credentials from the login screen.
- It is optimized for the API dataset and may need refinement to scale.



### Improvements
- Develop a strategy pattern to the Item and Users list to reduce code.
- Add asynchronous loading of data even when the view isn't being presented.
- Create more UI tests to create better code coverage and edge cases.
- Improve error handling for more edge cases such as having invalid credentials
- Refactor some views such as the detail views into smaller components to enhance readability.
- Enhance the visual design, as many elements were created with a purely functional focus.
- Improve accessibility by adding VoiceOver support and better tab indexing.
- Improve security by encrypting credential payloads and tokens between the app and API.
- Add encryption to the file manager and credentials.


### Trade-Offs
- Local caching is fine for data that does not change often but it can create version conflicts if not updated regularly
- While strategy pattern might improve code reusability it can make it harder to trace and debug.
- Creating more UI tests might slow down production if UI changes during the development stages.



