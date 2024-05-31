function validateData(){
    let x = document.forms["data_form"]["fname"].value;

    // se no:  let x = document.forms[0][0].value;
    // se no metti id del form e fai come abbiamo visto a lezione:
    // let x = document.getElementById("data_form").elements[0].value;
    // oppure pescando col name:
    // let x = document.getElementsByName("data_form")[0][0].value;


    if (x === "") {
        alert("Name must be filled out");
        return;
    }
    else makeQuery();
}

function makeQuery() {
    // Preparing request
    let city = document.getElementById("city").value;
    let url = "GetData?city=" + city;

    // Making request
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET", url, true);
    xhttp.responseType = "json";

    // Callback
    xhttp.onreadystatechange = function () {
        var done = 4, ok = 200;
        if (xhttp.readyState === done && xhttp.status === ok) {

            // Getting returned array of cities
            let my_JSON_array = this.response; //it is an array (object) of string. this.response parse to convert a super string into an array of small strings


            // Finding table to fill in
            let table = document.getElementById("output");

            // Removing old table if existing and hiding it
            while (table.childNodes.length) {
                table.removeChild(table.childNodes[0]);
            }
            table.style.border = "0px solid";

            // Displaying error if the list is empty
            if (my_JSON_array === null || my_JSON_array.length === 0) {
                document.getElementById("result").innerHTML = "No data available for this city";
            }

            if (my_JSON_array.length > 0) {

                // Displaying success
                document.getElementById("result").innerHTML = "Data successfully retrieved";

                // Showing table
                table.style.border = "1px solid";

                // Creating table header (createTHead() creates an empty <thead> element and adds it to the table)
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
                    row = table.insertRow();
                    let current_JSON_object  = JSON.parse(my_JSON_array[i]);
                    for (let key in current_JSON_object) {
                        let cell = row.insertCell();
                        cell.style.border = "1px solid";
                        let text = document.createTextNode(current_JSON_object[key]);
                        cell.appendChild(text);
                    }
                }

                }

        }
    }

    // Sending request
    xhttp.send();
}