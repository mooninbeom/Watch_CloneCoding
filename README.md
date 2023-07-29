# 시계 클론 코딩
아이폰 기본 앱에 포함되어 있는 **시계** 어플을 클론 코딩 해보았습니다.

**UIKit**을 사용하여 개발했습니다.


* 세계 시계
* 알람
* 스톱워치
* 타이머

기능이 포함되어 있습니다.

## 기능

### 전체 UI
<img width="30%" src="https://github.com/mooninbeom/codeTest/assets/116792524/1a047cad-6907-4e15-a085-93324dbc5d83"/>
　　　　
<img width="30%" src="https://github.com/mooninbeom/codeTest/assets/116792524/aa944d31-8ea6-4663-919e-3fefe93feb29"/>

**세계 시계**　　　　　　　　　　　　　　　　　　　　　**알람**
<br/><br/>
<img width="30%" src="https://github.com/mooninbeom/codeTest/assets/116792524/a4210ff5-2606-4d6e-9002-bdab62037aea"/>
　　　　
<img width="30%" src="https://github.com/mooninbeom/codeTest/assets/116792524/f6cf4548-4308-4aba-8277-40cc55038caf"/>

**스톱워치**　　　　　　　　　　　　　　　　　　　　　**타이머**



-----

### 기능구현

<img width="24%" src="https://github.com/mooninbeom/codeTest/assets/116792524/6564a6ba-6bb0-4155-8451-b1dfb3c9c75b"/>

<img width="24%" src="https://github.com/mooninbeom/codeTest/assets/116792524/ed2b55cb-a97f-48ec-b081-bdf2388811a0"/>

<img width="24%" src="https://github.com/mooninbeom/codeTest/assets/116792524/a2a7ccb9-f29b-411e-b232-7966da213f9b"/>

<img width="24%" src="https://github.com/mooninbeom/codeTest/assets/116792524/ebb56f20-0582-4619-b885-18bbcde61530"/>



## 구현 방식
### 1. 세계 시계
테이블 뷰를 이용해 각 셀을 구현했습니다.
**TimeZone.knownTimeZoneIdentifiers**를 활용해 각 나라의 TimeZoneIdentifiers를 얻어 올 수 있었으며 이를 활용해 전체 indentifiers를 WorldClock 모델에 넣었습니다.

```swift
for tz in TimeZone.knownTimeZoneIdentifiers{
  let timeZone = TimeZone(identifier: tz)
  let translatedName: String = timeZone?.localizedName(for: NSTimeZone.NameStyle.shortGeneric, locale: Locale(identifier: "ko_KR")) ?? "fail"
  let test = translatedName.split(separator: " ")
  var a = ""
  for i in test {
    if(String(i) == "시간") {
      break
    }
    a.append(String(i))
  }
  let add = WorldClock(translatedName: a, name: tz)
  self.worldClockList.append(add)
}
```




### 2. 알람
UI만 구현 완료(기능 미구현 상태)



### 3. 스톱워치
Timer를 이용해 시간 측정을 했습니다.

```swift
// 타이머 생성 (0.01초 마다 반복)
timer = Timer(timeInterval: 0.01, target: self, selector: #selector(self.secondTimeProcess), userInfo: nil, repeats: true)

// 타이머 시간마다 실행되는 함수
@objc
func secondTimeProcess(_ sender: Timer!) {
  self.countTime += 1 
  DispatchQueue.main.async{
    // 현재 측정된 시간을 화면에 표시
    self.timerLabel.text = self.makeTimeLabel(self.countTime) 
  }
}
```



### 4. 타이머
**UIBezierPath**를 이용해 원을 그렸다.
```swift
 let circlePath = UIBezierPath(arcCenter: CGPoint(x: screenWidth/2.0, y:  top! + screenHeight/6), radius: (screenWidth-80)/2.0,
  startAngle: CGFloat(-0.5*Double.pi), endAngle: CGFloat(1.5*Double.pi), clockwise: true)
```

이를 바탕으로 원을 그리는 애니메이션을 넣어 완성하였다.

**CABasicAnimation** 을 사용하여 타이머 애니메이션을 구현하였다.
```swift
var timerAnimation: CABasicAnimation = {
  let anime = CABasicAnimation(keyPath: "strokeEnd")
  anime.toValue = 0
  anime.isRemovedOnCompletion = false
  anime.fillMode = .forwards
  return anime
}()
```





