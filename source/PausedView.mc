using Toybox.WatchUi;


class PausedView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        var height = dc.getHeight();
        var width = dc.getWidth();

        var pausedText = new WatchUi.Text({
            :text => "Paused",
            :color => Graphics.COLOR_WHITE,
            :locX => width / 2,
            :locY => height / 3,
            :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER,
        });

        var saveButton = new WatchUi.Button({
            :behavior => :onClickSave,
            :stateHighlighted => Graphics.COLOR_BLUE,
            :stateDisabled => Graphics.COLOR_DK_BLUE,
            :stateDefault => Graphics.COLOR_DK_BLUE,
            :locX => 0,
            :locY => height - height / 3,
            :width => dc.getWidth(),
            :height => height / 3,
        });
        var saveText = new WatchUi.Text({
            :text => "Save",
            :color => Graphics.COLOR_WHITE,
            :locX => width / 2,
            :locY => height - height / 6,
            :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER,
        });
        setLayout([ pausedText, saveButton, saveText ]);
    }

    function onShow() {
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
    }

    function onHide() {
    }
}
