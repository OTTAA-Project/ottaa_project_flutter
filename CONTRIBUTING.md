# Contributing to the OTTAA Project

We would love your help in the OTTAA Project. We have compiled this useful guide to all the ways you can collaborate. Reading it carefully before you start is important to maintain consistency in the project quality and ensure a respectful and positive environment in our community.

## Ways of contributing

- As a developer 
- As a translator 
- As a manual tester
- As an automation tester 

## As a developer

### Get started: setting up your IDE

- Run `flutter pub get` to get the dependencies.
- Run `flutter pub run build_runner build` to generate the model class code.
- Run `flutter run` to run the project.
- If you encounter any errors for model building, run `flutter packages pub run build_runner build --delete-conflicting-outputs`.

### Reporting an issue

Provide as muc information as possible about the bug. Mention the version of OTTAA Project and explain how the problem can be reproduced.

### Code Contributions

#### Submitting a pull request
In order to create a pull request is necessary

* Avoid file conflicts with the source code
* Should make a description about the characteristics to apply
* Should apply the pull request in the corresponding branch

|Branch|Description|
|---|---|
|Version| Main |
|Feature| Add new features |
|Hotfix|  Hot-fix about a version|
|Bugfix|  Bug-fix about a version|



#### Documentation

##### Comments
* Comment documenting the source code are required.

* Comment a class explaining the purpose of that and how to implements if that required.

* Comment should be formatted as proper English sentences.
* use Javadoc documentation.

#### Code

##### Duplication
* Don't copy-paste source code. Reuse it.

##### Import Libraries

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
#!xml
dependencies {
   implementation 'library'
}
```
##### Indentation


 Switch case
```
#!java
Align by  such as these cases :

Switch(value){
    case 0:
       // Todo action here
    break;
    Default:
       // Todo default action here
    break;
}
```
If / else or else if
```
#!java

if(value.toString().equals("Hello")){
  //To do action here
}else if{
  // To do action here
} else{
  // Todo
}

```
**Remember: **

* The attributes of the class must be protected or private

* The Method of the class must be public, private or protected

* The class must be public or private

### Naming ###
** Name:** That must be transparent and representative about the action to show us.

**Class:** should be nouns in UpperCamelCase, with the first letter of every word capitalized.
example :

```
#!java
public class Json(){

}
```
**variable:** 	Local variables, instance variables, and class variables are also written in lowerCamelCase.

example :

```
#!java

String name =" Carl";
String fileName="json.txt";
```

**Constant:** Constants should be written in uppercase characters separated by underscores.

example :


```
#!java

public static final String CONSTANT_NAME=" fileName.txt";
```

#### Firebase index:

This is the Three in firebase :

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

### Analytics Implementation

[Here](https://github.com/VicColombo/ottaa_project_flutter/blob/master/AnalyticsImplementation.md) is the list of events that should be tracked.

## As a translator

We currently support Spanish, English, Portuguese and French, but we are open to adding new languages as users' needs arise. Everyone is welcome to contribute with suggestions, changes or error corrections via email at **support@ottaaproject.com**, use subject "Contribution".

Our focus right now is growing in Latin America, with this in mind we would love some help with **pictogram localization**, that is to say, to have pictograms translated **based each country/region-specific culture and Spanish variety**. For example, we know that 🚗 is commonly *carro* in México but *auto* or *coche* in Argentina. 

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
