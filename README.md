# SwiftCoreData

[![Version](https://img.shields.io/cocoapods/v/SwiftCoreData.svg?style=flat)](https://cocoapods.org/pods/SwiftCoreData)
[![License](https://img.shields.io/cocoapods/l/SwiftCoreData.svg?style=flat)](https://cocoapods.org/pods/SwiftCoreData)
[![Platform](https://img.shields.io/cocoapods/p/SwiftCoreData.svg?style=flat)](https://cocoapods.org/pods/SwiftCoreData)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

  SwiftCoreData is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftCoreData'
```

## Usage

### Fetch 

```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

let persons = coreDataStack
                .fetchRequest(CDPerson.self)
                .fetch(inContext: context)

for person in persons {
  //use person
  let name = person.name
  ...

}
```
### FetchOne 

```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

let person: CDPerson? = coreDataStack
                .fetchRequest(CDPerson.self)
                .predicate(NSPredicate(format: "age == %i", 5)) //optionally
                .fetchOne(inContext: context)

let name = person?.name
```
### FetchCount
```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

let count: Int = coreDataStack
                .fetchRequestCount(CDPerson.self)
                .predicate(NSPredicate(format: "age == %i", 5)) //optionally
                .fetchCount(inContext: context)


```
### Save
```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

let cdPerson = CDPerson(context: context)
cdPerson.name = "User name"
cdPerson.age = 10
  
coreDataStack.save(inContext: context) { result: SaveResult in
  if let error = result.error {
    //Handle error
  }
}
```

## Author

Grigory Sapogov, grisha.sapgv@mail.ru

## License

SwiftCoreData is available under the MIT license. See the LICENSE file for more info.
