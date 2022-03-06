# Sweet SwiftUI

## Swift UI Modifer

## Modifier

### Color

1. colorInvert : 색을 반전 시킬 수 있다. 다만, return 타입이 some View이기 때문에 주의

### View

1. padding(_:, _:) ****: 뷰에 여백을 추가하기 위한 modifier. 방향과 폭을 지정할 수 있으며, 방향을 지정하지 않는다면 기본적으로 모든 방향(상하좌우)에 반영된다.
2. cornerRadius(_:antialiased:) : 뷰의 모서리를 둥글게 한다. UIKit에서는 clipToBounds를 활성화가 필요했지만, SwiftUI에서는 해당 modifier로만 사용 가능
3. shadow(color:radius:x:y:) : 불투명한 뷰에 그림자 효과를 주기위한 modifier. 
    a. SwiftUI에서 가장자리에 그림자 효과를 넣기 위해서는 다음과 같은 작업이 선행되어야한다.
        - 뷰의 배경색이 불투명이어야 한다.
        - 이미 작성된 modifier를 모두 반영 시켜야 한다.
            - clipped, cornerRadius(clipped가 포함되어있음), compositingGroup 등의 modifer 사용
