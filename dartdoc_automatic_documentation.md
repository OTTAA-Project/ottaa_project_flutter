# Dartdoc (building the API reference)



## What is Dartdoc?

Dartdoc is an automatic documentation generation tool for Dart language. The ```dart doc``` command generates HTML documentation from Dart source code by looking for and parsing comments on your code that have a special syntax. You can also add descriptions to the generated documentation by using documentation comments, which can contain Markdown formatting.


## How to install and run dartdoc as a library

First, install the package by running:

```dart pub global activate dartdoc```


Second, run from the root directory of a package:

```pub global activate dartdoc ``` or ```flutter pub get```


Third, make sure your package analyzes without errors by running:

```flutter analyze```


Finally, to start documenting just run:

```dartdoc```


## How to write dartdoc doc comments

The regular comment syntax for Dart code is ```//```. However, using ```///``` for your comments instead enables Dartdoc to find those comments and generate documentation for them.

This will be picked up by dartdoc:

```[✓]

/// The number of characters in this chunk when unsplit.
int get length => ...
```

This will not:

```[x]

// The number of characters in this chunk when unsplit.
int get length => ...
```

## Style tips we follow

We intend for our API reference documentation to be straight forward, concise and user friendly. Make sure your Dartdoc comments are correctly formatted by following these tips. For a more comprehensive explanation and examples of each tip, please read [this section](https://dart.dev/guides/language/effective-dart/documentation#:~:text=use%20//.-,Doc%20comments,-Doc%20comments%20are) of the offcial Dartdoc guide.

### General writing tips

* Be brief, use as many words as neccesary to explain your code clearly, but not more.
* Avoid abbreviations and acronyms unless they are obvious.
* Prefer using “this” instead of “the” to refer to a member’s instance.


### Style for comments

1. Start doc comments with a single-sentence summary.
2. Separate the first sentence of a doc comment into its own paragraph.
3. Avoid redundancy with the surrounding context by mentioning things the reader already knows.
4. Prefer starting function or method comments with third-person verbs.
5. Prefer starting a non-boolean variable or property comment with a noun phrase.
6. Prefer starting a boolean variable or property comment with “Whether” followed by a noun or gerund phrase.
7. Do not write documentation for both the getter and setter of a property.
8. Prefer starting library or type comments with noun phrases.
9. Consider including code samples in doc comments.
10. Use square brackets in doc comments to refer to in-scope identifiers.
11. Use prose to explain parameters, return values, and exceptions.
12. Put doc comments before metadata annotations.
13. Use Markup, but do not abuse it.
14. Avoid using HTML as it is not supported by Dartdoc.



For more information, the [Effective Dart: Documentation guide](https://dart.dev/guides/language/effective-dart/documentation) covers formatting, linking, markup, and general best practices when authoring doc comments with dartdoc.
 
