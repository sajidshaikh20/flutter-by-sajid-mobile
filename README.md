# Introduction

TODO: Give a short introduction of your project. Let this section explain the objectives or the
motivation behind this project.

# Getting Started

TODO: Guide users through getting your code up and running on their own system. In this section you
can talk about:

1. Installation process
2. Software dependencies
3. Latest releases
4. API references

# Build and Test

TODO: Describe and show how to build your code and run the tests.

# Contribute

TODO: Explain how other users and developers can contribute to make your code better.

If you want to learn more about creating good readme files then refer the
following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops).
You can also seek inspiration from the below readme files:

- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)

[//]: # (run command to generate )

[//]: # (&#40; flutter pub run build_runner watch --delete-conflicting-outputs&#41;)

//For android production build
flutter build apk --release --flavor prod --dart-define-from-file=prod_env.json

//For android stage build
flutter build apk --release --flavor stage --dart-define-from-file=stage_env.json

//For Ios Production build
flutter build ios --flavor prod -t lib/main.dart --dart-define-from-file=prod_env.json

//For Ios stage build
flutter build ios --flavor stage -t lib/main.dart --dart-define-from-file=stage_env.json

//Assets runner
dart run build_runner build --delete-conflicting-outputs

// debug apk android
flutter build apk --debug --flavor stage --dart-define-from-file=stage_env.json

//debug apk ios
flutter build ios --debug \
--flavor stage \
--dart-define-from-file=stage_env.json
