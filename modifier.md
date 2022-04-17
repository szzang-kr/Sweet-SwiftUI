# Sweet SwiftUI

## Swift UI Modifer

## Modifier

### Color

1. colorInvert : 색을 반전 시킬 수 있다. 다만, return 타입이 some View이기 때문에 주의

### View

1. padding(_:, _:) ****: 뷰에 여백을 추가하기 위한 modifier. 방향과 폭을 지정할 수 있으며, 방향을 지정하지 않는다면 기본적으로 모든 방향(상하좌우)에 반영된다.
2. cornerRadius(_:, antialiased:) : 뷰의 모서리를 둥글게 한다. UIKit에서는 clipToBounds를 활성화가 필요했지만, SwiftUI에서는 해당 modifier로만 사용 가능
3. shadow(color:, radius:, x:, y:) : 불투명한 뷰에 그림자 효과를 주기위한 modifier.</br> SwiftUI에서 가장자리에 그림자 효과를 넣기 위해서는 다음과 같은 작업이 선행되어야한다.
    - 뷰의 배경색이 불투명이어야 한다.
    - 이미 작성된 modifier를 모두 반영 시켜야 한다.
        - clipped, cornerRadius(clipped가 포함되어있음), compositingGroup 등의 modifer 사용

### NavigationView

1. navigationBarTitle(_:) : NavigationView의 타이틀을 지정하며, 내부에서 사용되는 뷰에 적용해야한다.
    1. UIKit에서는 UINavigationController의 타이틀을 직접 적용하는게 아닌 UIViewController에 타이틀을 적용했었다. 
    2. NavigationView에 사용되는 Modifer들은 Preference라는 기능이 사용되어 하위뷰가 상위 뷰에 데이터를 전달하는 방식이다.
2. navigationBarItems(_:, _:) : NavigationBar의 item을 지정하며, leading, trailing 두 위치에 View를 둘 수 있으며, 특정 위치에 여러가지 버튼을 두려면 HStack으로 감싼다.
    1. 해당 Modifier는 현재 toolBar로 대체를 권유하고 있다.
    2. iOS 13.4 이전 버전에서는 NavigationView의 스택이 쌓이게 되면 뒤로가기 버튼(<)이 leading에 삽입 한 버튼에 가려지게 된다.
3. toolBar(content:) : NavigationView 혹은 ToolBar에 여러가지 아이템을 삽입하고자 할 때 사용한다.
    
    ```swift
    var body: some View {
      let leadingItem = Button(action: {}) {
          Image(systemName: "bell")
      }
      let trailingItem = Button(action: {}) {
          Image(systemName: "gear")
      }
      return NavigationView {
          Image("SwiftUI")
              .navigationTitle("네비게이션 바 타이틀")
              .toolbar {
                  ToolbarItemGroup(
                      placement: .navigationBarLeading,
                      content: {
                          leadingItem
                      }
                  )
                  ToolbarItemGroup(
                      placement: .navigationBarTrailing,
                      content: {
                          trailingItem
                      }
                  )
              }
      }
    }
    ```
    
4. NavigationLink : 지정한 목적지로 이동할 수 있도록 만들어진 버튼
    1. 버튼처럼 label에는 View 타입을 전달 할 수 있음.

### List

1. ListStyle(_:) : 다양한 속성을 통해 List의 형태를 변경 할 수 있음.

### Frame

1. idealHeight, idealWidth: UIKit의 Intrinsic Content Size(고유 콘텐츠 크기)와 같은 개념
    1. 부모뷰에 관계없이 자신이 가진 이상적인 크기의 값.
    2. fixedSize를 통해 이상적인 크기에 대한 고정 가능.
    3. fixedSize 수식어를 사용하기 전에, idealWidth 혹은 idealHeight을 지정한다면 원하는 idealSize를 설정할 수 있음.
    4. width, height중 한가지만 fixedSize 속성을 사용한다면, ****fixedSize(horizontal:vertical:)**** 메서드 활용.
2. ****layoutPriority(_:)**** 메서드를 사용하여 레이아웃의 우선순위를 변경할 수 있음.
    1. UIKit에서 constraint에 priority를 주는것과 비슷한 개념
