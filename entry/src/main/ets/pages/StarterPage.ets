import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  ColorMetrics
} from '@kit.ArkUI';

@Component
export struct StarterPage {
  @Consume('pageStack') pageStack: NavPathStack;
  @State message: string = 'Workout\nTracker';
  bottomOptions: ArcButtonOptions = new ArcButtonOptions({});

  aboutToAppear() {
    this.bottomOptions = new ArcButtonOptions({
      label: 'Start',
      fontColor: ColorMetrics.resourceColor('#fff'),
      status: ArcButtonStatus.NORMAL,
      backgroundColor: ColorMetrics.resourceColor('#007AFF'),
      styleMode: ArcButtonStyleMode.CUSTOM,
      position: ArcButtonPosition.BOTTOM_EDGE,
      onClick: () => {
        this.pageStack.pushPathByName('Home', null);
      }
    });
  }

  build() {
    NavDestination() {
      Flex({
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center,
        direction: FlexDirection.Column
      }) {
        Blank().height(12)
        Text(this.message)
          .fontColor('#FFF')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Image($r('app.media.logo')).width('45%')
        ArcButton({ options: this.bottomOptions })
      }
      .width('100%').height('100%')
      .backgroundColor('#000')
    }
    .width('100%').height('100%')
    .onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
  }
}
