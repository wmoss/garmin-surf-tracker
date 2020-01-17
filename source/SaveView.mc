using Toybox.WatchUi;

class SaveView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        var height = dc.getHeight();
        var width = dc.getWidth();

        var saveButton = new WatchUi.Button({
            :behavior => :onClickSave,
            :stateHighlighted => Graphics.COLOR_GREEN,
            :stateDefault => Graphics.COLOR_DK_GREEN,
            :locX => 0,
            :locY => 0,
            :width => dc.getWidth(),
            :height => 2 * height / 3,
        });
        var saveText = new WatchUi.Text({
            :text => "Save",
            :color => Graphics.COLOR_WHITE,
            :locX => width / 2,
            :locY => height / 3,
            :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER,
        });

        var discardButton = new WatchUi.Button({
            :behavior => :onClickDiscard,
            :stateHighlighted => Graphics.COLOR_RED,
            :stateDefault => Graphics.COLOR_DK_RED,
            :locX => 0,
            :locY => height - height / 3,
            :width => dc.getWidth(),
            :height => height / 3,
        });
        var discardText = new WatchUi.Text({
            :text => "Discard",
            :color => Graphics.COLOR_WHITE,
            :locX => width / 2,
            :locY => height - height / 6,
            :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER,
        });
        setLayout([ saveButton, saveText, discardButton, discardText ]);
    }

    function onShow() {
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
    }

    function onHide() {
    }
}
