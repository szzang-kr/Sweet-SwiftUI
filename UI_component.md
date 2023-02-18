
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

### Color

1. UIColor에서 지원하는 컬러와 SwiftUI에서 기본적으로 제공되는 컬러는 다르다.
2. UIColor지원 컬러를 사용하고 싶을때는 `Color(UIColor.cyan)`과 같이 사용한다.

### Button

1. Button의 생성자는 여러가지가 있지만, 공통적으로 버튼의 외형과 이벤트가 발생 했을 때 수행할 작업을 정의한다.
2. Button의 Generic Parameter Label은 View Protocol을 준수하는 타입은 모두 사용 가능하다.
    
    ```swift
    HStack(spacing: 20) {
      Button("Button") {
          print("Button1")
      }
      Button(action: { print("Button2") }) {
          Text("Button")
              .padding()
              .background(
                  RoundedRectangle(cornerRadius: 10)
                      .strokeBorder()
              )
      }
      Button(action: { print("Button3") }) {
          Circle()
              .stroke(lineWidth: 2)
              .frame(width: 80, height: 80)
              .overlay {
                  Text("Button")
              }
      }
      .accentColor(.red) // UIButton의 tintColor
    }
    ```
    
![1](https://user-images.githubusercontent.com/39300449/159156176-2e868c40-aa2b-4f1f-b9b4-9aef64e2f16f.png)



1. 버튼 이미지 사용시 이미지의 렌더링 모드에 주의하자.
    1. renderingMode : .template / .original
2. 버튼 이미지 사용시 버튼의 스타일에 주의하자
    
    ```swift
    Button { ... }.buttonStyle(PlainButtonStyle())
    ```
    
    a. PlainButtonStyle : 일반적인 상황에서 별도의 시각적 요소를 적용하지 않고 버튼을 누르거나 포커스 되어 있을 때 지정된 효과를 적용하는 스타일
    
3. 버튼 스타일
    1. DefaultButtonStyle : buttonStyle 수식어 생략 시 기본적으로 적용되는 값으로서, 모든 OS에서 공통으로 사용할 수 있는 버튼 스타일. 시스템 환경에 따라서 적절한 버튼 스타일을 반영
    2. BorderlessButtonStyle : iOS에서 대부분의 경우에 기본적으로 반용되는 스타일로 콘텐츠에 미리 지정된 시각적 효과가 적용되며 명칭 그대로 테두리를 그리지 않는다. macOS에서는 BorderedButtonStyle에 대조되는 이름의 의미로 사용. watchOS에서는 사용 불가
    3. PlainButtonStyle : 모든 OS에서 공통으로 사용할 수 있는 버튼 스타일로서 유휴 상태에서는 버튼에 어떠한 시각적 요소도 적용하지 않습니다.
4. onTapGesture
    1. UIKit에서 사용하는 UITabGestureReconizer와 동일
    2. 어느 뷰에나 추가하여 터치 이벤트를 발생 시킬 수 있음.
    3. 그러나 버튼을 누를때의 하이라이트 애니메이션, 커스텀 스타일 등을 사용할 수 없음

### Navigation View

1. 네비게이션 스택을 이용해 콘텐츠 뷰들을 관리하는 컨테이너 뷰. 스타일에 따라 UINavigationController 또는 UISplitViewController의 역할 수행.
2. NavigationViewStyle
    1. DefaultNavigationViewStyle : 기본 스타일. 시스템 환경에 따라 자동으로 스타일 결정. watchOS에서는 사용 불가.
    2. StackNavigationViewStyle : 네비게이션 계층 구조를 하나의 뷰로만 탐색해나가는 스타일. (UINavigationController)
    3. DoubleColumnNavigationViewStyle : master와 detail로 구분되는 2개의 뷰를 이용해 콘텐츠를 표시하는 스타일. SplitViewController 가 사용되며, 해당 스타일을 사용할 수 없는 기기는 StackNavigationViewStyle로 대체한다.

### List

1. 하나의 열에 여러개의 행으로 표현되는 UI를 구성해, 다중 데이터를 쉽게 나열할 수 있는 View. UIKit의 UITableView를 대체.
2. 콘텐츠 나열 방법
    1. 정적 콘텐츠 : 직접 나열될 컨텐츠들을 정의하여 표현
    2. 동적 콘텐츠 : Range, RandomAccessCollection
    3. 정적 + 동적 콘텐츠 : ForEach
3. Range를 사용한 동적 콘텐츠 List
    1. Half-Open Range에 해당하는 A...<B 만 사용.
    2. Closed Range(A...B), One-Sided Ranges(A..., ...A)는 사용 불가
4. RandomAccessCollection 프로토콜을 채택한 동적 콘텐츠 List
    1. RandomAccessCollection은 id를 제공해야는데, 두가지 방법이 존재
        1. id 식별자 제공
        2. Identifiable 채택
    2. id 식별자 제공 방법
        
        Swift의 기본 타입들은 Hashable을 준수하므로 self를 명시하여 해결 가능
        
        ```swift
        List(["A", "B", "C"], id: \.self) { ... }
        List([1,2,3,4], id: \.self) { ... }
        ```
        
        사용자 지정 타입의 경우 Hashable을 채택하여 동일한 방법으로 제공 가능
        
    3. Identifiable 채택
        
        ```swift
        struct Animal: Identifiable {
        	let id = UUID() // id는 UUID외의 Hashable을 준수하는 모든 타입 사용 가능
        }
        
        List([Animal(), Animal(), Animal()] { ... } // id 생략
        ```
        
        Identifiable을 채택한다면, id를 생략 가능하다.
        
5. ForEach를 사용한 정적 + 동적 콘텐츠 List
    
    ForEach는 id로 식별가능한 데이터를 받아서 뷰를 생성하는 역할.
    
    ```swift
    let fruit = ["사과", "배", "포도", "바나나"]
    let drinks = ["물", "우유", "커피"]
    
    var body: some View {
      List {
          Text("Friut").font(.largeTitle)
          ForEach(fruit, id: \.self) {
              Text($0)
          }
          
          Text("Drink").font(.largeTitle)
          ForEach(drinks, id: \.self) {
              Text($0)
          }
      }
    }
    ```
    
6. Section을 통해 그룹화도 가능하며, Header, Footer를 선택해 적용가능하다.
    1. Header, Footer 모두 View를 사용한다.

### GeometryReader

1. 자식뷰에 부모뷰와 기기에 대한 크기 및 좌표계 정보를 전달하는 기능을 수행하는 컨테이너 뷰
2. initializer에 매개변수가 있는 content closure를 전달하며, 매개변수는 Geometry Proxy 정보를 가지고 있다.
3. content는 ZStack과 같은 계층 구조를 가지지만 하위 뷰가 하나 존재한다면 가운데, 하위 뷰가 여러개라면 topLeading에 정렬된다.
4. 크기를 지정하지 않는다면 주어진 공간 내에서 최대한의 크기를 가진다.

### GeometryProxy

1. struct이며, 두가지의 프로퍼티와 한가지 함수, 한가지의 subscript를 제공한다.
    1. size : GeometryReader의 크기
    2. safeAreaInsets : GeometryReader가 사용된 환경의 safeArea EdgeInsets을 반환
    3. frame(in:) : 특정 좌표를 기준으로 프레임의 정보 반환
    4. subsctipt(anchor:) : 자식뷰에서 anchorPreference modifier를 이용해 제공한 좌표나 프레임을 GeometryReader의 좌표계 기준으로 다시 변환하여 사용. CGRect, CGPoint를 매개변수로 전달

### Frame

1. UIKit에서는 frame을 변경했지만, SwiftUI에서는 콘텐츠를 담고 있는 새로운 뷰를 반환한다.
2. SwiftUI에서의 frame은 자식뷰가 사용가능한 크기를 제한하는 역할과 뷰의 정렬 위치를 결정하는데 사용된다.
3. 단, 제한된 크기 내에서 자식뷰는 직접 자신의 크기를 결정합니다.
    
    ```swift
    Text("Frame").background(Color.yellow).frame(width: 200, height: 200)
    Rectangle().fill(Color.yellow).frame(width: 200, height: 200)
    ```
    
    ![2](https://user-images.githubusercontent.com/39300449/159156210-2f147c14-8f24-486a-9c7b-f1050979b63c.png)

    
    - 동일한 frame이지만, Text는 문자열에 의해 크기가 결정되기 때문에 영역이 작아짐.
4. 고정 크기 vs 제약조건 크기
    1. 고정 크기 : frame의 width, height를 이용하여 고정 크기 지정
    2. 제약조건 크기 : min, max, ideal 값을 이용하여 제약조건 크기 지정
        1. 이때, min ≤ ideal ≤ max 오름차순으로 값을 지정해야함.
    
    ```swift
    HStack {
        // min vs max
        Rectangle().fill(Color.red).frame(minWidth: 100)
        Rectangle().fill(Color.orange).frame(maxWidth: 15)
        
        // height vs maxHeight
        Rectangle().fill(Color.yellow).frame(height: 150)
        Rectangle().fill(Color.green).frame(maxHeight: .infinity)
        
        // infinity
        Rectangle().fill(Color.purple).frame(maxWidth: .infinity, maxHeight: .infinity)
        Rectangle().fill(Color.blue)
    }
    .frame(width: 300, height: 350)
    ```
    
    
![r](https://user-images.githubusercontent.com/39300449/163700788-1b13677d-7fd7-4155-a275-6cc7aff90b90.png)

### ViewLayout

1. SwiftUI에서는 View의 레이아웃을 다음과 같은 순서로 구성합니다.
    1. 부모 뷰가 활용 가능한 크기를 자식뷰에게 전달
    2. 자식뷰는 자신의 크기를 결정
    3. 부모뷰는 자신의 좌표 공간에서 자식뷰를 적절하게 배치
