# Sweet SwiftUI

## Swift UI 컴포넌트 기본 개념

### Text

1. 함수가 리턴하는 타입이 다르기 때문에, 코드를 적용하는 순서가 중요하다.
2. 수식어는 이전의 뷰를 감싸 새로운 뷰를 만들어낸다.

### Image

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

### Stack

1. 가로, 세로 배열인 HStack, VStack이 존재하며, 뷰를 겹쳐 계층 구조를 만드는 ZStack이 존재한다.
2. Stack별 alignment 생성자
    1. HStack : 가로 방향의 배열이므로, 세로 정렬값(VerticalAlignment) 필요
    2. VStack : 세로 방향의 배열이므로, 가로 정렬값(HorizontalAlignment 필요
    3. ZStack : 가로 세로 정렬값 모두 필요

### Spacer

1. 뷰 사이의 간격을 설정하거나 뷰의 크기를 확장할 용도로 사용한다.
2. Stack 외부에서 사용되는경우와 내부에서 사용되는 경우가 다르다.
    1. Stack 외부 : 부모의 크기 내에서 가능한 최대한으로 확장되며 하나의 뷰로 인식된다.
    2. Stack 내부 : 시각적 요소를 제외하고 단지 Stack의 크기를 확장하기 위한 용도로 사용된다.
3. Spacer의 크기를 제한하고 싶다면, .frame을 사용한다.
4. ZStack에서 확장을 위해 Spacer를 사용한다면 형제뷰의 크기에 따라서 맞춰진다.
    1. 따라서 화면전체에 확장 하고 싶다면 Color.clear를 사용하거나 Rectangle 처럼 부모 크기에 맞춰 확장하려는 성질의 뷰를 형제뷰로 넣어주면 된다.

### Overlay & Background

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
