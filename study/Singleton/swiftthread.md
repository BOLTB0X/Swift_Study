# Thread - Safe

> java나 Object-C에서는 싱클톤 패턴을 사용하면 약간의 할 거리가 생김 하지만 swift는?

## 일반적인 싱글톤 패턴

```java
public class Singleton {
	private static Singleton instance;

	private Singleton(){}

	public static Singleton getInstance() {
		if(instance == null) { // 1번 : 쓰레드가 동시 접근시 문제
			instance = new Singleton(); // 2번 : 쓰레드가 동시 접근시 인스턴스 여러번 생성
		}
		return instance;
	}
}
```

가장널리 사용되는 방식이며 private static으로 자기자신의 클래스를 인스턴스로 갖고 있고 getInstance() 대상 instance를 초기화 후 리턴하는 패턴

### 만약이 멀티 스레드 환경인 경우

1번 으로 표시된 if(instance == null)지점이 Thread A까지 진행된 뒤 제어권이 Thread B로 넘어간 경우 Thread B역시 if(instance == null)가 수행되어 2번 이 수행되어 instance = new Singleton() 생성

이 때 다시 Thread A로 제어권이 넘어간다면 Thread A에서 다시한번 instance = new Singleton() 가 수행되어 결국 인스턴스는 2개가 생성되는 경우가 발생

> Tread A : if(instance == null) 수행 결과 true
> Tread B : if(instance == null) 수행 결과 true
> Tread A : instance = new Singleton() 수행으로 인스턴스1 생성
> Tread B : instance = new Singleton() 수행으로 인스턴스2 생성

```java
public class Singleton {
	private static Singleton instance;

	private Singleton(){}

    // 이런 식으로
	public static synchronized Singleton getInstance() {
		if(instance == null) { // 1번
			instance = new Singleton(); // 2번
		}
		return instance;
	}
}
```

synchronized getinstance()의 경우 인스턴스를 리턴 받을 때마다 Thread동기화 때문에 불필요하게 lock이 걸리게 됌

비용 낭비가 크긴 하지만 이런식으로 별도 코드를 작성해야함

## in swift

> Swift에서는 별도에 작업 X

```swift
class ApplyInfo {
    // 전역으로 저장되는 형태를 사용하므로
    // static을 이용해 Instance를 저장할 프로퍼티를 하나 생성
    static let shared = ApplyInfo()

    var name: String?
    var age: Int?
    var grade: Double?

    // init 메서드를 private로 지정
    // 인스턴스를 자꾸 생성하는 것을 방지하기 위해 FM으로는 private로 쓴다 함
    private init() {

    }

}
```

- static을 사용해 타입 프로퍼티로 인스턴스를 생성하면, 사용 시점에 초기화(lazy)
  <br/>

- Singleton Instance가 최초 생성되기 전까진 메모리에 올라가지 않고, Dispatch_once도 자동 적용,
  <br/>
- 따라서 별 코드 없이도 Instance가 여러 개 생성되지 않는 Thread-Safe한 방법이 되는 것임
  <br/>

- 위에서 Swift가 Thread-Safe하다고 한 것은 **싱글톤 생성**에 한정해 Thread-Safe하단 것임

## 참고

[블로그 참조 - 1](https://javaplant.tistory.com/21)

[블로그 참조 - 2](https://babbab2.tistory.com/66)
