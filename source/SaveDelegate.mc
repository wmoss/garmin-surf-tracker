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
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onClickDiscard() {
        accelData.discard();
        return true;
    }
}
