<a id="."></a>

# 프로젝트 매니저 (SwiftUI & TCA)

## 📖 목차

1. [📢 소개](#1.)
2. [👤 팀원](#2.)
3. [⏱️ 타임라인](#3.)
4. [📊 UML & 파일트리](#4.)
5. [📱 실행 화면](#5.)
6. [🤔 고민한 부분](#6.)
7. [🔗 참고 링크](#7.)

<br>

<a id="1."></a>

## 1. 📢 소개
프로젝트를 생성하고 관리하고 날짜에 맞게 진행하세요!
기한이 지난 프로젝트는 표시됩니다!

> **핵심 개념 및 경험**
> 
> - **SwiftUI**
>   - SwiftUI를 이용하여 선언형 UI 구현
> - **TCA**
>   - 프로젝트의 가독성 및 역할 분리를 위해 TCA 사용
> - **SwiftData**
>   - 데이터를 로컬에 저장하기 위해 SwiftData를 이용한 저장 기능 구현

<br>

<a id="2."></a>

## 2. 👤 팀원

| [Erick](https://github.com/h-suo) |
| :--------: | 
| <Img src = "https://user-images.githubusercontent.com/109963294/235300758-fe15d3c5-e312-41dd-a9dd-d61e0ab354cf.png" width="350"/>|

<br>

<a id="3."></a>
## 3. ⏱️ 타임라인

> SwiftUI 프로젝트 기간 :  2024.03.04 ~ 2024.03.21

|날짜|내용|
|:---:|---|
| **2023.03.04** |▫️ SwiftUI 리펙토링 파일 생성 <br>|
| **2023.03.05** |▫️ TCA 패키지 추가 및 그룹 분리 <br> ▫️ Project 객체 생성 <br> ▫️ ProjectsFeature 생성 <br> ▫️ ProjectsView 생성 및 UI 구현 <br>|
| **2023.03.07** |▫️ ProjectDetailFeature 생성 <br> ▫️ ProjectDetailView 생성 및 UI 구현 <br>|
| **2023.03.08** |▫️ Project 업데이트 및 삭제 기능 구현 <br>|
| **2023.03.09** |▫️ Projects 필터링 로직 추가 <br> ▫️ Project State 변경 기능 구현 <br>|
| **2023.03.12** |▫️ 마감기한 초과 표시 기능 구현 <br>|
| **2023.03.20** |▫️ Database Environment 생성 <br> ▫️ 로컬 저장 기능 구현 <br>|

<br>

<a id="4."></a>
## 4. 📊 UML & 파일트리

### UML

<Img src = "https://github.com/h-suo/ProjectManager/assets/109963294/87d80da5-d802-4c95-ba34-e8bb568ee8ce" width="800"/>

<br>

### 파일트리

```
ProjectManager
├── Application
│   └── ProjectManagerApp.swift
├── Feature
│   ├── Project.swift
│   ├── ProjectsFeature.swift
│   └── ProjectDetailFeature.swift
└── View
│   ├── ProjectsView.swift
│   ├── ProjectList.swift
│   ├── ProjectRow.swift
│   └── ProjectDetailView.swift
├── Environment
│   ├── DataBase.swift
│   └── ProjectDataBase.swift
├── Util
│   └── Extenstion
│       └── Calendar+.swift
└── Resource
    └── Assets.xcassets
```

<br>

<a id="5."></a>
## 5. 📱 실행 화면
| 프로젝트 생성 |
| :--------------: |
| <Img src = "https://github.com/h-suo/ProjectManager/assets/109963294/e2297c3e-6598-40f7-82c2-3642c1995de0" width="800"/> |
| **프로젝트 수정** |
| <Img src = "https://github.com/h-suo/ProjectManager/assets/109963294/d8a2353e-2c0d-458f-baf6-b8630ebda323" width="800"/>  |
| **프로젝트 이동** |
| <Img src = "https://github.com/h-suo/ProjectManager/assets/109963294/539ea481-f822-46a3-bdd2-f7dcc2ed32a6" width="800"/> |
| **프로젝트 삭제** |
| <Img src = "https://github.com/h-suo/ProjectManager/assets/109963294/df14d25f-bd50-45bc-ba24-dd664f99ee58" width="800"/> |

<br>

<a id="6."></a>
## 6. 🤔 고민한 부분

### 1️⃣ SwiftUI

SwiftUI로 UI를 구현하며, 사용자가 쉽게 사용하고 보기에 어색하지 않은 UI를 만들기 위해 고민했습니다.

**Picker**

Project에는 todo, doing, done 3가지 상태가 존재합니다. 사용자가 이러한 Project의 상태를 쉽게 변경할 수 있도록 모든 케이스와 선택된 케이스를 한 번에 보여주기 위해 Picker를 사용했습니다.

Picker는 서로 다른 데이터 모음에서 선택 제공하는 뷰로, Segmented 스타일의 Picker에 ProjectState의 모든 케이스를 Text로 넣어 사용자가 한 번에 보고 선택할 수 있도록 했습니다.

```swift
Picker("", selection: $store.project.projectState.sending(\.setProjectState)) {
  ForEach(ProjectState.allCases, id: \.self) { state in
    Text(state.rawValue)
  }
}
.pickerStyle(SegmentedPickerStyle())
```

**overlay**

TextField와 TextEditor가 함께 사용되는 뷰에서 TextField의 RoundedBorder 스타일과 TextEditor의 스타일을 통일하여 사용자에게 자연스러운 UI를 제공하기 위해 overlay를 활용했습니다.

overlay는 뷰의 앞에 특정 뷰를 레이어링 하기 위한 메서드로 TextEditor에 RoundedRectangle을 레이어링 하여 RoundedBorder 스타일과 동일한 UI를 구현했습니다.

```swift
TextEditor(text: $store.project.body.sending(\.setBody))
  .overlay {
    RoundedRectangle(cornerRadius: 8)
      .stroke(.placeholder, lineWidth: 0.5)
  }
```

<br>

### 2️⃣ TCA

SwiftUI의 View는 데이터 바인딩을 지원하기 때문에 MVVM의 View와 ViewModel의 구분이 모호해진다는 문제가 있었습니다. 하여 TCA를 사용해서 프로젝트를 설계했습니다.

TCA는 크게 View, Action, Reducer, State, Environment로 이루어져 있으며 하나의 View에 하나의 Store가 존재하며 Action을 통해 State를 변화시키는 단방향 플로우이기 때문에 흐름을 추적 관리하기 쉽다고 생각했습니다.

<Img src = "https://github.com/h-suo/TIL/assets/109963294/f27da10a-971d-46b5-8bf2-044ac4261a11" width="800"/>

**State**

State는 UI를 그릴 때 필요한 데이터에 대한 설명을 나타내는 타입입니다.

Projects를 관리하는 ProjectsFeature에는 Projects로 UI를 그려야 하기 때문에 State에서 Projects를 가지고 있도록 했습니다.

```swift
struct State: Equatable {
  var projects: IdentifiedArrayOf<Project>
}
```

**Action**

Action은 사용자가 하는 행동이나 노티피케이션 등 앱에서 생길 수 있는 모든 행동을 나타내는 타입입니다.

View의 이벤트나 사용자 이벤트에 대한 행동을 나타내고 처리하기 위해 onAppear, ButtonTapped, RowEvent 등을 지정했습니다.

```swift
enum Action {
  case onAppear
  case addButtonTapped
  case projectRowSelected(Project)
  case projectRowDeleted(Project)
}
```

**Reducer**

Reducer는 Action이 주어졌을 때 State를 변경시키는 방법을 가지고 있는 함수입니다.

모든 Action에 대한 State 변경 로직을 구현했습니다.

```swift
var body: some Reducer<State, Action> {
  Reduce { state, action in
    switch action {
    case .onAppear:
      do {
        let projects = try database.fetch()
        state.projects = IdentifiedArray(uniqueElements: projects)
      } catch {
        state.alert = errorAlertState(error)
      }
      return .none
    case .addButtonTapped:
      // Button event handling
    case let .projectRowSelected(project):
      // Project Select handling
    case let .projectRowDeleted(project):
      do {
        try database.delete(project)
      } catch {
        state.alert = errorAlertState(error)
      }
      return .run { @MainActor send in
        send(.onAppear, animation: .easeIn)
      }
    }
  }
```

**View**

View에서는 State, Action, Reducer를 가지고 있는 Store를 가지고 UI를 그리거나 이벤트를 전달합니다.

```swift
struct ProjectsView: View {
  @Bindable private var store: StoreOf<ProjectsFeature>
  
  init(store: StoreOf<ProjectsFeature>) {
    self.store = store
  }
  
  var body: some View {
    // View
  }
}
```

<br>

### 3️⃣ SwiftData

로컬 DB를 간단히 구현하기 위해 SwiftData를 활용했습니다. 또한 TCA에 SwiftData를 적용하기 위해 고민했습니다.

**Model**

기존 Project 객체를 Model 매크로를 이용해 SwiftData가 관리할 수 있도록 했습니다.

Attribute를 이용해 deadline이 모든 인스턴스에서 고유하도록 지정하여 Model 데이터의 충돌을 피할 수 있도록 했습니다.

```swift
@Model
final class Project {
  @Attribute(.unique) var deadline: Date
  var title: String
  var body: String
  var projectState: ProjectState
  var isExceed: Bool { Calendar.compareDate(deadline) ?? false }
  
  init(
    title: String,
    body: String,
    deadline: Date,
    projectState: ProjectState = .todo
  ) {
    self.title = title
    self.body = body
    self.deadline = deadline
    self.projectState = projectState
  }
}
```

**DependencyKey**

SwiftData를 TCA에서 쉽게 사용할 수 있도록 DependencyKey를 이용해서 의존성 관리를 했습니다.

ProjectDatabase를 생성하여 Project를 검색, 저장, 삭제하는 객체의 인터페이스를 지정했습니다.

```swift
struct ProjectDatabase {
  var fetch: () throws -> [Project]
  var add: (Project) throws -> Void
  var delete: (Project) throws -> Void
}
```

의존성 관리를 위해 DependencyKey를 채택하고 인터페이스의 동작을 정의했습니다.

ModelContext를 이용해 Project의 검색, 저장, 삭제를 구현했습니다.

```swift
extension ProjectDatabase: DependencyKey {
  static var liveValue: ProjectDatabase = Self(
    fetch: {
      do {
        @Dependency(\.database.context) var context
        let projectContext = try context()
        let descriptor = FetchDescriptor<Project>(sortBy: [SortDescriptor(\.deadline)])
        return try projectContext.fetch(descriptor)
      } catch {
        // Error handling
      }
    },
    add: { project in
      do {
        @Dependency(\.database.context) var context
        let projectContext = try context()
        projectContext.insert(project)
      } catch {
        // Error handling
      }
    },
    delete: { project in
      do {
        @Dependency(\.database.context) var context
        let projectContext = try context()
        projectContext.delete(project)
      } catch {
        // Error handling
      }
    }
  )
}
```

ProjectDatabase를 DependencyValues에 등록하여 Reducer에서 쉽게 접근할 수 있도록 했습니다.

```swift
extension DependencyValues {
  var projectDatabase: ProjectDatabase {
    get { self[ProjectDatabase.self] }
    set { self[ProjectDatabase.self] = newValue }
  }
}
```
<br>

<a id="7."></a>
## 7. 🔗 참고 링크
- [Apple Developer: Picker](https://developer.apple.com/documentation/swiftui/picker)
- [Apple Developer: overlay(alignment:content:)](https://developer.apple.com/documentation/swiftui/view/overlay(alignment:content:))
- [Apple Developer: SwiftData](https://developer.apple.com/documentation/swiftdata)
- [Apple Developer: Model()](https://developer.apple.com/documentation/swiftdata/model())
- [Apple Developer: Attribute(_:originalName:hashModifier:)](https://developer.apple.com/documentation/swiftdata/attribute(_:originalname:hashmodifier:))
- [Apple Developer: ModelContext](https://developer.apple.com/documentation/swiftdata/modelcontext)
- [GitHub: swift Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)
- [GitHub: SwiftDataTCA](https://github.com/SouzaRodrigo61/SwiftDataTCA)
- [Composable Architecture Documentation: Getting started](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/gettingstarted)

<br>

---

[⬆️ 처음으로 돌아가기](#.)
