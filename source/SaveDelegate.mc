using Toybox.WatchUi;


class SaveDelegate extends WatchUi.BehaviorDelegate {
    hidden var accelData;

    function initialize(accelData) {
        BehaviorDelegate.initialize();
        self.accelData = accelData;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
        return true;
    }

    function onClickSave() {
        var result = accelData.save();
        if (result) {
            exitByPopView();
       }
       return result;
    }

    function onClickDiscard() {
        var result = accelData.discard();
        if (result) {
            exitByPopView();
        }
        return result;
    }

    hidden function exitByPopView() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
