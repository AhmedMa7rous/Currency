<h1 align="center"> iOS Technical Assessment </h1>

## Note that:

- Start your review from solution steps section because the first and the second I wrote it from the task documentation but I wrote it here to document this work for myself.
- Check task [Github project](https://github.com/users/AhmedMa7rous/projects/11).
- Chech each commit messege.
- Don't forget to send me your feedback I really want this feedback.

# Table of Content
- [About Task](#about-task)
- [Features](#features)
- [Solution Steps](#solution-steps)


# About Task
  ### OverView
  Currency App gives you some data for currencies and other features like convert currencies rates using [APILayer API](https://apilayer.com/).

  
# Features
### This app provide some features for you
1. You can check if your IBAN number is valid or not.
     - If valid the ui will animate to top and shows you a list of currencies rates according to KWD currency.
     - if not valid you will see an alert to notify you that your IBAN is invalid.
2. As your IBAN valid you will see a Currency Converter Button when press this button it takes you to an awesome currency converter tool to convert any amout of a specific currency to another one.



# Solution Steps

### Code Linting
I used code linting in this task, this what I made:
- Naming: used [camel Case style](https://en.wikipedia.org/wiki/Camel_case).
    - Functions Naming: should start with verb that explain it's role. 
    - Functions Body: should be 9 or 15 lines if it exceed should split the code to 2 functions {There's exceptions for some functions}.
- Patterns: [MVVM](https://www.geeksforgeeks.org/mvvm-model-view-viewmodel-architecture-pattern-in-android/) and [Singletone](https://refactoring.guru/design-patterns/singleton).
- Software Development Methodologies: Agile Methodologies (SRUM Methodology)
- Each file has sections made by "MARK:" comment each section contains the data for it's role.
- Each file related with UI contains a function named "updateUi()" this function responsible for any thing related with UI and beside it there's many support functions that support it to achieve its role.
- Version Control: Github.
    - Each commit message in this task repo contains two parts.
        - the first is name of the task.
        - the second is Github Issue ID.
- In implementation phase must achieve seperation of concerns for applying the architecture well.
- Use generics for thos classes that you will reuse it many times.
- Make extension for cell identifier to avoid spelling mistakes.
  
### Check API 
I used [Postman](https://www.postman.com/) for that. You can check this [Postman Collection](https://www.postman.com/gomini-app/workspace/public-workspace/collection/18620351-2f31d14b-a69a-434f-8b49-91a102cf343c?action=share&creator=18620351) to see API requests which I used.

##  
<h2 align="center"> Thank you for this awesome task and I will do my best to be join you team to learn alote from you. Thanks again</h2>

