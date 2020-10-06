using Toybox.WatchUi;


class PausedDelegate extends WatchUi.BehaviorDelegate {
    hidden var accelData;

    function initialize(accelData) {
        BehaviorDelegate.initialize();
        self.accelData = accelData;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            backToSurfTracker();
            return true;
        }
        return false;
    }

    function onBack() {
        backToSurfTracker();
        return true;
    }

    hidden function backToSurfTracker() {
        WatchUi.switchToView(new SurfTrackerView(accelData), new SurfTrackerDelegate(accelData), WatchUi.SLIDE_RIGHT);
    }

    function onClickSave() {
        var result = accelData.save();
        if (result) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
       }
       return result;
    }
}
