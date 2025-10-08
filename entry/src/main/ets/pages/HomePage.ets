import { ArcList, ArcListItem } from '@kit.ArkUI';
import { sampleWorkouts, Workout } from '../model/Workout';

@Component
export struct HomePage {
  @Consume('pageStack') pageStack: NavPathStack;
  private workouts: Workout[] = sampleWorkouts;

  build() {
    NavDestination() {
      Column() {
        ArcList() {
          ArcListItem() {
            Text("Your Workouts")
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .textAlign(TextAlign.Center)
              .width('100%')
              .opacity(0.7)
              .margin({ top: 4, bottom: 2 })
          }

          ForEach(this.workouts, (item: Workout) => {
            ArcListItem() {
              Column() {
                Text(item.title)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(16)
                  .textAlign(TextAlign.Center)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')
              }
              .backgroundColor('#1A1A1A')
              .borderRadius(26)
              .margin(5)
              .width('85%')
              .padding({
                top: 8,
                bottom: 8,
                left: 10,
                right: 10
              })
              .onClick(() => {
                this.pageStack.pushPathByName('WorkoutDetail', item);
              })
            }
          }, (item: Workout) => item.id)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000')
    }
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pageStack = context.pathStack;
    })
  }
}
