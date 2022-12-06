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

<li><a href="#As-a-translator">As a Translator</a></li>
<li><a href="#As-a-manual-tester">As a manual tester</a></li>
<li><a href="#As-an-automation-tester">As an automation tester</a></li>
<li><a href="#On-our-code-of-conduct">Code of conduct</a></li>
</ol>
</div>

## Ways of contributing

You may contribute to OTTAA

- as a developer; 
- as a translator; 
- as a manual tester;
- as an automation tester. 

## As a developer

### Required knowledge (placeholder)

In order to contribute as a developer, you will need to have a basic understanding of [this/these coding languge/s] and [this/these tool/s (could be a framework, library, platform)]. We also strongly recommend you be familiar with [these language/technology that might not be as important as the other two mentioned but is still important] .

#### Setting up your IDE

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


#### Commits

We use the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for our commit messages. Under this convention the commit message should be structured like this:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Bear in mind:

1) Type *fix:*: patches a bug in your codebase.
2) Type *feat:*: introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
3) Types other than *fix:*: and *feat:*: are allowed, for example *build:*, *chore:*, *ci:*, *docs:*, *style:*, *refactor:*, *perf:*, *test:*.
4) Footer BREAKING CHANGE or *!* after type/scope: introduces a breaking API change (correlating with MAJOR in Semantic Versioning). 
5) A BREAKING CHANGE can be part of commits of any type.
6) Footers other than *BREAKING CHANGE* may be provided and follow a convention similar to [git trailer format](https://git-scm.com/docs/git-interpret-trailers).

##### Examples

Commit message with description and BREAKING CHANGE footer:

*feat: allow provided config object to extend other configs*
*BREAKING CHANGE: `extends` key in config file is now used for extending other config files*


Commit message with scope and ! to draw attention to breaking change

*feat(api)!: send an email to the customer when a product is shipped

Commit message with both ! and BREAKING CHANGE footer

*chore!: drop support for Node 6
*BREAKING CHANGE: use JavaScript features not available in Node 6.


#### Branch naming 

To name and describe our branches we use the type of change it will contain and a short description, following Git [branching models](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows).

Examples:

|Instance|Branch|Description, Instructions, Notes|
|---|---|---|
|Stable|	main	|Accepts merges from Working and Hotfixes|
|Development|	dev|Accepts merges from Features/Issues, Fixes and Hotfixes|
|Features/Issues|	feat/*	|Always branch off HEAD of Working|
|Fixes|	fix/*	|Always branch off HEAD of Working|
|Hotfix|	hotfix/*	|Always branch off Stable


### Code conventions

Consistent code writing, commenting and documenting style is key to collaboration. Make sure that you read the complete *Code conventions* section carefully and that your code complies with our guidelines. We are using [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) as our main style guide for Dart. 

#### On commenting and documenting code

To get familiarized with the code, check the [API reference]()(add link to automatic doc when ready). We use [Dartdoc](https://pub.dev/packages/dartdoc) to build it and will ask you to use it as well when commenting your code. If you require assistance with Dartdoc please check [Using Dartdoc](#using-dartdoc) below.

* Classes, variables, constants and relationship between classes should always be documented.

* Your comments should be full English sentences.

* Use [Dartdoc](https://pub.dev/packages/dartdoc) to generate automatic standardized documentation for your code. 

* Use ```///``` to comment your code as it is the special syntax Dartdoc looks for when generating the documentation files.

* Do **not** use /* block comments \*/ for documentation:

```
[x]

void greet(String name) {
  /* Assume we have a valid name. */
  print('Hi, $name!');
}
``` 
* **Do** instead:

```
[✓]

void greet(String name) {
  // Assume we have a valid name.
  print('Hi, $name!');
}
```

* You *can* use a block comment (/* ... \*/) to temporarily comment out a section of code, but all other comments should use ///.


#### Using Dartdoc

If this is your first time using it or you have any doubts about installation, execution, or formatting, please read our [Dartdoc API reference for Flutter](/dartdoc_automatic_documentation.md) to get started.


#### On code duplication

* Do not copy-paste source code. Reuse it in a  way that makes sense, rewriting the necessary parts.


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

```add code example here```


#### On indentation


 Switch case
 
Example :

```add code example here```


If / else or else if

Example :

```add code example here```

#### On classes

* The attributes of the class must be protected or private.

* The Method of the class can be public, private or protected.

* Classes can be public or private.

* Class names must be transparent and representative of its purpose.

* Class names should be nouns in UpperCamelCase, with the first letter of every word capitalized.

Example :

```add code example here```

#### On variables

* Local variables, instance variables, and class variables should be written in lowerCamelCase: with the exception of the first world, the first letter of every word should be capitalized.

Example :

```add code example here```

#### On constants

* Constants should be written in UPPERCASE with words separated by underscores.

Example:

```add code example here```

#### Firebase index:

[FIREBASE TREE INDEX NEEDS UPDATING]
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

We currently support Spanish, English, Portuguese and French, but we are open to adding new languages as users' needs arise. Everyone is welcome to contribute with suggestions, changes or error corrections via email at **support@ottaaproject.com**, use the subject "Contribution".

Our focus right now is growing in Latin America, with this in mind we would love some help with **pictogram localization**, that is to say, to have pictograms translated **based on each country/region-specific culture and Spanish variety**. For example, we know that a car 🚗 is commonly *carro* in México but *auto* or *coche* in Argentina. 

Chile, Argentina, Colombia, and the Caribbean are our current priorities, but of course we welcome help with any of our supported languages and regions.


## As a manual tester

We have test cases for manual testing [here](https://docs.google.com/document/d/1khElUEbtREVsTzwxKmLYfdDYJxCnz0zcNaIraRYaMGs/edit) and we mainly need help testing the overall functionality of the new Flutter version.

Any bug or hotfix that results from manual testing should be reported via an [issue](https://github.com/OTTAA-Project/ottaa_project_flutter/issues) in our GitHub repository using the [template](https://github.com/OTTAA-Project/ottaa_project_flutter/issues/new?assignees=&labels=&template=bug_report.md&title=) for bug reporting.


## As an automation tester 

We will be implementing a continuous integration workflow that will be running multiple automated testing. In the meantime, any experience with CI/CD and automated testing in Dart is very much welcome. Feel free to contact us at **support@ottaaproject.com**.

## On our code of conduct

Please read through our [code of conduct](CODE_OF_CONDUCT.md) before contributing.


