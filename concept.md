# SwiftUI 기본 개념

## Index
* Opaque Type
* Swift UI 컴포넌트
</br></br>

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

# Swift UI 컴포넌트

## Text

1. 함수가 리턴하는 타입이 다르기 때문에, 코드를 적용하는 순서가 중요하다.
2. 수식어는 이전의 뷰를 감싸 새로운 뷰를 만들어낸다.

## Image

1. Image(”name”)으로 간편하게 사용 가능하다.
2. 기본적으로 이미지는 자신이 가진 크기를 고수한다.
    1. 이미지의 크기를 변경하기위해선 .resizable 수식어가 필요하다.
    2. resizable은 strech가 기본이며, title속성도 존재한다
3. UIKit과 마찬가지로 contentMode가 존재하는데 이름이 조금 다르다.
    1. scaleToFill → 기본값 : 이미지 비율에 상관없이 크기에 맞게 늘어납니다.
    2. aspectToFill → sacleToFill : 비율을 지키며 크기에 맞춰 늘어납니다.
    3. aspectToFit → scaleToFit  : 비율을 지키며 너비와 높이 중 작은 쪽에 맞춰 늘어납니다.
4. 이미지의 비율에 세부적인 조정이 필요하다면 aspectRatio를 이용한다.
    1. 이때, contentMode가 적용되어 있어야 합니다.
5. 지정한 도형의 모습만 남기고 이미지를 잘라 낼 때는 clipShape를 사용한다.
    1. 이때, 원하는 도형을 만들고, 해당 도형의 모습만으로 남길 수 있다.
6. RenderingMode에는 .template, .orignal 두가지가 있다.
    1. template: 이미지의 불투명 영역이 가진 본래의 색을 무시하고, 원하는 색으로 변경합니다.
    2. original: 항상 이미지 본래의 색을 유지합니다.
    3. 이때 nil이나 빈값을 전달하면 시스템에서 임의로 지정하여 사용하며, 원하는대로 동작하지 않을 때에는 직접 지정하여야합니다.

## Stack

1. 가로, 세로 배열인 HStack, VStack이 존재하며, 뷰를 겹쳐 계층 구조를 만드는 ZStack이 존재한다.
2. Stack별 alignment 생성자
    1. HStack : 가로 방향의 배열이므로, 세로 정렬값(VerticalAlignment) 필요
    2. VStack : 세로 방향의 배열이므로, 가로 정렬값(HorizontalAlignment 필요
    3. ZStack : 가로 세로 정렬값 모두 필요

## Spacer

1. 뷰 사이의 간격을 설정하거나 뷰의 크기를 확장할 용도로 사용한다.
2. Stack 외부에서 사용되는경우와 내부에서 사용되는 경우가 다르다.
    1. Stack 외부 : 부모의 크기 내에서 가능한 최대한으로 확장되며 하나의 뷰로 인식된다.
    2. Stack 내부 : 시각적 요소를 제외하고 단지 Stack의 크기를 확장하기 위한 용도로 사용된다.
3. Spacer의 크기를 제한하고 싶다면, .frame을 사용한다.
4. ZStack에서 확장을 위해 Spacer를 사용한다면 형제뷰의 크기에 따라서 맞춰진다.
    1. 따라서 화면전체에 확장 하고 싶다면 Color.clear를 사용하거나 Rectangle 처럼 부모 크기에 맞춰 확장하려는 성질의 뷰를 형제뷰로 넣어주면 된다.

## Overlay & Background

1. ZStack 처럼 중첩된 뷰를 표현하는데 사용된다.
2. Overlay는 뷰 원본의 공간을 기준으로 그 위에 새로운 뷰를 중첩하여 쌓는 기능
    1. UIKit의 addSubview 메서드와 사용하는 개념이 같다, 자식뷰는 부모 뷰를 기준으로 frame과 size가 결정된다

```swift
// ZStack과 Overlay의 동일한 동작의 코드 비교
ZStack {
	Rectangle().fill(Color.green).frame(width: 150, height: 150)
	Rectangle().fill(Color.yellow).frame(width: 150, height: 150)
}

Rectangle()
    .fill(Color.green).frame(width: 150, height: 150)
	.overlay(
		Rectangle().fill(Color.yellow) // 크기를 지정하지 않으면, 원본 뷰의 크기에 맞춰진다.
	)
```

3. Background는 Overlay와 같이 새로운 뷰를 중첩하여 쌓지만, 상위가 아닌 하위에 쌓는 기능

```swift
// ZStack과 Background의 동일한 동작의 코드 비교
ZStack {
	Rectangle().fill(Color.green).frame(width: 150, height: 150)
	Rectangle().fill(Color.yellow).frame(width: 150, height: 150)
}

Rectangle()
    .fill(Color.yellow).frame(width: 150, height: 150)
	.background(
		Rectangle().fill(Color.green) // 아래에 쌓기 때문에 컬러 순서를 변경하였다.
	)
```

4. alignment 매개변수를 통해 추가되는 뷰의 위치를 지정할 수 있음

```swift
Circle()
	.fill(Color.yellow.opacity(0.55))
	.frame(width: 250, height: 250)
	.overlay(Text("hello world"))
	.background(Text("top"), alignment: .top)
	.overlay(Text("left"), alignment: .leading)
	.overlay(Text("right"), alignment: .trailing)
	.background(Text("bottom"), alignment: .bottom)
```
![Untitled](https://user-images.githubusercontent.com/39300449/156912032-50852040-aca6-4ba1-875d-3d5b9a8468ee.png)</br>

background로 추가된 top, bottom은 하위에 추가되었기 때문에 흐릿하게 보임

5. 두가지 방법과 ZStack의 사용 구분
    1. .overlay/.background : 부모 뷰 외의 기존에 존재하는 다른 뷰들에게 영향을 주지 않기 때문에 레이아웃을 구성할 때 사용하기 보단 부모 뷰를 꾸밀 때 사용
    2. ZStack : 특정 변경 사항이 다른 뷰들에게 영향을 끼칠 수 있으며, 자식 뷰의 크기에 따라 ZStack의 크기가 달라질 수 있다.주로 UI를 구성할 때 사용
