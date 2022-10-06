# Dartdoc API reference for Flutter

The API reference is the class and function reference for the OTTAA Project code. The ```dart doc``` command generates HTML documentation from Dart source code by looking for and parsing comments on your code that have a special syntax. You can also add descriptions to the generated documentation by using documentation comments, which can contain Markdown formatting.

## How to write dartdoc doc comments

While the regular comment syntax for Dart code is ```//```, using ```///```,called doc comments, instead enables Dartdoc to find those comments and generate documentation for them.

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


## How to generate documentation

To generate documentation for Flutter using dartdoc, first run these from the root directory of a package:

1. ```pub global activate dartdoc ``` or ```flutter pub get```
2. ```dartdoc```

Then make sure your package analyzes without errors running:

```flutter analyze```


## Style


For more information, the [Effective Dart: Documentation guide](https://dart.dev/guides/language/effective-dart/documentation) covers formatting, linking, markup, and general best practices when authoring doc comments with dartdoc.
