function makeQuery() {
    // Preparing request (no need for input this time)
    let url = "GetAllData";  // Servlet URL (no parameters needed)

    // Making request
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET", url, true);
    xhttp.responseType = "json";

    // Callback
    xhttp.onreadystatechange = function () {
        var done = 4, ok = 200;
        if (xhttp.readyState === done && xhttp.status === ok) {

            // Getting returned array of cities
            let my_JSON_array = this.response; // Array of City objects

            // Finding table to fill in
            let table = document.getElementById("output");

            // Removing old table content if existing
            while (table.childNodes.length) {
                table.removeChild(table.childNodes[0]);
            }
            table.style.border = "0px solid";

            // Displaying error if the list is empty
            if (my_JSON_array === null || my_JSON_array.length === 0) {
                document.getElementById("result").innerHTML = "No data available";
            }

            if (my_JSON_array.length > 0) {

                // Displaying success
                document.getElementById("result").innerHTML = "Data retrieved";

                // Showing table
                table.style.border = "1px solid";

                // Creating table header
                let thead = table.createTHead();
                let row = thead.insertRow();
                let header = ["City", "Region", "Area", "Population"];
                for (let key of header) {
                    let th = document.createElement("th");
                    th.style.border = "1px solid";
                    let text = document.createTextNode(key);
                    th.appendChild(text);
                    row.appendChild(th);
                }

                // Creating table rows
                for (let i = 0; i < my_JSON_array.length; i++) {
                    let row = table.insertRow();
                    let current_city = my_JSON_array[i];  // Access City object directly
                    for (let key in current_city) {
                        let cell = row.insertCell();
                        cell.style.border = "1px solid";
                        let text = document.createTextNode(current_city[key]);
                        cell.appendChild(text);
                    }
                }
            }
        }
    }

    // Sending request
    xhttp.send();
}

// Call makeQuery on page load to retrieve and display all city data
window.onload = makeQuery;
