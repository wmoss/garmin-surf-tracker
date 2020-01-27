using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Position;


class SurfTrackerApp extends Application.AppBase {
    hidden var accelData;

    function initialize() {
        AppBase.initialize();
        accelData = new AccelData();
    }

    function onStart(state) {
        accelData.registerEventListeners();
    }

    function onStop(state) {
    }

    function getInitialView() {
        return [ new WaitForGPSView(accelData), new WaitForGPSDelegate(accelData) ];
    }
}
