using Toybox.WatchUi;

class PausedDelegate extends WatchUi.BehaviorDelegate {
    hidden var accelData;

    function initialize(accelData) {
        BehaviorDelegate.initialize();
        self.accelData = accelData;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return false;
    }

    function onClickDone() {
        WatchUi.pushView(new SaveView(), new SaveDelegate(accelData), WatchUi.SLIDE_LEFT);
          return true;
    }
}
