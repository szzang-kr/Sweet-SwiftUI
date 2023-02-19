# SwiftUI 기본 개념

## Index
* [SwiftUI의 등장](https://github.com/szzang-kr/Sweet-SwiftUI/edit/main/concept.md#swiftui의-등장)
* [SwiftUI의 특성](https://github.com/szzang-kr/Sweet-SwiftUI/edit/main/concept.md#swiftui의-특성)
* [Opaque Type(불투명타입)](https://github.com/szzang-kr/Sweet-SwiftUI/edit/main/concept.md#Opaque-Type(불투명타입))
* [Omit Return(리턴 생략)](https://github.com/szzang-kr/Sweet-SwiftUI/edit/main/concept.md#omit-return리턴-생략)
</br></br>

# SwiftUI의 등장

macOS와 iOS의 개발에 사용되는 UI Framework는 모두 Objective-C 기반의 Framework이다.

하지만 Objective-C는 프로그래밍 언어가 가진 능력이 부족하고, 문법 또한 생산성이 떨어졌다.

이에 Apple은 2014년 Swift 언어를 선보였고, 계속해서 빠른속도로 발전하고 있다.

추가로 Swift 5.0, 5.1에서는 ABI Stablity, 모듈 안정성을 지원하면서 안정성도 크게 향상되었다.

iOS UI를 위한 UIKit은 Objective-C 기반으로 만들어져 있어, Swift 언어로 작성하여도 @objc 속성을 명시한다던가 호환성을 위한 부가적인 작업이 필요했다.

```swift
button.addTarget(self, action: #selector(anyfunc), for: .touchUpInside)

@objc
func anyfunc() {
...
}
```

따라서 Swift 언어 기반의 UI Framework가 필요했고, 그렇게 등장하게 된 것이 SwiftUI이다.

SwiftUI는 Swift 언어 기반이며 Swift의 모든 특성을 최대한 활용하려 하고있다.

macOS를 위한 UIFramework를 구분하는것이 아닌 SwiftUI로 모든 플랫폼에서 사용할 수 있도록 만들어졌다.

> Android의 Jetpack Compose와 비슷하다
> 

# SwiftUI의 특성

## Less Code

UIKit을 사용해 UI를 개발할때는 뷰 갱신, 현지화, 적응형 레이아웃 등 여러가지 코드를 직접 작성해야 했지만, SwiftUI에서는 프레임워크 내부에서 대부분 지원한다.

따라서 UIKit으로 작성할때 보다 상당히 코드가 줄어들게되고, 읽어야할 코드가 줄어드니 코드를 이해하는데에도 도움이된다.

## 선언형

기존 UIKit의 명령형(Imperative) 대신 선언형(Declarative)프로그래밍 방식을 활용.

UI를 구성하는 방식, 레이아웃을 단계적으로 작성했던 UIKit의 방식과 다르게 어떻게 레이아웃을 시킬것이며 어떤 폰트를 적용할지 원하는 결과를 선언하는 방식이다.

이렇게되면 최종 UI의 형태를 말로 전달하듯이 표현 가능하다.

### Preview

Xcode11부터 SwiftUI를 사용하면 시뮬레이터를 빌드하는 대신 preview에서 UI를 확인 가능하다.

> *물론 UIKit에서도 Preview를 사용할 수 있다. 
단 빌드에 3~5초 이상 소요된다면 preview를 사용할 수 없다.*
> 

preview에는 변경사항이 즉각적으로 반영되며 다크모드, 현지화, 폰트 등을 여러 디바이스 환경에서 확인하는것도 가능하다

### Cross Platform

UIKit으로 iOS, watchOS, tvOS 등 여러 환경의 UI를 작성하게된다면 해당 OS 에 맞는 코드를 추가로 작성하거나 새롭게 UI를 구성해야했다.

그러나 SwiftUI는 상당 부분을 재사용할 수 있게 되어 여러 환경의 앱을 더 쉽게 개발할 수 있다.

# SwiftUI의 4가지 원칙

## 선언형

SwiftUI는 선언형 패러다임을 접목하였다. 선언형과 명령형의 차이는 아래와 같다

- 명령형은 어떻게(HOW) 수행해야하는지에 대해 초첨을 맞추고있다.
    - 명령을 올바른 순서로 실행하지 않는다면 원하는 결과를 얻을 수 없다.
- 선언형은 무엇을(WHAT) 수행해야하는지에 대해 초첨을 맞추고있다.
    - 명령을 다루는대신 프로그램이 수행해야하는 목적 자체를 설명한다.

## 자동화

많은 기능들이 자동으로 수행될 수 있게끔 설계되어있다.

AutoLayout을 위한 많은 코드들이 제거되었고, 최소한의 설명만으로 UI를 작성할 수 있게 되었다.

## 조합

SwfitUI API는 뷰의 조합과 분리를 간단히 할 수 있게 제공한다.

반복적인 UI 개발을 더욱 빠르게 진행할 수 있게 되었고, 작은 뷰 단위로 쪼개고 원하는 방식으로 조합하여 손쉽게 뷰를 만들어낼 수 있다.

또 protocol에 다양한 modifier를 지원해 protocol을 준수하는 모든 객체에게 동일한 UI나 기능을 손쉽게 적용할 수 있다.

## 일관성

UI는 항상 데이터와 동기화 되어야 한다.

UIKit에서는 데이터와 UI를 동기화 하기위해 수동으로 코드를 작성했고,

여러 기술들이 사용되어 버그가 발생할 가능성도 많아졌다.

SwiftUI에서는 데이터가 변경되는 즉시 UI도 자동으로 변경된다.

이를 위해 Source Of Truth라는 개념을 사용하게되는데 이는 데이터를 기준으로 데이터 변경에 따라 UI가 변경되는것을 의미한다.

이를 통해 데이터와 UI를 동기화 하는 부분에서 항상 일관성 있는 결과를 얻을 수 있다.

---

# Opaque Type(불투명타입)

Swift UI의 body 에 사용되는 `some` 이 Opaque Type에 관련된 키워드이며, property, function등 return 타입에 한정적으로 사용된다.

## 타입 정보 은닉

UIKit에서는 뷰의 설정을 바꾸거나, 뷰를 추가해도 상위 뷰의 타입이 변경되진 않았지만 구조체와 제네릭을 활용하는 SwiftUI의 구현방식에서는 뷰를 추가하거나 변경할 때 마다 새로운 타입이 만들어지게 된다.

이렇듯 뷰가 변경될 때 마다 body의 타입을 새로 지정하기에는 무리가 있어 `some` 키워드를 사용하여 어떤 타입인지에 대한 정보를 숨기고, 채택하는 프로토콜에 대한 정보를 남긴 채 API를 사용할 수 있도록 해준다. 이로인해 API는 추상화 되고 모듈간 결합도는 낮아지게 된다.

불투명 타입은 특정 타입에 대한 제약조건을 지정하여 확장성을 높이는 제네릭과 반대되는 개념이다.

## 타입 추상화

제네릭은 caller 측에서 callee의 타입을 결정하지만

불투명타입은 callee가 caller의 타입을 결정한다.

```swift
// Generic
func genericFunction<T: Animal>(_ animal: T) { ... } // callee는 타입을 전달받는다
genericFunction(Dog()) // caller가 전달할 타입을 결정
genericFunction(Cat()) 

// Opaque Type
func opaqueTypeFunction() -> some Animal { Dog() } // callee가 타입을 결정(Dog)
let someAnimal: some Animal = opaqueTypeFunction() // caller는 추상화된 타입을 전달받음(some Animal)
```

## 정적 타입 시스템

제네릭의 매개변수는 정적 타입 시스템에서만 타입을 숨기고 런타임에서는 노출된다.

불투명타입 역시 런타임에서 타입이 노출되기 때문에 아래 #1 Line 은 컴파일 에러가 일어난다.

```swift
protocol Animal { }

struct Dog: Animal {
    var color: UIColor { UIColor.brown }
}

let dog: some Animal = Dog()
dog.color  // #1
(dog as! Dog).color
```

## 타입 정체성

기존에는 프로토콜을 반환타입으로 사용할 수 있었고, 프로토콜을 준수하는 어떤 타입이든 반환할 수 있는 유연성이 장점이였다. 하지만 서로 다른 타입이 반환 될 수 있는 점에서 타입에 대한 정보를 잃는 단점이 있다.

```swift
protocol Animal {}

struct Dog: Animal {}
struct Cat: Animal {}

func returnType() -> Animal {
	.random() ? Dog() : Cat()
}

let animal: Animal = returnType() // Cat? Dog?
```

이러한 문제는 현재 상태에서는 문제가 없지만 중첩구조에서 문제를 일으킨다.

```swift
protocol P {}

struct SomeType: P {}

func nested<T: P>(_ param: T) -> P {
	param
}

let foo: P = nested(SomeType()) // foo는 P 타입이므로, protocol P를 만족 할 수 없음
let bar = nested(foo)
```
</br>

또한 Self 타입 또는 associatedtype 타입이 선언된 프로토콜은 타입을 명시하거나 추론할 수 있어야 사용할 수 있다.

그러므로 다음 코드들은 모두 에러가 발생한다.

```swift
func someFunction(_ lhs: Equatable, _ rhs: Equatable) -> Bool {} // Equatable은 Self 타입 입니다.

func someFunction() -> Hashable {} // Hashable은 Equatable을 채택하고 있으므로 Self 타입 입니다.

var someProperty: Collection {} // Collection은 associatedtype 타입이 선언되어 있습니다.
```

프로토콜은 유연한 타입이 장점이지만 이로 인해 불확실한 부분이 존재하며, 불투명 타입은 이를 보완하기 위한 두가지 방안을 강제한다.

### 실체타입

불투명 타입은 반환하는 타입은 반드시 실체 타입이여야 한다.

```swift
protocol Animal {}

struct Dog: Animal {}
struct Cat: Animal {}

func returnConcreteType() -> some Animal {
    let result: Animal = Dog()
    return result
}
```

위 코드는 에러를 발생시키며 실체 타입이 아닌 `Animal` 프로토콜을 반환하여 발생한다.

따라서 `result`의 타입을 실체타입인 `Dog`로 변경하면 에러가 해결된다.

프로토콜이 아닌 실체타입을 반환하게 하는것은 두번째 방안인 언제나 동일타입을 반환해야 하는것을 지키려는 것이기도 하다.

### 동일타입

반환하는 값은 달라도 반환하는 타입은 반드시 동일해야한다.

Self 타입이나 associatedtype을 가진 프로토콜을 사용하려면 제네릭이 필요하다.

다음코드의 함수에서 제네릭 매개변수 T는 함수를 호출하는 곳에서 타입에 대한 정보를 제공하며,

lhs와 rhs라는 매개변수는 값이 다르더라도 동일한 타입을 갖는다.

```swift
func genericFunction<T: Equatable>(_ lhs: T, _ rhs: T) -> Bool {
    lhs == rhs
}

let gf1 = genericFunction("Swift", "UI") // 호출하는 코드가 타입 정보 제공
let gf2 = genericFunction(true, false)
let gf3 = genericFunction("Swift", true) // 타입이 불일 치 할 경우 에러 Conflicting arguments to generic parameter 'T' ('Bool' vs. 'String')

print(gf1)
print(gf2)

/*
	false
	false
*/
```

앞서 불투명 타입은 제네릭을 반대로 적용한 개념이라고 언급했듯이, 동일하게 반대로 적용된다.

**Self 타입이나 aasociatedtype은 함수의 반환하는 값에 대한 타입**이 되며, **값은 상황에 따라 달라지더라도 타입은 항상 동일**해야 한다.

```swift
func stringOpaqueTypeFunction() -> some Equatable {
    .random() ? "Swift" : "UI" // 반환하는 코드가 타입 정보 제공
}

func boolOpaqueTypeFunction() -> some Equatable {
    .random() ? true : false
}

func strangeOpaqueTypeFunction() -> some Equatable {
    .random() ? "Swift" : true // Result values in '? :' expression have mismatching types 'String' and 'Bool'
}

let sotf1 = stringOpaqueTypeFunction()
let sotf2 = boolOpaqueTypeFunction()

print(sotf1)
print(sotf2)

/*
    Swift
    true
*/

```

따라서 SwftUI의 body 함수에 다음과 같은 코드를 작성하게 되면 에러가 발생한다.

```swift
var body: some View {
    .random() ? Rectangle() : Circle() // Result values in '? :' expression have mismatching types 'Rectangle' and 'Circle'
}
```

## 정리

- 불투명 타입(Opaque Type)은 자세한 타입과 구현에 대한 정보를 숨기고 특정 protocol을 따르는 API 라는 것을 명시한다.
- prtocol 타입을 반환하면서 타입에 대한 정체성을 보장하여 API 내부에서 타입 검사 기능을 활용 할 수 있다.
- some 키워드는 property, index, 함수의 반환 타입에만 적용 가능하며, some 키워드를 적용할 수 있는 타입은 다음과 같다.
    - protocol
    - class
    - Any
    - AnyObject

---

# Omit Return(리턴 생략)

리턴 생략은 단일 표현식(single-expression)이 작성된 함수에 대해서는 return 키워드를 생략할 수 있다.

> 표현식(expression)이란 실행시에 값을 반환하거나 side effect를 발생하거나, 둘 다 발생하게되는 코드를 말하며 Swift에서는 prefix, infix, primary, postfix 4가지의 표현식이 존재한다.

상세내용은 [문서](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/) 참고
> 

```swift
let add = { (a: Int, b: Int) in
	a+b
}

func add(x: Int, y: Int) -> Int {
	x+y
}
```

중요한점은 단일 표현식과 단일 행은 다르다는 점이다.

```swift
var body: some View {
	Text("title")
}

var body: some View {
	Text("title")
		.font(.title)
}
```

아래의 body는 두개의 행으로 작성된 코드지만, 단일 표현식이므로 return 키워드를 생략할 수 있다.

if-else 구문은 삼항연산자와 같은 역할이라고 생각되기 때문에 아래와 같은 코드를 작성하는 실수가 있을 수 있는데,

구문과 표현식의 차이라는것을 알아두자

```swift
// 컴파일 성공
var body: some View {
	true ? Text("성공") : Text("실패")	
}

// 컴파일 오류
var body: some View {
	if true {
		Text("성공")
	else { 
		Text("실패")
	}	
}

// 컴파일 성공
var body: some View {
	if true {
		return Text("성공")
	else { 
		return Text("실패")
	}	
}
```
