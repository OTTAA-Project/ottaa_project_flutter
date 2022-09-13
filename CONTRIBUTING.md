# Contributing to the OTTAA Project

We would love your help in the OTTAA Project. We have compiled this useful guide to all the ways you can collaborate. Reading it carefully before you start is important to maintain consistency in the project quality and ensure a respectful and positive environment in our community.

## Table of contents

1. [Ways of contributing](#Ways-of-contributing)
2. [As a developer](#As-a-developer)
  * [Setting up your IDE](#Setting-up-your-IDE)
  * [Reporting an issue](#Reporting-an-issue)
  * [Submitting a pull request](#Submitting-a-pull-request)
  * [Code conventions](#Code-conventions)
  * [Analytics implementation](#Analytics-implementation)
4. [As a translator](#As-a-translator)
5. [As a manual tester](#As-a-manual-tester)
6. [As an automation tester](#As-an-automation-tester)
7. [Code of conduct](#Code-of-conduct)


<div id="toc_container">
<p class="toc_title">Contents</p>
<ol class="toc_list">
  <li><a href="#Ways_of_contributing">Ways of contributing</a>
  <li><a href="#As_a_developer">As a developer</a></li>
  <ol>
    <li><a href="#Setting_up_your_IDE">Setting up your IDE</a></li>
    <li><a href="#Reporting-an-issue">Reporting an issue</a></li>
  </ol>
</li>
<li><a href="#Second_Point_Header">2 Second Point Header</a></li>
<li><a href="#Third_Point_Header">3 Third Point Header</a></li>
</ol>
</div>

## Ways of contributing

- As a developer 
- As a translator 
- As a manual tester
- As an automation tester 

## As a developer

### Setting up your IDE

- Run `flutter pub get` to get the dependencies.
- Run `flutter pub run build_runner build` to generate the model class code.
- Run `flutter run` to run the project.
- If you encounter any errors for model building, run `flutter packages pub run build_runner build --delete-conflicting-outputs`.

### Reporting an issue

Any bug or hotfix that results from manual testing should be reported via an [issue](https://github.com/OTTAA-Project/ottaa_project_flutter/issues) in our GitHub repository **using the [template]**(https://github.com/OTTAA-Project/ottaa_project_flutter/issues/new?assignees=&labels=&template=bug_report.md&title=) for bug reporting and **providing as much information as possible** about the bug, including: used **version of OTTAA** and/or **version of web navigator** and clear instructions on how to **reproduce** the bug.


### Submitting a pull request

Please bear the following in mind when creating a PR:

* Avoid file conflicts with the source code.
* Make a detailed description about the features it applies to.
* Make the PR in the corresponding branch.
* Avoid your PR containing unrelated commits, keep it focused on its scope. 

|Branch|Description|
|---|---|
|Version| Main |
|Feature| Add new features |
|Hotfix|  Hot-fix about a version|
|Bugfix|  Bug-fix about a version|


### Code conventions

#### On commenting

* Comments should always be full English sentences.

* As a default, always document the source code via clear comments.

* Comment all your classes explaining their purpose and how to implement them if required.

#### On code duplication

* Don't copy-paste source code. Reuse it in a  way that makes sense, re writing the neccessary parts.


#### On importing libraries 

* Sort by category.

|Category|Description|
|--------|-----------|
| Google | Library related to google |
| Android | Library related to android |
|Firebase | Library related to firebase api|
|Test |Library related to test app|
| Library | Library related to different apps|

* Sort by alphabetical order.

* Use Grandle level app

 Example :
```

```
#### On indentation


 Switch case
```

```
If / else or else if
```

```

#### On classes

* The attributes of the class must be protected or private.

* The Method of the class can be public, private or protected.

* The class can be public or private.

* Class name must be transparent and representative of its purpose.

* Class names should be nouns in UpperCamelCase, with the first letter of every word capitalized.

Example :

```

```
#### On variables

* Local variables, instance variables, and class variables should be written in lowerCamelCase: with the exception of the first world, the first letter of every word should be capitalized.

example :

```

```

#### On constants

* Constants should be written in UPPERCASE with words separated by underscores.

example :


```

```

#### Firebase index:

This is the firebase tree index:

```
#!code

index
├── Edad
├── email
├── Fotos
|    ├── nombre_foto
|    └── url_foto
├── FotosUsuario
├── Frases
├── Grupos
├── Juegos
├── Pago
├── Pictos
├── PrimeraUltimaConexion
└── Usuarios
```

### Analytics implementation

[Here](https://github.com/VicColombo/ottaa_project_flutter/blob/master/AnalyticsImplementation.md) is the list of events that should be tracked.

## As a translator

We currently support Spanish, English, Portuguese and French, but we are open to adding new languages as users' needs arise. Everyone is welcome to contribute with suggestions, changes or error corrections via email at **support@ottaaproject.com**, use subject "Contribution".

Our focus right now is growing in Latin America, with this in mind we would love some help with **pictogram localization**, that is to say, to have pictograms translated **based each country/region-specific culture and Spanish variety**. For example, we know that a car 🚗 is commonly *carro* in México but *auto* or *coche* in Argentina. 

Chile, Argentina, Colombia, and the Caribbean are our current priorities, but of course we welcome help with any of our supported languages and regions.


## As a manual tester

We have test cases for manual testing [here](https://docs.google.com/document/d/1khElUEbtREVsTzwxKmLYfdDYJxCnz0zcNaIraRYaMGs/edit) and we mainly need help testing the overall functionality of the new Flutter version.

Any bug or hotfix that results from manual testing should be reported via an [issue](https://github.com/OTTAA-Project/ottaa_project_flutter/issues) in our GitHub repository using the [template](https://github.com/OTTAA-Project/ottaa_project_flutter/issues/new?assignees=&labels=&template=bug_report.md&title=) for bug reporting.


## As an automation tester 

We will be implementing a continuous integration workflow that will be running multiple automated testing. In the meantime, any experience with CI/CD and automated testing in Dart is very much welcome. Feel free to contact us at **support@ottaaproject.com**.

## Code of Conduct

### OTTAA Project Open Source Code of Conduct

In order to work in the  OTTAA Project in a collaborative way and help our community grow we ask you to comply with the following code of conduct..

** Diversity makes us  grow : **  We truly believe that every user’s or developer’s age, gender, nationality, race or sexual orientation provide content based on a plurality of experiences and knowledge that contribute to the construction of a complete tool which reflects the real needs of potential users of the OTTAA Project.

** Debate enriches us : ** As we consider that everyone can  contribute significantly to improving the software we seek to establish mutual respect among the members of the community, reaching a consensus among the developers and solving the problem in the best way possible.

It is necessary to comply with the following  guidelines in our conduct code:

* **Refraining from discriminating .**
* **Avoiding posting pornographic content.**
* **Refraining from publishing the user’s details or relevant  information.**
* **Refraining from making  heavy jokes.**
* **Avoiding insults**
* **Refraining from judging others on there religions or race**

### Reporting breaches to the code of conduct

In the case of any violation of our code of conduct, it should be reported as follows:
Share your contact details

* **Send a screenshot of the situation**
* **Explain the situation in as much detail as possible**
* **Send the email to the following address : support@ottaaproject.com**

After the  revision of the report, the team assigned to analyze the case will carry out the following actions:

* **Notify the user of the breach**
* **devise a way for the user to amend that attitude.**

the user can be expelled from the community in the following situation :

* **Repeated conduct**
* **Posting of pornographic content**
