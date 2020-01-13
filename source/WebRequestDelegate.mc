using Toybox.Communications;
using Toybox.WatchUi;

class WebRequestDelegate extends WatchUi.BehaviorDelegate {
    var notify;

    // Handle screen tap to refresh
    function onTap(clickEvent) {
        makeRequest();
        return true;
    }

    function makeRequest() {
        notify.invoke("Loading\nCascade\nStatus");

        Communications.makeWebRequest(
            "http://35.132.140.237/cascade_status",
            {
            },
            {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
            },
            method(:onReceive)
        );
    }

    // Set up the callback to the view
    function initialize(handler) {
        WatchUi.BehaviorDelegate.initialize();
        notify = handler;
    }

    // Receive the data from the web request
    function onReceive(responseCode, data) {
        if (responseCode == 200) {
            notify.invoke(data);
        } else {
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
}