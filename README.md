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

### Delete
```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

coreDataStack.deleteRequest(CDPerson.self)
              .predicate(NSPredicate(format: "age == %i", 5)) //optionally
              .delete(inContext: context) { error in
                //Handle error
            }
```
or
```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

let person: CDPerson = ... //some CDPerson or any NSManagedObject

context.delete(person)

coreDataStack.save(inContext: context) { result: SaveResult in
  if let error = result.error {
    //Handle error
  }
}
```
or
```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

coreDataStack.batchDeleteRequest(CDPerson.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0))) //optionally
            .merge(into: [viewContext]) //optionally
            .delete(inContext: privateContext) { error in
                //Handle error
            }
```
### Update
```swift
let coreDataStack = CoreDataStack(modelName: "NameOfModel")

coreDataStack.batchUpdateRequest(CDPerson.self)
            .propertiesToUpdate(["name": "new username"])
            .predicate(NSPredicate(format: "age == %i", Int16(0))) //optionally
            .merge(into: [viewContext]) //optionally
            .update(inContext: privateContext) { error in
                //Handle error
            }
```
## Author

Grigory Sapogov, grisha.sapgv@mail.ru

## License

SwiftCoreData is available under the MIT license. See the LICENSE file for more info.
