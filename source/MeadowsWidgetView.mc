using Toybox.WatchUi;

class MeadowsWidgetView extends WatchUi.View {
	hidden var mMessage = "Is Cascade Open?";

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
		mMessage = "Is Cascade Open?";  
	}

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_MEDIUM, mMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function onReceive(args) {
    	 if (args instanceof Lang.String) {
            mMessage = args;
        }
	    if (args instanceof Dictionary) {
			if (args.get("status").equals("Closed")) {
				mMessage = "Cascade is Closed"; 
			}    
			else if (args.get("status").equals("Standby")) {
				mMessage = "Cascade is \n on Standby. \n Hours: ";
				mMessage += args.get("hours");
				 
			}  
			else if (args.get("status").equals("Open")) {
				mMessage = "Cascade is Open!"; 
			}
			else {
				mMessage = args.get("status");
			}      
	    }
	    WatchUi.requestUpdate();
    }

}
