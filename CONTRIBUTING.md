# Contributing to the OTTAA Project

We would love your help in the OTTAA Project. We have compiled this useful guide to all the ways you can collaborate. Reading it carefully before you start is important to maintain consistency in the project quality and ensure a respectful and positive environment in our community.

## Table of contents

<div id="toc_container">
<p class="toc_title">Contents</p>
<ol class="toc_list">
  <li><a href="#Ways-of-contributing">Ways of contributing</a>
  <li><a href="#As-a-developer">As a developer</a></li>
  <ol>
    <li><a href="#Setting-up-your-IDE">Setting up your IDE</a></li>
    <li><a href="#Reporting-an-issue">Reporting an issue</a></li>
    <li><a href="#Submitting-a-pull-request">Submitting a pull request</a></li>
    <li><a href="#Code-conventions">Code conventions</a></li>
    <li><a href="#Analytics-implementation">Analytics implementation</a></li>
  </ol>
</li>
<li><a href="#As-a-translator">As a Translator</a></li>
<li><a href="#As-a-manual-tester">As a manual tester</a></li>
<li><a href="#As-an-automation-tester">As an automation tester</a></li>
<li><a href="#On-our-code-of-conduct">Code of conduct</a></li>
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

Any bug or hotfix that results from manual testing should be reported via an [issue](https://github.com/OTTAA-Project/ottaa_project_flutter/issues) in our GitHub repository using the **[template](https://github.com/OTTAA-Project/ottaa_project_flutter/issues/new?assignees=&labels=&template=bug_report.md&title=)** for bug reporting and **providing as much information as possible** about the bug, including: used **version of OTTAA** and/or **version of web navigator** and clear instructions on how to **reproduce** the bug.


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

[Here](/analytics_implementation.md) is the list of events that should be tracked.

## As a translator

We currently support Spanish, English, Portuguese and French, but we are open to adding new languages as users' needs arise. Everyone is welcome to contribute with suggestions, changes or error corrections via email at **support@ottaaproject.com**, use subject "Contribution".

Our focus right now is growing in Latin America, with this in mind we would love some help with **pictogram localization**, that is to say, to have pictograms translated **based each country/region-specific culture and Spanish variety**. For example, we know that a car 🚗 is commonly *carro* in México but *auto* or *coche* in Argentina. 

Chile, Argentina, Colombia, and the Caribbean are our current priorities, but of course we welcome help with any of our supported languages and regions.


## As a manual tester

We have test cases for manual testing [here](https://docs.google.com/document/d/1khElUEbtREVsTzwxKmLYfdDYJxCnz0zcNaIraRYaMGs/edit) and we mainly need help testing the overall functionality of the new Flutter version.

Any bug or hotfix that results from manual testing should be reported via an [issue](https://github.com/OTTAA-Project/ottaa_project_flutter/issues) in our GitHub repository using the [template](https://github.com/OTTAA-Project/ottaa_project_flutter/issues/new?assignees=&labels=&template=bug_report.md&title=) for bug reporting.


## As an automation tester 

We will be implementing a continuous integration workflow that will be running multiple automated testing. In the meantime, any experience with CI/CD and automated testing in Dart is very much welcome. Feel free to contact us at **support@ottaaproject.com**.

## On our code of conduct

Please read through our [code of conduct](CODE_OF_CONDUCT.md) before contributing.


