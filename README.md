# DemoBlog
Demo project to handle multiple environments in Xcode

## Usage

Clone the repository and run the following commands:
```
> pod install
> ./prepare.rb [development|production]
```

This will generate two new files:
- `DemoBlog/BuildConfig/Environment.xcconfig`
- `DemoBlog/Environment/Environment+Current.swift`

All the environment are defined in the yaml files under [`DemoBlog/Environment/`](https://github.com/felginep/DemoBlog/tree/main/DemoBlog/Environment)