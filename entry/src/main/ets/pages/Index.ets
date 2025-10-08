import { HomePage } from './HomePage';
import { StarterPage } from './StarterPage';
import { WorkoutDetailPage } from './WorkoutDetailPage';

@Entry
@Component
struct Index {
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack();

  @Builder
  Pages(name: string) {
    if (name === 'Starter') {
      StarterPage();
    } else if (name === 'Home') {
      HomePage();
    } else if (name === 'WorkoutDetail') {
      WorkoutDetailPage();
    }
  }

  build() {
    Navigation(this.pageStack)
      .mode(NavigationMode.Stack)
      .navDestination(this.Pages)
      .hideNavBar(true)
      .onAppear(() => {
        if (this.pageStack.getAllPathName().length === 0) {
          this.pageStack.pushPathByName('Starter', null);
        }
      })
  }
}