function makeQuery() {
    // Preparing request for event data
    let url = "GetEventData"; // Changed to servlet URL for events

    // Making request
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET", url, true);
    xhttp.responseType = "json";

    // Callback
    xhttp.onreadystatechange = function () {
        var done = 4, ok = 200;
        if (xhttp.readyState === done && xhttp.status === ok) {

            // Getting returned array of events
            let event_JSON_array = this.response; // Array of Event objects

            // Finding table to fill in
            let table = document.getElementById("output");

            // Removing old table content if existing
            while (table.childNodes.length) {
                table.removeChild(table.childNodes[0]);
            }
            table.style.border = "0px solid";

            // Displaying error if the list is empty
            if (event_JSON_array === null || event_JSON_array.length === 0) {
                document.getElementById("result").innerHTML = "No event data available";
            }

            if (event_JSON_array.length > 0) {

                // Displaying success
                document.getElementById("result").innerHTML = "Events retrieved";

                // Showing table
                table.style.border = "1px solid";

                // Creating table header
                let thead = table.createTHead();
                let row = thead.insertRow();
                let header = [
                    "Event ID",
                    "Category",
                    "Name",
                    "Date",
                    "Time",
                    "Location",
                    "Image URL",
                    "Seat Ticket Price",
                    "Standing Ticket Price"
                ];
                for (let key of header) {
                    let th = document.createElement("th");
                    th.style.border = "1px solid";
                    let text = document.createTextNode(key);
                    th.appendChild(text);
                    row.appendChild(th);
                }

                // Creating table rows
                for (let i = 0; i < event_JSON_array.length; i++) {
                    let row = table.insertRow();
                    let current_event = event_JSON_array[i];  // Access Event object directly
                    for (let key in current_event) { // Loop through the event data using the header
                        let cell = row.insertCell();
                        cell.style.border = "1px solid";

                        // Handle potential missing data gracefully (e.g., check if key exists)
                        let text = document.createTextNode(current_event[key] ? current_event[key] : "");
                        cell.appendChild(text);
                    }
                }
            }
        }
    }

    // Sending request
    xhttp.send();
}

// Call makeQuery on page load to retrieve and display all event data
window.onload = makeQuery;
