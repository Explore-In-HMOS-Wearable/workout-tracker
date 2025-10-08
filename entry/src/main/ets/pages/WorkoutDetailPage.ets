import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  ColorMetrics
} from '@kit.ArkUI';
import { Workout, Exercise } from '../model/Workout';
import { LocalStore } from '../storage/LocalStore';

@Component
export struct WorkoutDetailPage {
  @Consume('pageStack') pageStack: NavPathStack;
  @State workout: Workout | null = null;
  @State currentExerciseIndex: number = 0;
  @State currentWeight: number = 20;
  saveOptions: ArcButtonOptions = new ArcButtonOptions({});

  aboutToAppear() {
    this.saveOptions = new ArcButtonOptions({
      label: 'Save',
      fontColor: ColorMetrics.resourceColor('#FFFFFF'),
      status: ArcButtonStatus.NORMAL,
      backgroundColor: ColorMetrics.resourceColor('#007AFF'),
      styleMode: ArcButtonStyleMode.CUSTOM,
      position: ArcButtonPosition.BOTTOM_EDGE,
      onClick: () => {
        const ex = this.getCurrentExercise();
        if (ex) {
          void LocalStore.setLastWeight(ex.name, this.currentWeight);
        }
      }
    });
  }

  private getCurrentExercise(): Exercise | null {
    return this.workout?.exercises[this.currentExerciseIndex] || null;
  }

  build() {
    NavDestination() {
      if (this.workout) {
        Column() {
          Row() {
            ForEach(this.workout.exercises, (exercise: Exercise, index: number) => {
              Circle({ width: 4, height: 4 })
                .fill(this.currentExerciseIndex === index ? '#007AFF' : '#333333')
                .margin({ left: 2, right: 2 })
            })
          }
          .justifyContent(FlexAlign.Center)
          .margin({ top: 2, bottom: 4 })

          Column() {
            Swiper() {
              ForEach(this.workout.exercises, (exercise: Exercise) => {
                Column() {
                  Text(exercise.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                    .textAlign(TextAlign.Center)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .margin({ top: 4, bottom: 2 })

                  Text(`${exercise.sets[0]?.weightKg || 0}kg`)
                    .fontSize(12)
                    .fontColor('#8E8E93')
                    .textAlign(TextAlign.Center)
                    .margin({ bottom: 8 })

                  Text(`${Number.isInteger(this.currentWeight) ? this.currentWeight : this.currentWeight.toFixed(1)}`)
                    .fontSize(44)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                    .textAlign(TextAlign.Center)
                    .margin({ bottom: 12 })

                  Row() {
                    Button('-')
                      .backgroundColor('#FF3B30')
                      .fontColor('#FFFFFF')
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                      .width(44)
                      .height(44)
                      .borderRadius(22)
                      .onClick(() => {
                        if (this.currentWeight > 0) {
                          this.currentWeight = Math.round((this.currentWeight - 2.5) * 10) / 10;
                        }
                      })

                    Blank().width(44)

                    Button('+')
                      .backgroundColor('#34C759')
                      .fontColor('#FFFFFF')
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                      .width(44)
                      .height(44)
                      .borderRadius(22)
                      .onClick(() => {
                        this.currentWeight = Math.round((this.currentWeight + 2.5) * 10) / 10;
                      })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Center)
                  .margin({ bottom: 8 })

                  ArcButton({ options: this.saveOptions })
                }
                .width('100%')
                .height('100%')
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
              })
            }
            .indicator(false)
            .onChange((index: number) => {
              this.currentExerciseIndex = index;
              const exercise = this.getCurrentExercise();
              if (exercise && exercise.sets.length > 0) {
                LocalStore.getLastWeight(exercise.name, exercise.sets[0].weightKg).then(v => {
                  this.currentWeight = v;
                });
              }
            })
          }
          .width('74%')
          .alignItems(HorizontalAlign.Center)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageStack = context.pathStack;
      const params = context.pathInfo.param as Workout;
      if (params) {
        this.workout = params;
        if (params.exercises.length > 0 && params.exercises[0].sets.length > 0) {
          const ex = params.exercises[0];
          LocalStore.getLastWeight(ex.name, ex.sets[0].weightKg).then(v => {
            this.currentWeight = v;
          });
        }
      }
    })
  }
}